package myShopper.common.data.FMS 
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class FMSRequestVO extends Object
	{
		public var service:String;
		public var code:String;
		public var data:Object;
		
		//an unique id used for calling back the requester, as same type of service may be requested
		public var uniqueID:String; 
		
		//add the request into buffer (and call when get connected) if not connected
		public var addBuffer:Boolean;
		
		public function FMSRequestVO(inService:String, inCode:String, inData:Object) 
		{
			super();
			service = inService;
			code = inCode;
			data = inData;
			
			addBuffer = true;
		}
		
	}

}