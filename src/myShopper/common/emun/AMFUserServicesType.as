package myShopper.common.emun 
{
	/**
	 * amf sservice types, that has to be matched with server side.
	 * @author Toshi
	 */
	public class AMFUserServicesType
	{
		//user services
		public static const USER_REGISTER:String = 'shopper.users.User.register';
		//public static const USER_CHECK_EMAIL:String = 'shopper.users.User.isExist';
		public static const USER_LOGIN:String = 'shopper.users.User.login';
		public static const USER_AUTO_LOGIN:String = 'shopper.users.User.autoLogin';
		public static const USER_EXTERNAL_LOGIN:String = 'shopper.users.User.externalLogin'; //3rd party login to shopper platform / qq, fb...
		//3rd party login to shopper platform / qq, fb...
		public static const USER_QQ_LOGIN:String = 'shopper.users.User.QQLogin'; 
		public static const USER_LOGOUT:String = 'shopper.users.User.logout';
		public static const USER_FORGOT_PASSWORD:String = 'shopper.users.User.forgotPassword';
		public static const USER_IS_LOGGED:String = 'shopper.users.User.isLogged';
		public static const UPLOAD_IMAGE:String = 'shopper.users.User.uploadImage';
		public static const DOWNLOAD_IMAGE:String = 'shopper.users.User.downloadImage';
		public static const GET_INFO_BY_UID:String = 'shopper.users.User.getInfoByUID';
		public static const GET_CART:String = 'shopper.users.User.getCart';
		public static const GET_FRIENDS:String = 'shopper.users.User.getFriends';
		public static const GET_REQUESTS:String = 'shopper.users.User.getRequests';
		public static const USER_ADD_CART:String = 'shopper.users.User.addCart';
		public static const USER_UPDATE_LAT_LNG:String = 'shopper.users.User.updateLatLng';
		public static const USER_VIEW_SHOP:String = 'shopper.users.User.viewShop'; //record user walkin which shop
		public static const USER_VIEW_SHOP_PRODUCT:String = 'shopper.users.User.viewShopProduct'; //record user walkin which shop
		
		
		public static const USER_3P_INVITE:String = 'shopper.users.User.invite';
		public static const USER_3P_SHARE:String = 'shopper.users.User.share';
		//public static const USER_3P_RELOGIN:String = 'shopper.users.User.relogin';
		
	}

}