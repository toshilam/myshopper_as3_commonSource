package myShopper.common.emun 
{
	/**
	 * FMS sservice types, that has to be matched with server side.
	 * @author Toshi
	 */
	public class RTMFPServicesType
	{
		public static const HEART_BEAT:String = 'shopper.rtmfp.shopper.heartbeat';
		
		//public static const USER_IS_LOGGED:String = AMFUserServicesType.USER_IS_LOGGED;
		//public static const USER_RELOGIN:String = 'shopper.fms.user.relogin';
		
		public static const RC_DISCONNECTED:String = 'shopper.rtmfp.user.userDisconnected';
		//public static const USER_INFO_ALL:String = 'shopper.rtmfp.user.userInfoAll';
		public static const RC_LOGIN:String = 'shopper.rtmfp.user.userLogin'; //whene there is a new user logged in
		public static const RC_LOGOUT:String = 'shopper.rtmfp.user.userLogout'; //whene there is a user logged out
		public static const RC_CREATE_PRODUCT:String = 'shopper.rtmfp.shop.createProduct'; //scan result
		
	}

}