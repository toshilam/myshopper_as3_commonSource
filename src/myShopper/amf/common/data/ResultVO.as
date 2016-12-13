package myShopper.amf.common.data 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	//[RemoteClass(alias="shopper.amf.common.data.ResultVO")]
	public class ResultVO extends VO 
	{
		public var service:String;
		public var code:String;
		public var result:Object;
		public var uniqueID:String; //this unique created by ServiceConnection, and returned by server
		
		public function ResultVO(inID:String = '', inService:String = '', inCode:String = '', inResult:Object = null, inUniqueID:String = '') 
		{
			super(inID);
			service = inService;
			code = inCode;
			result = inResult;
			uniqueID = inUniqueID;
		}
		
	}

}