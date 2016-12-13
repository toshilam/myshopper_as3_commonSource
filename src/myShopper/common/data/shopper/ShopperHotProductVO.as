package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopperHotProductVO extends VO 
	{
		public var shopNo:String //sp-xxxxxx
		public var productNo:String;
		public var uid:String; //shop user owner id
		public var productID:String; 
		public var productName:String; 
		public var productDescription:String; 
		public var productPrice:String; 
		public var productDiscount:int; 
		public var shopCurrency:int; 
		public var productCategoryID:String; 
		//public var url:String; 
		
		
		public function ShopperHotProductVO(inID:String, inLangCode:String='') 
		{
			super(inID, inLangCode);
			
		}
		
	}

}