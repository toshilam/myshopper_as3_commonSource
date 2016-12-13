package myShopper.common.data.shop 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopProductStockVO extends VO 
	{
		public var productName:String; //from product VO
		public var productNo:String; //from product VO
		public var productID:String; //from product VO
		
		public var numStock:Number; //number of stock added for this product
		public var stockNo:String; //stock db no
		public var stockID:String; //an ID defined by user
		public var dateTime:String; //the date that the stock created
		
		private var _isDeleted:Boolean; //is this stock delete
		public function get isDeleted():Boolean { return _isDeleted; }
		public function set isDeleted(value:Boolean):void 
		{
			_isDeleted = value;
			dispatchChangeEvent('isDeleted', value);
		}
		
		public function ShopProductStockVO(inID:String) 
		{
			super(inID);
			clear();
		}
		
		override public function clear():void 
		{
			productName = productNo = productID = stockID = stockNo = '';
			numStock = 0;
			isDeleted = false;
		}
		
		override public function clone():IVO 
		{
			var vo:ShopProductStockVO = new ShopProductStockVO(id);
			vo.isDeleted = isDeleted;
			vo.numStock = numStock;
			vo.productID = productID;
			vo.productName = productName;
			vo.productNo = productNo;
			vo.stockID = stockID;
			vo.stockNo = stockNo;
			
			return vo;
		}
		
		
		
	}

}