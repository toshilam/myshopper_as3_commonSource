package myShopper.common.net 
{
	import myShopper.common.interfaces.IResponder;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class LocalDataServiceRequest extends ServiceRequest 
	{
		private var _key:String;
		
		/**
		 * 
		 * @param	inKey - data key for retreve/remove data
		 * @param	inType - type of service that will be used Service handler object
		 * @param	inData - optional data that wanna pass to other subscriber
		 * @param	inRequester - responder object that will be used when add (ADD_COMMUNICATOR) itself to subscriber list
		 */
		public function LocalDataServiceRequest(inKey:String, inType:String, inData:Object = null, inRequester:IResponder = null) 
		{
			super(inType, inData, inRequester)
			_key = inKey;
		}
		
		
		public function get key():String 
		{
			return _key;
		}
		
		
		
	}

}