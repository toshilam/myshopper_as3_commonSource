package myShopper.common.data.shop 
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopProductShoppingCartVO extends ShopProductFormVO
	{
		public var quantity:String;
		
		public function ShopProductShoppingCartVO
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
			inQuantity:String = ''
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
			
			quantity = inQuantity;
		}
		
		override public function clear():void 
		{
			super.clear();
			quantity = '';
		}
	}

}