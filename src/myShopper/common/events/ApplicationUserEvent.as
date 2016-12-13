package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationUserEvent extends ApplicationEvent 
	{
		private static const NAME:String = 'ApplicationUserEvent';
		
		public static const FORGOT_PASSWORD:String = NAME + 'ForgotPassword';
		
		public static const RESULT_UPLOAD_IMAGE:String = NAME + 'resultUploadImage';
		public static const UPLOAD_IMAGE:String = NAME + 'uploadImage';
		
		public static const RESULT_DOWNLOAD_IMAGE:String = NAME + 'resultDownloadImage';
		public static const DOWNLOAD_IMAGE:String = NAME + 'downloadImage';
		
		public static const USER_REGISTER:String = NAME + 'userRegister';
		public static const USER_CHECK_EMAIL:String = NAME + 'checkEmail';
		public static const RESULT_USER_CHECK_EMAIL:String = NAME + 'resultCheckEmail';
		
		public static const USER_LOGIN:String = NAME + 'userLogin';
		public static const RESULT_USER_LOGIN:String = NAME + 'resultUserLogin';
		
		public static const USER_LOGOUT:String = NAME + 'userLogout';
		public static const RESULT_USER_LOGOUT:String = NAME + 'resultUserLogout';
		
		public static const CREATE_WINDOW:String = NAME + 'createWindow';
		public static const GET_WINDOW_DATA:String = NAME + 'getWindowData';
		public static const RESULT_WINDOW_DATA:String = NAME + 'getWindowData';
		
		public static const GET_USER_REQUEST:String = NAME + 'getUserRequest'; // get user request / dispatch by user marker
		
		public static const ADD_FRIEND_REQUEST:String = NAME + 'addFriendRequest'; // add friend, send request to server
		public static const ADD_FRIEND_REQUEST_REPLY:String = NAME + 'addFriendRequestReply'; // add friend, send reply to server
		public static const SHOP_TOGETHER_REQUEST_REPLY:String = NAME + 'shopTogetherRequestReply'; // shop together, send reply to server
		//public static const ADD_FRIEND_RESULT:String = NAME + 'addFriendResult'; // successfully added friend / call by FMS
		public static const ADD_FRIEND:String = NAME + 'addFriend'; //request add friend pop up add friend window
		
		public static const USER_OFFLINE:String = NAME + 'userOffline'; //user (fd) offline
		public static const USER_LOCATION:String = NAME + 'userLocation'; //show user (fd) location
		public static const USER_INFO:String = NAME + 'userInfo'; //show user (fd) info in userMgt page
		public static const USER_SHOP_TOGETHER:String = NAME + 'userShopTogether'; //request to shop together
		
		
		public function ApplicationUserEvent(type:String, inTargetDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, inTargetDisplayObject, inData, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationUserEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ApplicationUserEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}