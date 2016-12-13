package myShopper.common.data 
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class SearchVO extends VO 
	{
		public static const DEFAULT_RECORD_COUNT:int = 50;
		
		public var fromDate:String;
		public var toDate:String;
		public var count:int;
		public var index:int;
		
		public function SearchVO(inID:String, inLangCode:String='') 
		{
			super(inID, inLangCode);
			
		}
		
	}

}