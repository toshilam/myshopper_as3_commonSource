package myShopper.common.data 
{
	import myShopper.common.data.shop.ShopInfoVO;
	import myShopper.common.data.shop.ShopProductFormVO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ProductSendFriendVO extends SendFriendVO 
	{
		public var shopInfo:ShopInfoVO;
		public var productInfo:ShopProductFormVO;
		
		public function ProductSendFriendVO(inVOID:String, inShopInfo:ShopInfoVO = null, inProductVO:ShopProductFormVO = null) 
		{
			super(inVOID);
			shopInfo = inShopInfo;
			productInfo = inProductVO;
		}
		
		override public function clear():void 
		{
			super.clear();
			//no clear needed as object may referenced by other object
			shopInfo = null;
			productInfo = null;
		}
		
	}

}