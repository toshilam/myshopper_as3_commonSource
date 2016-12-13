package myShopper.common.data.shopper.search 
{
	import myShopper.common.data.shopper.ShopperAreaList;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.shopper.ShopperDistanceList;
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class SearchShopVO extends VO 
	{
		public var categoryList:ShopperCategoryList;
		public var areaList:ShopperAreaList;
		public var distanceList:ShopperDistanceList;
		
		public var keyword:String;
		
		public function SearchShopVO(inID:String) 
		{
			super(inID);
			
			keyword = '';
		}
		
		override public function clear():void 
		{
			super.clear();
			categoryList = null;
			areaList = null;
			distanceList = null;
			keyword = '';
		}
	}

}