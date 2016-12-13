package myShopper.common.net 
{
	import flash.net.Responder;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IServiceRequest;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ServiceRequest implements IServiceRequest 
	{
		private var _type:String;
		private var _data:Object;
		private var _requester:IResponder;
		//directly call back to the request object
		private var _isDirect:Boolean;
		
		public function ServiceRequest(inType:String, inData:Object = null, inRequester:IResponder = null, inIsDirect:Boolean = false ) 
		{
			_type = inType;
			_data = inData;
			_requester = inRequester;
			_isDirect = inIsDirect;
		}
		
		public function get requester():IResponder 
		{
			return _requester;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		public function get isDirect():Boolean 
		{
			return _isDirect;
		}
		
		public function set isDirect(value:Boolean):void 
		{
			_isDirect = value;
		}
		
	}

}