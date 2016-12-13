package myShopper.common.net 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IService;
	import myShopper.common.interfaces.IServiceConnection;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.interfaces.IServiceResponse;
	
	
	/**
	 * service controller helping commnucate with remote srever
	 * @author Toshi Lam
	 */
	public class RemoteService extends EventDispatcher implements IService
	{
		protected var _serviceConnection:IServiceConnection;
		public function get serviceConnection():IServiceConnection 
		{
			return _serviceConnection;
		}
		
		/**
		 * 
		 * @param	inServiceConnection - connection, if nothing passed in, AMF connection will be created
		 */
		public function RemoteService(inServiceConnection:IServiceConnection = null) 
		{
			if (inServiceConnection) 	_serviceConnection = inServiceConnection;
			else 						_serviceConnection = new ServiceConnection(new NetConnection());
		}
		
		public function request(inRequest:IServiceRequest):Boolean
		{
			return _serviceConnection.request(inRequest);
		}
		
		public function connect(inURL:String, rest:Object = null):Boolean
		{
			return _serviceConnection.connect(inURL, rest);
		}
		
		public function disconnect():void
		{
			_serviceConnection.disconnect();
		}
		
		/*public function result(inResponse:IServiceResponse):void
		{
			sendEvent(ServiceEvent.RESPONSE, inResponse);
		}
		
		public function fault(inResponse:IServiceResponse):void
		{
			sendEvent(ServiceEvent.FAULT, inResponse);
		}
		
		protected function sendEvent(inType:String, inValue:Object):void
		{
			dispatchEvent(new ServiceEvent(inType, inValue));
		}*/
	}

}