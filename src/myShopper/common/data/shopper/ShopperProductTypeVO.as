package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperProductTypeVO extends VO implements ISelectableVO
	{
		public var _isSelected:Boolean;
		
		//No from DB, and will be used as VO ID
		public var productTypeNo:String;
		public var productTypeName:String;
		
		//parent (product) info, which product is the vo under with
		//public var productNo:String;
		//public var productName:String;
		public var productVO:ShopperProductVO;
		
		public function ShopperProductTypeVO
		(
			inVOID:String,
			inProductTypeNo:String = '',
			inProductTypeName:String = '',
			inProductVO:ShopperProductVO = null
			//inProductNo:String = '', 
			//inProductName:String = ''
		) 
		{
			super(inVOID);
			
			productTypeNo = inProductTypeNo;
			productTypeName = inProductTypeName;
			//productNo = inProductNo;
			//productName = inProductName;
			productVO = inProductVO;
			
			isSelected = false;
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperProductTypeVO = new ShopperProductTypeVO
			(
				_id,
				productTypeNo,
				productTypeName,
				productVO
				//productNo,
				//productName
			);
			
			vo.isSelected = isSelected;
			
			return vo;
		}
		
		override public function clear():void
		{
			productTypeNo = '';
			productTypeName = '';
			//productNo = '';
			//productName = '';
			productVO = null
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