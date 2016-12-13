package myShopper.common.data.user 
{
	import myShopper.common.data.shop.ShopProductFormVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShoppingCartProductVO extends ShopProductFormVO 
	{
		public var qty:int;
		//public var discount:int;
		public var shopNo:String; //sp-xxxxxx
		
		public function UserShoppingCartProductVO
		(
			inVOID:String, 
			inProductNo:String = '', 
			inProductID:String = '', 
			inProductName:String = '', 
			inProductPrice:String = '', 
			inProductDescription:String = '', 
			inProductCurrency:String = '', 
			inProductCategoryNo:String = '', 
			inProductDateTime:String = '', 
			inProductURL:String = '', 
			inProductCategoryName:String = '',
			inDiscount:int = 0,
			inTax:String = ''
		) 
		{
			super
			(
				inVOID, 
				inProductNo, 
				inProductID, 
				inProductName, 
				inProductPrice, 
				inProductDescription, 
				inProductCurrency, 
				inProductCategoryNo, 
				inProductDateTime, 
				inProductURL, 
				inProductCategoryName
			);
			
			productDiscount = inDiscount;
			productTax = inTax;
			
			qty = 1;
			//discount = 0;
			shopNo = '';
		}
		
		override public function clear():void 
		{
			super.clear();
			qty = 1;
			//discount = 0;
			shopNo = '';
		}
		
		public function getPriceWithQTY(inWithDiscount:Boolean = true, inWithTax:Boolean = true):Number
		{
			var price:Number = getPrice(inWithDiscount, inWithTax);
			return price * qty;
		}
	}

}