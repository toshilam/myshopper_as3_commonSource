package myShopper.amf.shop.data 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	//[RemoteClass(alias="shopper.amf.common.data.CategoryVO")]
	public class ProductVO extends VO 
	{
		public var category:String;
		public var dateTime:String;
		public var no:String;
		public var pid:String;
		public var name:String;
		public var price:String;
		public var currency:String;
		public var description:String;
		public var shopperCategoryNo:String;
		public var shopperProductNo:String;
		public var fbID:String;
		public var shopperProductTypeNo:String;
		public var discount:int;
		public var unit:String;
		public var tax:String;
		
		public function ProductVO(inID:String = '', inCategory:String = '', inDateTime:String = '', inNo:String = '', inPID:String = '', inName:String = '', inPrice:String = '', inCurrency:String = '', inDescription:String = '', inShopperCategoryNo:String = '', inShopperProductNo:String = '', inFBID:String = '', inShopperProductTypeNo:String = '', inDiscount:int = 0, inUnit:String = '', inTax:String = '') 
		{
			super(inID);
			category = inCategory;
			dateTime = inDateTime;
			no = inNo;
			pid = inPID;
			name = inName;
			price = inPrice;
			currency = inCurrency;
			description = inDescription;
			shopperCategoryNo = inShopperCategoryNo;
			shopperProductNo = inShopperProductNo;
			fbID = inFBID;
			shopperProductTypeNo = inShopperProductTypeNo;
			discount = inDiscount;
			unit = inUnit;
			tax = inTax;
		}
		
	}

}