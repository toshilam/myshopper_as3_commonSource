package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserCheckOutVO extends VO 
	{
		public var email:String;
		public var phone:String;
		public var address:String;
		public var remark:String;
		
		public var cart:UserShoppingCartVO;
		
		public function UserCheckOutVO(inID:String, inEmail:String = '', inPhone:String = '', inAddress:String = '', inNote:String = '', inCart:UserShoppingCartVO = null) 
		{
			super(inID);
			
			email = inEmail;
			phone = inPhone;
			address = inAddress;
			remark = inNote;
			
			cart = inCart;
			
		}
		
		override public function clear():void 
		{
			super.clear();
			remark = address = phone = email = '';
			cart = null;
		}
		
		/*override public function clone():IVO 
		{
			return UserCheckOutVO(_id, email, phone, address, note, product);
		}*/
	}

}