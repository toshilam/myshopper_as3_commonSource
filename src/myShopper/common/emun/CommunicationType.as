package myShopper.common.emun 
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class CommunicationType
	{
		//finished downloading all nessesary data (after user logged in), then connect to fms
		public static const USER_DATA_INITIALIZED:String = 'userDataInitialized';
		//finished downloading all nessesary common app(swf)
		public static const APP_DATA_INITIALIZED:String = 'appDataInitialized'; 
		
		public static const FB_REQUEST_PERMISSION:String = 'fbRequestPermission';
		public static const FB_LOGIN_OUT:String = 'fbLoginOut';
		public static const FB_SHARE_PRODUCT:String = 'fbShareProduct';
		public static const FB_SHARE_SHOPPER:String = 'fbShareShopper';
		public static const FB_LIKE_PRODUCT:String = 'fbLikeProduct';
		public static const FB_CHECKIN:String = 'fbCheckin';
		
		public static const USER_INFO:String = 'userInfo';
		public static const USER_LOGIN:String = 'userLogin';
		public static const USER_LOGOUT:String = 'userLogout';
		public static const USER_REGISTER:String = 'userRegister';
		public static const USER_LOGIN_SUCCESS:String = 'userLoginSuccess';
		public static const USER_FMS_LOGIN_SUCCESS:String = 'userFMSLoginSuccess';
		public static const USER_WALK_IN_SHOP:String = 'userWalkInShop'; //get into a shop
		public static const USER_WALK_OUT_SHOP:String = 'userWalkOutShop'; //get out from a shop
		public static const USER_QUESTION_SHOP:String = 'userQuestionShop'; //send question to shop
		public static const USER_SEND_P_FRIEND:String = 'userSendPFriend'; //send a shop product to fd
		public static const USER_ADD_FRIEND:String = 'userAddFriend'; //add fd / show form
		public static const USER_ADD_FRIEND_RESPONSE:String = 'userAddFriendResponse'; //add fd response / from userMgt module to user module
		public static const USER_SHOP_TOGETHER:String = 'userShopTogether'; //req show together / show form
		public static const USER_SHOP_TOGETHER_RESPONSE:String = 'userShopTogetherResponse'; //shop together response / from userMgt module to user module
		public static const USER_START_CHAT:String = 'userStartChat'; //request to chat with fd, from map to user module
		public static const USER_CONNECTED:String = 'userConnected'; //connected to socket (ws/fms)
		public static const USER_DISCONNECTED:String = 'userDisconnected'; //disconnected to socket (ws/fms)
		public static const USER_DISCONNECTING:String = 'userDisconnecting'; //disconnecting to socket (ws/fms)
		
		
		public static const MAP_VIEW_CITY_BY_VO:String = 'mapViewCityByVO'; //direct view city on map, notified by menu module
		public static const MAP_VIEW_BY_AREA_NO:String = 'mapViewByAreaNo'; //direct view area on map, notified by menu module
		public static const MAP_USER_LOCATION:String = 'mapUserLocation'; //show user location on map
		public static const MAP_SHOP_LOCATION:String = 'mapShopLocation'; //show shop location on map
		
		//public static const USER_ADD_FRIEND_ACCEPT:String = 'userAddFriendAccept'; //add fd accepted / add to fd list
		//public static const USER_OPEN_ADD_FRIEND_REQUEST:String = 'userOpenAddFriendRequest'; //open add fd req (received from other user)
		
		public static const SHOP_REGISTER:String = 'shopRegister';
		
		public static const SHOPPER_SEARCH_SHOP:String = 'shopperSearchShop';
		public static const SHOPPER_CONTACT_US:String = 'shopperContactUs';
		//public static const SHOPPER_GET_CITY_AREA:String = 'shopperGetCityArea';
		//public static const SHOPPER_ABOUT_US:String = 'shopperAboutUs';
		public static const SHOPPER_DOWNLOADING:String = 'shopperDownloading';
		public static const SHOPPER_DOWNLOADED:String = 'shopperDownloaded';
		
		//mobile use
		public static const SHOPPER_WEB_VIEW:String = 'shopperWebView';
	}

}