package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationUserManagementEvent extends ApplicationEvent 
	{
		private static const NAME:String = 'ApplicationUserManagementEvent';
		
		public static const INIT_ASSET_MY_MENU:String = NAME + 'initAssetUserMenu';
		public static const UPDATE_PROFILE:String = NAME + 'updateProfile';
		public static const RESULT_UPDATE_PROFILE:String = NAME + 'resultUpdateProfile';
		
		public static const UPDATE_PASSWORD:String = NAME + 'updatePassword';
		public static const RESULT_UPDATE_PASSWORD:String = NAME + 'resultUpdatePassword';
		
		public static const UPDATE_LOGO:String = NAME + 'updateLogo';
		public static const RESULT_UPDATE_LOGO:String = NAME + 'resultUpdateLogo';
		
		public static const GET_ALBUM:String = NAME + 'getAlbum';
		public static const RESULT_GET_ALBUM:String = NAME + 'resultGetAlbum';
		public static const CREATE_ALBUM:String = NAME + 'createAlbum';
		public static const UPDATE_ALBUM:String = NAME + 'updateAlbum';
		public static const DELETE_ALBUM:String = NAME + 'deleteAlbum';
		public static const RESULT_CREATE_ALBUM:String = NAME + 'resultCreateAlbum';
		public static const RESULT_UPDATE_ALBUM:String = NAME + 'resultUpdateAlbum';
		public static const RESULT_DELETE_ALBUM:String = NAME + 'resultDeleteAlbum';
		
		public static const GET_PHOTO:String = NAME + 'getPhoto';
		public static const RESULT_GET_PHOTO:String = NAME + 'resultGetPhoto';
		public static const CREATE_PHOTO:String = NAME + 'createPhoto';
		public static const UPDATE_PHOTO:String = NAME + 'updatePhoto';
		public static const DELETE_PHOTO:String = NAME + 'deletePhoto';
		public static const RESULT_CREATE_PHOTO:String = NAME + 'resultCreatePhoto';
		public static const RESULT_UPDATE_PHOTO:String = NAME + 'resultUpdatePhoto';
		public static const RESULT_DELETE_PHOTO:String = NAME + 'resultDeletePhoto';
		
		public function ApplicationUserManagementEvent(type:String, inTargetDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, inTargetDisplayObject, inData, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationUserManagementEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ApplicationUserManagementEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}