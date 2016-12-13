package myShopper.common.emun 
{
	/**
	 * amf sservice types, that has to be matched with server side.
	 * @author Toshi
	 */
	public class AMFUserManagementServicesType
	{
		//user management services
		public static const UPDATE_STATUS:String = 'shopper.users.UserManagement.updateStatus';
		public static const UPDATE_PROFILE:String = 'shopper.users.UserManagement.updateProfile';
		public static const UPDATE_PASSWORD:String = 'shopper.users.UserManagement.updatePassword';
		public static const UPDATE_LOGO:String = 'shopper.users.UserManagement.updateLogo';
		public static const UPDATE_BG:String = 'shopper.users.UserManagement.updateBG';
		//public static const GET_ALBUM:String = 'shopper.users.UserManagement.getAlbum';
		//public static const GET_PHOTO:String = 'shopper.users.UserManagement.getPhoto';
		//public static const CREATE_ALBUM:String = 'shopper.users.UserManagement.createAlbum';
		//public static const UPDATE_ALBUM:String = 'shopper.users.UserManagement.updateAlbum';
		//public static const DELETE_ALBUM:String = 'shopper.users.UserManagement.deleteAlbum';
		//public static const CREATE_PHOTO:String = 'shopper.users.UserManagement.createPhoto';
		//public static const UPDATE_PHOTO:String = 'shopper.users.UserManagement.updatePhoto';
		//public static const DELETE_PHOTO:String = 'shopper.users.UserManagement.deletePhoto';
		public static const DELETE_CART_PRODUCT:String = 'shopper.users.UserManagement.deleteCartProduct';
		public static const DELETE_CART_SHOP:String = 'shopper.users.UserManagement.deleteCartShop';
		public static const USER_BUY:String = 'shopper.users.UserManagement.buy';
		public static const USER_ORDER:String = 'shopper.users.UserManagement.order'; //made a order, and notify shop
		public static const GET_ORDER:String = 'shopper.users.UserManagement.getOrder';
		public static const GET_ORDER_PRODUCT:String = 'shopper.users.UserManagement.getOrderProduct';
		public static const GET_ORDER_EXTRA:String = 'shopper.users.UserManagement.getOrderExtra';
		public static const CONFIRM_RECEIVED_ORDER:String = 'shopper.users.UserManagement.confirmReceivedOrder';
	}

}