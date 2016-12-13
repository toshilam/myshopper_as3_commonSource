package myShopper.common.data.shop 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopCategoryFormVO extends VO
	{
		//login info
		public var categoryName:String;
		public var isPrivate:Boolean;
		public var createDateTime:String;
		public var categoryNo:String;
		//categoryURL = URL + categoryName with no space
		public var categoryURL:String;
		
		private var _numberOfProduct:uint;
		public function get numberOfProduct():uint 
		{
			return _productList && _productList.length ? _productList.length : 0;
		}
		
		protected var _productList:ShopProductList;
		public function get productList():ShopProductList { return _productList; }
		
		/*public function set id(inID:String):void
		{
			_id = inID;
		}*/
		
		
		
		public function ShopCategoryFormVO
		(
			inVOID:String,
			inCategoryName:String = '', 
			inIsPrivate:Boolean = false,
			inCategoryNo:String = '',
			inCreateDateTime:String = '',
			inCategoryURL:String = ''/*,
			inNumberOfProduct:uint = 0*/
		) 
		{
			super(inVOID);
			
			categoryName = inCategoryName;
			isPrivate = inIsPrivate;
			createDateTime = inCreateDateTime;
			categoryNo = inCategoryNo;
			categoryURL = inCategoryURL;
			//numberOfProduct = inNumberOfProduct;
			
			_productList = new ShopProductList(_id);
		}
		
		override public function clear():void
		{
			categoryName = '';
			isPrivate = false;
			createDateTime = '';
			categoryNo = '';
			categoryURL = '';
			_productList.clear();
			_productList = null;
			//numberOfProduct = 0;
		}
		
	}

}