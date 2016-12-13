package myShopper.common.emun 
{
	/**
	 * FMS sservice types, that has to be matched with server side.
	 * @author Toshi
	 */
	public class FMSServicesType
	{
		public static const HEART_BEAT:String = 'shopper.fms.shopper.heartbeat';
		
		public static const USER_IS_LOGGED:String = AMFUserServicesType.USER_IS_LOGGED;
		//public static const USER_RELOGIN:String = 'shopper.fms.user.relogin';
		
		public static const USER_DISCONNECTED:String = 'shopper.fms.user.userDisconnected';
		public static const USER_INFO_ALL:String = 'shopper.fms.user.userInfoAll';
		public static const USER_LOGIN:String = 'shopper.fms.user.userLogin'; //whene there is a new user logged in
		public static const USER_LOGOUT:String = 'shopper.fms.user.userLogout'; //whene there is a user logged out
		public static const USER_UPDATE_LAT_LNG:String = 'shopper.fms.user.updateLatLng';
		
		public static const USER_BUY:String = 'shopper.fms.user.buy';
		
		public static const USER_SEND_ADD_FRIEND_REQUEST:String = 'shopper.fms.user.sendAddFriendRequest';
		public static const USER_RECEIVE_ADD_FRIEND_REQUEST:String = 'shopper.fms.user.receiveAddFriendRequest';
		public static const USER_SEND_ADD_FRIEND_RESPONSE:String = 'shopper.fms.user.sendAddFriendResponse';
		public static const USER_RECEIVE_ADD_FRIEND_RESPONSE:String = 'shopper.fms.user.receiveAddFriendResponse';
		
		//shopping together
		public static const USER_CREATE_SHOP_TOGETHER_REQUEST:String = 'shopper.fms.user.createShopTogetherRequest';
		public static const USER_CREATE_SHOP_TOGETHER_RESPONSE:String = 'shopper.fms.user.createShopTogetherResponse';
		//public static const USER_REMOVE_SHOP_TOGETHER:String = 'shopper.fms.user.removeShopTogether';
		public static const USER_SEND_SHOP_TOGETHER_REQUEST:String = 'shopper.fms.user.sendShopTogetherRequest';
		public static const USER_RECEIVE_SHOP_TOGETHER_REQUEST:String = 'shopper.fms.user.receiveShopTogetherRequest';
		public static const USER_SEND_SHOP_TOGETHER_RESPONSE:String = 'shopper.fms.user.sendShopTogetherResponse';
		public static const USER_RECEIVE_SHOP_TOGETHER_RESPONSE:String = 'shopper.fms.user.receiveShopTogetherResponse';
		public static const USER_SEND_SHOP_TOGETHER_UPDATE:String = 'shopper.fms.user.sendShopTogetherUpdate';
		public static const USER_RECEIVE_SHOP_TOGETHER_UPDATE:String = 'shopper.fms.user.receiveShopTogetherUpdate';
		public static const USER_JOIN_SHOP_TOGETHER:String = 'shopper.fms.user.joinShopTogether';
		public static const USER_SEND_LEAVE_SHOP_TOGETHER:String = 'shopper.fms.user.sendLeaveShopTogether';
		public static const USER_RECEIVE_LEAVE_SHOP_TOGETHER:String = 'shopper.fms.user.receiveLeaveShopTogether';
		public static const USER_SEND_USER_ST_CHAT_MESSAGE:String = 'shopper.fms.user.sendUserSTChatMessage';
		public static const USER_RECEIVE_USER_ST_CHAT_MESSAGE:String = 'shopper.fms.user.receiveUserSTChatMessage';
		
		public static const USER_WALK_IN_SHOP:String = 'shopper.fms.user.walkInShop';
		public static const USER_WALK_OUT_SHOP:String = 'shopper.fms.user.walkOutShop';
		
		//the walked in shop's shopkeeper is currently online
		public static const SHOP_SHOPKEEPER_ONLINE:String = 'shopper.fms.shop.shopkeeperOnline';
		public static const SHOP_SHOPKEEPER_OFFLINE:String = 'shopper.fms.shop.shopkeeperOffline';
		public static const SHOP_WELCOME_MESSAGE:String = 'shopper.fms.shop.shopWelcomeMessage';
		
		public static const SEND_SHOP_CHAT_MESSAGE:String = 'shopper.fms.user.sendShopChatMessage';
		public static const RECEIVE_SHOP_CHAT_MESSAGE:String = 'shopper.fms.user.receiveShopChatMessage';
		
		public static const SEND_USER_CHAT_MESSAGE:String = 'shopper.fms.user.sendUserChatMessage';
		public static const RECEIVE_USER_CHAT_MESSAGE:String = 'shopper.fms.user.receiveUserChatMessage';
	}

}