package myShopper.common.data.user 
{
	import myShopper.common.data.shop.ShopInfoVO;
	import myShopper.common.data.shop.ShopOrderVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShoppingRecordVO extends UserShoppingCartVO 
	{
		public var shopOrderVO:ShopOrderVO;
		public var userCommentShop:UserCommentShopVO; //to be set by proxy when user confirm receive order
		
		public function UserShoppingRecordVO(inVOID:String/*, inShopInfoVO:ShopInfoVO=null*/) 
		{
			super(inVOID/*, inShopInfoVO*/);
			
			shopOrderVO = new ShopOrderVO(inVOID);
			userCommentShop = new UserCommentShopVO(inVOID);
		}
		
	}

}