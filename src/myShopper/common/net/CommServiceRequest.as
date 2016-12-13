package myShopper.common.net 
{
	import flash.net.Responder;
	import myShopper.common.interfaces.ICommServiceRequest;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IServiceRequest;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class CommServiceRequest extends ServiceRequest implements ICommServiceRequest 
	{
		private var _commID:String;
		private var _commType:String;
		
		/**
		 * 
		 * @param	inCommID - the requester id
		 * @param	inCommType - the type of communication which subscriber interested
		 * @param	inType - type of service that will be used Service handler object
		 * @param	inData - optional data that wanna pass to other subscriber
		 * @param	inRequester - responder object that will be used when add (ADD_COMMUNICATOR) itself to subscriber list
		 */
		public function CommServiceRequest(inCommID:String, inCommType:String, inType:String, inData:Object = null, inRequester:IResponder = null) 
		{
			super(inType, inData, inRequester)
			_commID = inCommID;
			_commType = inCommType;
		}
		
		
		public function get communicatorID():String 
		{
			return _commID;
		}
		
		public function get communicationType():String 
		{
			return _commType;
		}
		
		
	}

}