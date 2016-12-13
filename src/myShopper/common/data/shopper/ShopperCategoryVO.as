package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperCategoryVO extends VO implements ISelectableVO
	{
		protected var _isSelected:Boolean;
		
		public var categoryName:String;
		public var categoryNo:String;
		
		public function get numberOfProduct():uint 
		{
			return _productList && _productList.length ? _productList.length : 0;
		}
		
		protected var _productList:ShopperProductList;
		public function get productList():ShopperProductList { return _productList; }
		public function set productList(value:ShopperProductList):void 
		{
			_productList = value;
		}
		
		public function ShopperCategoryVO
		(
			inVOID:String,
			inCategoryName:String = '', 
			inCategoryNo:String = ''
		) 
		{
			super(inVOID);
			
			categoryName = inCategoryName;
			categoryNo = inCategoryNo;
			
			isSelected = false;
			
			_productList = new ShopperProductList(_id);
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperCategoryVO = new ShopperCategoryVO(_id, categoryName, categoryNo);
			vo.isSelected = isSelected;
			vo.productList = _productList.clone() as ShopperProductList;
			
			return vo;
		}
		
		override public function clear():void
		{
			categoryName = '';
			categoryNo = '';
			isSelected = false;
			_productList.clear();
			//_productList = null;
			//numberOfProduct = 0;
		}
		
		/* INTERFACE myShopper.common.interfaces.ISelectableVO */
		
		public function get isSelected():Boolean 
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void 
		{
			_isSelected = value;
		}
		
	}

}