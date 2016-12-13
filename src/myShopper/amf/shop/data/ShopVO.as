package myShopper.amf.shop.data 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	//[RemoteClass(alias="shopper.amf.common.data.CategoryVO")]
	public class ShopVO extends VO 
	{
		public var shopNo:String;
		public var uid:String;
		public var name:String;
		public var phone:String;
		public var productType:Array;
		public var intro:String;
		//public var room:String;
		//public var house:String;
		//public var street:String;
		public var address:String;
		public var area:String;
		public var lat:Number;
		public var lng:Number;
		public var countryID:String;
		public var stateID:String;
		public var cityID:String;
		public var currency:int;
		
		public function ShopVO(inID:String = '') 
		{
			super(inID);
			
		}
		
	}

}