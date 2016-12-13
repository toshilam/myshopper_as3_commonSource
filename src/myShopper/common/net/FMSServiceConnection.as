package myShopper.common.net 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.data.FMS.FMSRequestVO;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.server.AMFResultFactory;
	import myShopper.common.utils.Tracer;
	
	[Event(name = "response", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "connectFail", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "connectSuccess", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "disconnected", type = "myShopper.common.events.ServiceEvent")] 
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FMSServiceConnection extends ServiceConnection 
	{
		public static const FMS_METHOD_NAME:String = 'request'; 
		
		private var _isConnecting:Boolean;
		
		//once connection is successfully made, a list of object need to be call to fms(due to connection is not already)
		private var _subscribedCallList:Vector.<FMSRequestVO>; 
		
		public function FMSServiceConnection(inConnection:NetConnection) 
		{
			super(inConnection);
			
			_nc.client = this;
			_isConnecting = false;
			_subscribedCallList = new Vector.<FMSRequestVO>();
		}
		
		
		
		override public function isConnected():Boolean 
		{
			return _nc.connected;
		}
		
		override public function connect(inURL:String, rest:Object = null):Boolean 
		{
			if (isConnected())
			{
				Tracer.echo('ServiceConnection : connect : server already connected!', this, 0xFF0000);
			}
			else if (_isConnecting)
			{
				Tracer.echo('ServiceConnection : connect : waiting server connect success singal!', this, 0xFF0000);
			}
			else 
			{
				//not to call super, as fms connect event will be dispatched once netstatus event received
				//super.connect(inURL, rest)
				Tracer.echo('ServiceConnection : connect : connecting : ' + inURL, this);
				
				if (!_nc.hasEventListener(NetStatusEvent.NET_STATUS)) 
				{
					_nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusEventHandler);
					_nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncEventHandler);
					_nc.addEventListener(IOErrorEvent.IO_ERROR, ioEventHandler);
					_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityEventHandler);
				}
				if (rest)
				{
					_nc.connect(inURL, rest);
				}
				else
				{
					_nc.connect(inURL);
				}
				
				
				_isConnecting = true;
				return true;
			}
			
			return false;
		}
		
		override public function disconnect():void 
		{
			//not to use super, as fms disconnect event should be dispatched once netstatus event received
			//super.disconnect();
			if (_nc) 
			{
				_nc.close();
				_isConnected = false;
			}
			
			if (_nc.hasEventListener(AsyncErrorEvent.ASYNC_ERROR))
			{
				_nc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncEventHandler);
				_nc.removeEventListener(IOErrorEvent.IO_ERROR, ioEventHandler);
				_nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityEventHandler);
			}
		}
		
		//for fail connect fms call back
		public function close():void
		{
			disconnect();
		}
		
		override public function request(inRequest:IServiceRequest):Boolean
		{
			
			//NOTE : currentlly no call back for FMS / may change in the future?
			/*if (!(inRequest.requester.result is Function) || !(inRequest.requester.fault is Function))
			{
				Tracer.echo('ServiceConnection : missing responder! ', this, 0xFF0000);
				return false;
			}*/
			
			if (!(inRequest.data is FMSRequestVO))
			{
				Tracer.echo('ServiceConnection : request : unknown data type : ' + inRequest , this, 0xFF0000);
				return false;
			}
			
			if (!isConnected())
			{
				Tracer.echo('remoteCall : FMS server is not connected, request vo is added in list, and will be call once connection is made');
				_subscribedCallList.push(inRequest.data);
				
				//return ;
				//Tracer.echo('ServiceConnection : request : server is not connected yet!', this, 0xFF0000);
				//return false;
			}
			else
			{
				var vo:FMSRequestVO = inRequest.data as FMSRequestVO;
				vo.uniqueID = getUniqueID();
				
				Tracer.echo('FMSServiceConnection : request : ' + vo.service /*+ ', uniqueID : ' + vo.uniqueID*/, this, 0xFF0000);
				
				
				//no check needed, as same type of may be requested
				/*if (_responderMap[inRequest])
				{
					Tracer.echo('ServiceConnection : some request made! ', this, 0xFF0000);
					return false;
				}*/
				
				//to store request for calling back later
				//_responderMap[vo.uniqueID] = vo;
				
				remoteCall(inRequest.type, vo, null);
			}
			
			return true;
		}
		
		override protected function remoteCall(inServiceType:String, inData:Object, inResponder:Responder):void
		{
			//_nc.call(inServiceType, _responder, inData);
			//no responder needed for FMS
			_nc.call(inServiceType, null, inData);
		}
		
		override public function result(data:Object):void 
		{
			//var result:ResultVO = data as ResultVO;
			Tracer.echo('FMSServiceConnection : result : ' + data, this, 0xFF0000);
			Tracer.echo(data, this, 0xFF0000);
			
			if (!data)
			{
				return;
			}
			
			//call back the requester / not always found requester in responderMap as some of the call back may directly call by FMS
			//NOTE : currentlly no call back for FMS / may change in the future?
			/*var serviceRequest:IServiceRequest = _responderMap[data.uniqueID];
			if (serviceRequest)
			{
				serviceRequest.requester.result(data);
				
				delete _responderMap[data.service];
				serviceRequest = null;
			}
			else
			{
				Tracer.echo('ServiceConnection : result : no service requester found : ' + data.service, this, 0xFF0000);
			}*/
			
			var result:ResultVO = AMFResultFactory.convert(data);
			//dispatch vo if successfully converted to resultVO, else pass data object
			dispatchEvent(new ServiceEvent(ServiceEvent.RESPONSE, null, result is ResultVO ? result : data));
			
			//Tracer.echo('FMSServiceConnection : result : no service requester found! ', this, 0xFF0000);
		}
		
		override protected function netStatusEventHandler(e:NetStatusEvent):void 
		{
			if (!e || !e.info)
			{
				Tracer.echo('FMSServiceConnection : netStatusEventHandler : null data object :' + e);
				return;
			}
			
			Tracer.echo('FMSServiceConnection : netStatusEventHandler : ' + e.info.code);
			Tracer.echo(e);
			
			var code:String = e.info.code;
			
			switch(code)
			{
				case "NetConnection.Connect.Success":
				{
					while (_subscribedCallList.length)
					{
						var fmsRequest:FMSRequestVO = _subscribedCallList.splice(0, 1)[0] as FMSRequestVO;
						Tracer.echo('fmsEventHandler : connection is made, and calling subscribed request : ' + fmsRequest.service);
						remoteCall(FMS_METHOD_NAME, fmsRequest, null);
					}
					//NOTE: no need to break, as _isConnecting need to set false, and dispatch event
				}
				case "NetConnection.Connect.Closed":
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.IdleTimeout":
				
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Rejected":
				case "NetConnection.Connect.InvalidApp":
				{
					_isConnecting = false;
					dispatchEvent(new ServiceEvent(getEventTypeByCode(code)));
					break;
				}
			}
		}
		
		private function getEventTypeByCode(inCode:String):String
		{
			switch(inCode)
			{
				case "NetConnection.Connect.Success":		
				{
					
					return ServiceEvent.CONNECT_SUCCESS;
					
				}
				
				case "NetConnection.Connect.Closed":
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.IdleTimeout":	
				{
					return ServiceEvent.DISCONNECTED;
				}
				
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Rejected":
				case "NetConnection.Connect.InvalidApp":	
				{
					//disconnect();
					return ServiceEvent.CONNECT_FAIL;
					
				}
			}
			
			return '';
		}
		
		private function securityEventHandler(e:SecurityErrorEvent):void 
		{
			Tracer.echo('ServiceConnection : securityEventHandler : ' + e, this, 0xFF0000);
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL));
		}
		
		private function ioEventHandler(e:IOErrorEvent):void 
		{
			Tracer.echo('ServiceConnection : ioEventHandler : ' + e, this, 0xFF0000);
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL));
		}
		
		private function asyncEventHandler(e:AsyncErrorEvent):void 
		{
			Tracer.echo('ServiceConnection : asyncEventHandler : ' + e, this, 0xFF0000);
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL));
		}
	}

}