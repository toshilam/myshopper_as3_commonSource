package myShopper.common.net 
{
	import com.pnwrain.flashsocket.events.FlashSocketEvent;
	import com.pnwrain.flashsocket.FlashSocket;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.data.FMS.FMSRequestVO;
	import myShopper.common.emun.FMSServicesType;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.server.AMFResultFactory;
	import myShopper.common.utils.Tracer;
	
	[Event(name = "response", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "connectFail", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "connectSuccess", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "disconnected", type = "myShopper.common.events.ServiceEvent")] 
	
	//connected to ws, but wait for auth
	[Event(name = "connect", type = "com.pnwrain.flashsocket.events.FlashSocketEvent")] 
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class WSServiceConnection extends ServiceConnection 
	{
		public static const FMS_METHOD_NAME:String = 'request'; 
		
		private var _isConnecting:Boolean;
		private var _isAuthenticated:Boolean;
		private var _ws:FlashSocket;
		//once connection is successfully made, a list of object need to be called to server (due to connection is not already)
		private var _subscribedCallList:Vector.<IServiceRequest>; 
		
		public function WSServiceConnection(/*inConnection:FlashSocket*/) 
		{
			super(null);
			
			//_ws.client = this;
			
			
			//_responderMap = new Object();
			//
			//_responder = new Responder(result, fault);
			_isConnecting = false;
			_subscribedCallList = new Vector.<IServiceRequest>();
			_ws = new FlashSocket();
			_ws.addEventListener(FlashSocketEvent.CONNECT, onConnect);
			_ws.addEventListener(FlashSocketEvent.MESSAGE, onMessage);
			_ws.addEventListener(FlashSocketEvent.IO_ERROR, onError);
			_ws.addEventListener(FlashSocketEvent.SECURITY_ERROR, onError);
			_ws.addEventListener(FlashSocketEvent.CONNECT_ERROR, onError);
			_ws.addEventListener(FlashSocketEvent.DISCONNECT, onDisconnect);
			_ws.addEventListener(FlashSocketEvent.CLOSE, onDisconnect);
		}
		
		
		
		override public function get connection():NetConnection 
		{
			Tracer.echo('WSServiceConnection : connection : call disabled function! call wsConnection instead of!');
			return null;
		}
		
		public  function get wsConnection():FlashSocket
		{
			return _ws;
		}
		
		override public function isConnected():Boolean 
		{
			return _ws && _ws.connected;
		}
		
		public function isAuthenticated():Boolean 
		{
			return _isAuthenticated;
		}
		
		//to be call once xml loaded
		public function init(inHost:String):void
		{
			/*if (_ws)
			{
				disconnect();
			}*/
			
			_isConnecting = true;
			
			_ws.connect(inHost);
			
			
		}
		
		override public function connect(inRequestType:String, inData:Object = null):Boolean 
		{
			//Tracer.echo('WSServiceConnection : connect : call disabled function!');
			/*if (isConnected())
			{
				Tracer.echo('ServiceConnection : connect : server already connected!', this, 0xFF0000);
			}
			else if (_ws.connecting)
			{
				Tracer.echo('ServiceConnection : connect : waiting server connect success singal!', this, 0xFF0000);
			}
			else 
			{
				//not to call super, as fms connect event will be dispatched once netstatus event received
				//super.connect(inURL, rest)
				Tracer.echo('ServiceConnection : connect : connecting : ' + inURL, this);
				
				if (!_ws.hasEventListener(NetStatusEvent.NET_STATUS)) 
				{
					_ws.addEventListener(NetStatusEvent.NET_STATUS, netStatusEventHandler);
					_ws.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncEventHandler);
					_ws.addEventListener(IOErrorEvent.IO_ERROR, ioEventHandler);
					_ws.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityEventHandler);
					
				}
				if (rest)
				{
					_ws.connect(inURL, rest);
				}
				else
				{
					_ws.connect(inURL);
				}
				
				
				_isConnecting = true;
				return true;
			}*/
			
			if (isConnected() && !isAuthenticated())
			{
				Tracer.echo('WSServiceConnection : connect : authenticating...', this, 0xFF0000);
				remoteCall(inRequestType, inData, null);
				return true;
			}
			
			Tracer.echo('WSServiceConnection : connect : is not connected or already authenticated!', this, 0xFF0000);
			return false;
		}
		
		override public function disconnect():void 
		{
			//not to use super, as fms disconnect event should be dispatched once netstatus event received
			//super.disconnect();
			if (_ws /*&& _ws.connected*/) 
			{
				
				
				if (isConnected() && isAuthenticated())
				{
					_ws.send(new FMSRequestVO(FMSServicesType.USER_LOGOUT, null, null), FMS_METHOD_NAME);
				}
				
				//_ws.close();
				_isConnected = false;
				
				//a new object connection will be re-created when re-login
				//_ws = null;
				_ws.disconnect();
				//onDisconnect(null);
			}
			
			
		}
		
		//for fail connect fms call back
		/*public function close():void
		{
			disconnect();
		}*/
		
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
				_subscribedCallList.push(inRequest);
				
				//return ;
				//Tracer.echo('ServiceConnection : request : server is not connected yet!', this, 0xFF0000);
				//return false;
			}
			else
			{
				var vo:FMSRequestVO = inRequest.data as FMSRequestVO;
				vo.uniqueID = getUniqueID();
				
				//Tracer.echo('WSServiceConnection : request : ' + vo.service /*+ ', uniqueID : ' + vo.uniqueID*/, this, 0xFF0000);
				
				
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
			//_ws.call(inServiceType, _responder, inData);
			//no responder needed for FMS
			_ws.send(inData, inServiceType);
		}
		
		private function onMessage(e:FlashSocketEvent):void 
		{
			result(e.data is Array ? (e.data as Array)[0] : e.data);
		}
		
		override public function result(data:Object):void 
		{
			//var result:ResultVO = data as ResultVO;
			//Tracer.echo('WSServiceConnection : result : ' + data, this, 0xFF0000);
			//Tracer.echo(data, this, 0xFF0000);
			
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
			
			if (result.service == FMSServicesType.USER_IS_LOGGED)
			{
				_isAuthenticated = true;
			}
			
			//dispatch vo if successfully converted to resultVO, else pass data object
			dispatchEvent(new ServiceEvent(ServiceEvent.RESPONSE, null, result is ResultVO ? result : data));
			
			//Tracer.echo('WSServiceConnection : result : no service requester found! ', this, 0xFF0000);
		}
		
		private function onConnect(e:FlashSocketEvent):void 
		{
			_isConnected = true;
			_isConnecting = false;
			
			dispatchEvent(new FlashSocketEvent(FlashSocketEvent.CONNECT));
			
			while (_subscribedCallList.length)
			{
				var fmsRequest:IServiceRequest = _subscribedCallList.splice(0, 1)[0] as IServiceRequest;
				Tracer.echo('fmsEventHandler : connection is made, and calling subscribed request : ' + fmsRequest.type);
				request(fmsRequest);
			}
		}
		
		/*override protected function netStatusEventHandler(e:NetStatusEvent):void 
		{
			if (!e || !e.info)
			{
				Tracer.echo('WSServiceConnection : netStatusEventHandler : null data object :' + e);
				return;
			}
			
			Tracer.echo('WSServiceConnection : netStatusEventHandler : ' + e.info.code);
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
						remoteCall(FMS_METHOD_NAME, fmsRequest);
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
		}*/
		
		/*private function getEventTypeByCode(inCode:String):String
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
		}*/
		
		private function onError(e:FlashSocketEvent):void 
		{
			_isAuthenticated = _isConnected = _isConnecting = false;
			Tracer.echo('ServiceConnection : onError : ' + e.type, this, 0xFF0000);
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL));
		}
		
		private function onDisconnect(e:FlashSocketEvent):void 
		{
			Tracer.echo('ServiceConnection : onDisconnect : ' + e, this, 0xFF0000);
			_isAuthenticated = _isConnected = _isConnecting = false;
			
			//_ws.removeEventListener(FlashSocketEvent.CONNECT, onConnect);
			//_ws.removeEventListener(FlashSocketEvent.MESSAGE, onMessage);
			//_ws.removeEventListener(FlashSocketEvent.IO_ERROR, onError);
			//_ws.removeEventListener(FlashSocketEvent.SECURITY_ERROR, onError);
			//_ws.removeEventListener(FlashSocketEvent.CONNECT_ERROR, onError);
			//_ws.removeEventListener(FlashSocketEvent.DISCONNECT, onDisconnect);
			//_ws.removeEventListener(FlashSocketEvent.CLOSE, onDisconnect);
			
			dispatchEvent(new ServiceEvent(ServiceEvent.DISCONNECTED));
		}
		
		/*private function securityEventHandler(e:SecurityErrorEvent):void 
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
		}*/
	}

}