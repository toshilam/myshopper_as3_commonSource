package myShopper.common.net 
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IServiceConnection;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.utils.Tracer;
	
	[Event(name="fault", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="connectFail", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="connectSuccess", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="disconnected", type="myShopper.common.events.ServiceEvent")] 
	/**
	 * AMF connection
	 * @author Toshi Lam
	 */
	public class ServiceConnection extends EventDispatcher implements IServiceConnection, IResponder
	{
		public static const UNIQUE_ID_PN:String = 'uniqueID';
		
		protected var _nc:NetConnection;
		public function get connection():NetConnection { return _nc; }
		
		protected var _responder:Responder;
		public function get responder():Responder { return _responder; }
		
		protected var _responderMap:Object;
		
		protected var _isConnected:Boolean;
		
		private static var _numRequested:uint; //used for creating unique id;
		
		protected static function getUniqueID():String
		{
			return String(_numRequested++).toString();
		}
		
		public function ServiceConnection(inConnection:NetConnection) 
		{
			_nc = inConnection;
			
			_responderMap = new Object();
			
			_responder = new Responder(result, fault);
		}
		
		public function connect(inURL:String, rest:Object = null):Boolean
		{
			Tracer.echo('ServiceConnection : connect : connecting : ' + inURL, this);
				
			if (!_nc.hasEventListener(NetStatusEvent.NET_STATUS)) 
			{
				_nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusEventHandler);
			}
			if (rest)
			{
				_nc.connect(inURL, rest);
			}
			else
			{
				_nc.connect(inURL);
			}
			
			_isConnected = true;
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_SUCCESS));
			return true;
		}
		
		public function disconnect():void
		{
			if (_nc) 
			{
				_nc.close();
				_isConnected = false;
				dispatchEvent(new ServiceEvent(ServiceEvent.DISCONNECTED));
			}
		}
		
		//in amf server, if connect fail dispatch NetStatusEvent / NO not only fail
		protected function netStatusEventHandler(e:NetStatusEvent):void 
		{
			Tracer.echo('ServiceConnection : netStatusEventHandler : ' + e.info.code);
			
			switch(e.info.code)
			{
				//ignore case, do nothing for these event
				case 'NetConnection.Connect.NetworkChange':
				//ADDED 07072014 for offline mode for shopMgt createSales
				//dispatchEvent NetStatusEvent instead of ServiceEvent.CONNECT_FAIL
				case 'NetConnection.Call.Failed':
				{
					dispatchEvent(new ServiceEvent(ServiceEvent.NET_STATUS, null, e));
					return;
				}
			}
			
			Tracer.echo('ServiceConnection : netStatusEventHandler : connect fail! ', this, 0xff0000);
			
			//CHANGED : 22022014 : commented, avoid 502 error from 
			//_isConnected = false;
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL));
		}
		
		/**
		 * NOTE : it's alwasy return true if the connection is not connected to FMS server
		 * @return
		 */
		public function isConnected():Boolean
		{
			//return _nc.connected;
			return _isConnected;
		}
		
		
		public function request(inRequest:IServiceRequest):Boolean
		{
			var req:ServiceRequest = inRequest as ServiceRequest;
			
			if (!req || !isConnected())
			{
				Tracer.echo('ServiceConnection : calling : server is not connected yet!', this, 0xFF0000);
				return false;
			}
			
			Tracer.echo('ServiceConnection : calling : ' + req.type, this, 0xFF0000);
			
			if (!(req.requester.result is Function) || !(req.requester.fault is Function))
			{
				Tracer.echo('ServiceConnection : missing responder! ', this, 0xFF0000);
				return false;
			}
			
			if (!req.isDirect && _responderMap[req.type])
			{
				Tracer.echo('ServiceConnection : some request made! ', this, 0xFF0000);
				return false;
			}
			
			//add an unique id into data object for identifying request when server call back
			var uniqueID:String = getUniqueID();
			if (req.data == null)
			{
				req.data = new Object();
			}
			
			req.data[UNIQUE_ID_PN] = uniqueID;
			
			if (!req.isDirect)
			{
				//to store request for calling back later
				_responderMap[uniqueID] = req;
			}
			
			var responder:Responder = req.isDirect ? new Responder(req.requester.result, req.requester.fault) : _responder;
			remoteCall(req.type, req.data, responder);
			return true;
		}
		
		protected function remoteCall(inServiceType:String, inData:Object, inResponder:Responder):void
		{
			_nc.call(inServiceType, inResponder, inData);
		}
		
		public function result(data:Object):void 
		{
			//var result:ResultVO = data as ResultVO;
			Tracer.echo('ServiceConnection : result : UniqueID : ' + data[UNIQUE_ID_PN], this, 0xFF0000);
			
			//var serviceRequest:IServiceRequest = _responderMap[data.service];
			var serviceRequest:IServiceRequest = _responderMap[data[UNIQUE_ID_PN]];
			if (!serviceRequest)
			{
				Tracer.echo('ServiceConnection : result : no service requester found : ' + data.service, this, 0xFF0000);
				return;
			}
			
			serviceRequest.requester.result(data);
			
			delete _responderMap[data[UNIQUE_ID_PN]];
			serviceRequest = null;
		}
		
		public function fault(info:Object):void 
		{
			Tracer.echo('ServiceConnection : fault : ' + info, this, 0xFF0000);
			for (var i:String in info)
			{
				Tracer.echo('ServiceConnection : fault : ' + info[i], this, 0xFF0000);
			}
			
			dispatchEvent(new ServiceEvent(ServiceEvent.FAULT));
		}
		
	}

}