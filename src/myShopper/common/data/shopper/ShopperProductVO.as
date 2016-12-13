package myShopper.common.data.shopper 
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.VO;
	import myShopper.common.emun.FileType;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperProductVO extends VO implements ISelectableVO
	{
		public var _isSelected:Boolean;
		
		//No from DB, and will be used as VO ID
		public var productNo:String;
		public var productName:String;
		
		//public var productCategoryNo:String;
		//public var productCategoryName:String;
		public var categoryVO:ShopperCategoryVO; //parent info
		
		public function get numberOfProductType():uint 
		{
			return _productTypeList && _productTypeList.length ? _productTypeList.length : 0;
		}
		
		protected var _productTypeList:ShopperProductTypeList;
		public function get productTypeList():ShopperProductTypeList { return _productTypeList; }
		public function set productTypeList(value:ShopperProductTypeList):void 
		{
			_productTypeList = value;
		}
		
		public function ShopperProductVO
		(
			inVOID:String,
			inProductNo:String = '', 
			inProductName:String = '', 
			inCategoryVO:ShopperCategoryVO = null
			//inProductCategoryNo:String = '',
			//inProductCategoryName:String = ''
		) 
		{
			super(inVOID);
			
			productNo = inProductNo;
			productName = inProductName;
			//productCategoryNo = inProductCategoryNo;
			//productCategoryName = inProductCategoryName;
			
			categoryVO = inCategoryVO;
			_productTypeList = new ShopperProductTypeList(_id);
			
			isSelected = false;
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperProductVO = new ShopperProductVO
			(
				_id,
				productNo,
				productName,
				categoryVO
				//productCategoryNo,
				//productCategoryName
			);
			
			vo.productTypeList = _productTypeList.clone() as ShopperProductTypeList;
			vo.isSelected = isSelected;
			
			return vo;
		}
		
		override public function clear():void
		{
			productNo = '';
			productName = '';
			//productCategoryNo = '';
			//productCategoryName = '';
			categoryVO = null;
			_productTypeList.clear();
			isSelected = false;
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