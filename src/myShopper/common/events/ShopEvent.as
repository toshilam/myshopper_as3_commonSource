package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.events.ApplicationEvent;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopEvent extends ApplicationEvent 
	{
		private static const NAME:String = 'ShopEvent';
		
		//public static const RESULT_UPLOAD_IMAGE:String = NAME + 'resultUploadImage';
		//public static const UPLOAD_IMAGE:String = NAME + 'uploadImage';
		//
		//public static const RESULT_DOWNLOAD_IMAGE:String = NAME + 'resultDownloadImage';
		//public static const DOWNLOAD_IMAGE:String = NAME + 'downloadImage';
		
		public static const REGISTER:String = NAME + 'register';
		
		public static const GET_ABOUT:String = NAME + 'getAbout';
		//public static const RESULT_GET_ABOUT:String = NAME + 'resultGetAbout';
		
		public static const GET_BG:String = NAME + 'getBG';
		//public static const RESULT_GET_ABOUT:String = NAME + 'resultGetAbout';
		
		public static const GET_INFO_BY_SHOP_ID:String = NAME + 'getInfoByShopID';
		//public static const RESULT_GET_INFO:String = NAME + 'resultGetInfo';
		
		public static const GET_NEWS:String = NAME + 'getNews';
		//public static const RESULT_GET_NEWS:String = NAME + 'resultGetNews';
		
		public static const GET_CUSTOM:String = NAME + 'getCustom'; //custom page
		
		public static const GET_PRODUCT:String = NAME + 'getProduct';
		public static const GET_PRODUCT_BY_NO:String = NAME + 'getProductByNo';
		//public static const RESULT_GET_PRODUCT:String = NAME + 'resultGetProduct';
		
		public static const GET_CATEGORY:String = NAME + 'getCategory';
		
		public static const GET_CATEGORY_PRODUCT:String = NAME + 'getCategoryAndProduct';
		//public static const RESULT_GET_CATEGORY:String = NAME + 'resultGetCategory';
		
		public static const GET_COUNTRY:String = NAME + 'getCountry';
		public static const GET_STATE:String = NAME + 'getState';
		public static const GET_CITY:String = NAME + 'getCity';
		public static const GET_AREA:String = NAME + 'getArea';
		//public static const SET_AREA:String = NAME + 'setArea';
		
		//public static const INIT_MENU:String = NAME + 'initMenu';
		
		public static const SEND_FRIEND:String = NAME + 'sendFriend';
		
		public static const ADD_CART:String = NAME + 'addCart';
		//public static const RESULT_ADD_CART:String = NAME + 'resultAddCart';
		
		public static const VIEW_CART:String = NAME + 'viewCart';
		
		//the walked in shop's shopkeeper is currently online
		public static const SHOPKEEPER_ONLINE:String = NAME + 'shopkeeperOnline';
		public static const SHOPKEEPER_OFFLINE:String = NAME + 'shopkeeperOffline';
		
		public static const USER_WALK_IN:String = NAME + 'userWalkIn';
		public static const USER_WALK_OUT:String = NAME + 'userWalkOut';
		
		public static const LOCATION:String = NAME + 'location';
		
		//public static const WELCOME_MESSAGE:String = NAME + 'welcomeMessage';
		
		
		public function ShopEvent(type:String, inTargetDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, inTargetDisplayObject, inData, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ShopEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ShopEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}