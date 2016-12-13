package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ServiceEvent extends ApplicationEvent 
	{
		public static const RESPONSE:String = 'response';
		public static const FAULT:String = 'fault';
		public static const CONNECT_FAIL:String = 'connectFail';
		public static const CONNECT_SUCCESS:String = 'connectSuccess';
		public static const NET_STATUS:String = 'netStatus';
		public static const DISCONNECTED:String = 'disconnected';
		
		protected var _response:IServiceResponse;
		public function get response():IServiceResponse { return _response; }
		
		protected var _result:ResultVO; 
		public function get result():ResultVO 
		{
			return _result;
		}
		
		public function ServiceEvent(type:String, inServiceResponse:IServiceResponse = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, null, inData, bubbles, cancelable);
			
			_response = inServiceResponse;
			
			if (inData is ResultVO) _result = inData as ResultVO;
		} 
		
		public override function clone():Event 
		{ 
			return new ServiceEvent(type, _response, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ServiceEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}