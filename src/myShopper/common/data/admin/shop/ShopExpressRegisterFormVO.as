package myShopper.common.data.admin.shop 
{
	import myShopper.common.data.shop.ShopRegisterFormVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopExpressRegisterFormVO extends ShopRegisterFormVO 
	{
		public var activated:Boolean = false;
		public var userEmail:String;
		public var userFirstName:String;
		public var userLastName:String;
		
		public function ShopExpressRegisterFormVO(inVOID:String) 
		{
			super(inVOID);
			
		}
		
		override public function clear():void 
		{
			super.clear();
			userEmail = '';
			userFirstName = '';
			userLastName = '';
			activated = false;
		}
	}

}