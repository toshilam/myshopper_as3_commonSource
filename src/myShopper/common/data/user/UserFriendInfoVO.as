package myShopper.common.data.user 
{
	//import myShopper.common.data.FileImageVO;
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserFriendInfoVO extends VO
	{
		//public var isLogged:Boolean;
		
		/*user data that from SQL*/
		//user number that matched with SQL user no
		//public var no:String = '';
		public var uid:String = '';
		
		
		//public var email:String;
		public var firstName:String;
		//public var lastName:String;
		//personal info should get from user list
		//public var sex:String;
		//public var day:String;
		//public var month:String;
		//public var year:String;
		//public var phone:String;
		//public var district:String;
		//public var country:String;
		//public var interest:String;
		
		//user logo image
		//private var _logoFileVO:FileImageVO = null;
		//public function get logoFileVO():FileImageVO { return _logoFileVO; }
		
		public function UserFriendInfoVO(inVOID:String) 
		{
			super(inVOID);
			
			//_logoFileVO = new FileImageVO(_id, null);
			
		}
		
		override public function clear():void
		{
			//isLogged = false;
			
			//no = '';
			uid = '';
			
			//email = '';
			firstName = '';
			//lastName = '';
			//password = '';
			//ageRange = '';
			//
			//sex = '';
			//day = '';
			//month = '';
			//year = '';
			//phone = '';
			//district = '';
			//country = '';
			//interest = '';
			//
			//subscribeNews = '0'
			//activated = '0';
			//
			//isShopExist = false;
			
			//_logoFileVO.clear();
			
			//shoppingCartList.clear();
			//shoppingCartList = null;
			//
			//_albumList.clear();
			//_albumList = null;
		}
		
		
	}

}