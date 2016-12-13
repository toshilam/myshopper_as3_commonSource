package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationShopManagementEvent extends ApplicationEvent 
	{
		private static const NAME:String = 'ApplicationShopManagementEvent';
		
		//public static const DOWNLOAD_IMAGE:String = NAME + 'downloadImage';
		
		public static const INIT_ASSET_MY_MENU:String = NAME + 'initAssetMyMenu';
		public static const INIT_ASSET_SHOP_MENU:String = NAME + 'initAssetShopMenu';
		
		public static const GET_ABOUT:String = NAME + 'getAbout';
		public static const RESULT_GET_ABOUT:String = NAME + 'resultGetAbout';
		public static const UPDATE_ABOUT:String = NAME + 'updateAbout';
		public static const RESULT_UPDATE_ABOUT:String = NAME + 'resultUpdateAbout';
		
		public static const GET_NEWS:String = NAME + 'getNews';
		public static const RESULT_GET_NEWS:String = NAME + 'resultGetNews';
		public static const UPDATE_NEWS:String = NAME + 'updateNews';
		public static const RESULT_UPDATE_NEWS:String = NAME + 'resultUpdateNews';
		
		public static const GET_LOGO:String = NAME + 'getLogo';
		public static const RESULT_GET_LOGO:String = NAME + 'resultGetLogo';
		public static const UPDATE_LOGO:String = NAME + 'updateLogo';
		public static const RESULT_UPDATE_LOGO:String = NAME + 'resultUpdateLogo';
		
		public static const GET_INFO:String = NAME + 'getInfo';
		public static const RESULT_GET_INFO:String = NAME + 'resultGetInfo';
		public static const UPDATE_INFO:String = NAME + 'updateInfo';
		public static const RESULT_UPDATE_INFO:String = NAME + 'resultUpdateInfo';
		
		public static const GET_CATEGORY_MENU:String = NAME + 'getCategoryMenu';
		public static const GET_PRODUCT_MENU:String = NAME + 'getProductMenu';
		public static const RESULT_GET_PRODUCT_MENU:String = NAME + 'resultGetProductMenu';
		public static const RESULT_GET_CATEGORY_MENU:String = NAME + 'resultGetCategoryMenu';
		
		public static const CREATE_CATEGORY:String = NAME + 'createCategory';
		public static const UPDATE_CATEGORY:String = NAME + 'updateCategory';
		public static const DELETE_CATEGORY:String = NAME + 'deleteCategory';
		public static const RESULT_CREATE_CATEGORY:String = NAME + 'resultCreateCategory';
		public static const RESULT_UPDATE_CATEGORY:String = NAME + 'resultUpdateCategory';
		public static const RESULT_DELETE_CATEGORY:String = NAME + 'resultDeleteCategory';
		
		public static const CREATE_PRODUCT:String = NAME + 'createProduct';
		public static const UPDATE_PRODUCT:String = NAME + 'updateProduct';
		public static const DELETE_PRODUCT:String = NAME + 'deleteProduct';
		public static const RESULT_CREATE_PRODUCT:String = NAME + 'resultCreateProduct';
		public static const RESULT_UPDATE_PRODUCT:String = NAME + 'resultUpdateProduct';
		public static const RESULT_DELETE_PRODUCT:String = NAME + 'resultDeleteProduct';
		
		public function ApplicationShopManagementEvent(type:String, inTargetDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, inTargetDisplayObject, inData, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationShopManagementEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ApplicationShopManagementEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}