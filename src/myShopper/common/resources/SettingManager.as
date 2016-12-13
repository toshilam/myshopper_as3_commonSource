package myShopper.common.resources 
{
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.utils.Tracer;
	/**
	 * all setting info can be add into this manager for easier accessing
	 * @author Macentro
	 */
	public class SettingManager extends DataManager implements IDataManager
	{
		//key that contain current country and city value
		public static const COUNTRY:String = 'country';
		public static const STATE:String = 'state';
		public static const CITY:String = 'city';
		public static const PLATFORM:String = 'platform'; //web / mobile / pc
		public static const APP_VERSION:String = 'appVersion'
		
		//QQ
		public static const QQ_PLATFORM:String = 'pf'; 
		//public static const QQ_PLATFORM_KEY:String = 'pfkey'; 
		public static const QQ_OPEN_ID:String = 'openid';
		public static const QQ_OPEN_KEY:String = 'openkey';
		
		public function SettingManager() 
		{
			super();
			
		}
		
		public function get source():Object
		{
			//clone a new object
			var obj:Object = { };
			for (var i:String in _objAssets)
			{
				obj[i] = _objAssets[i];
			}
			return obj;
		}
		
		/**
		 * storing setting info into setting manager, 
		 * it also helps to read some specified setting such as (releset, ...)
		 * @param	inAsset
		 * @param	inAssetID
		 * @return
		 */
		override public function addAsset(inAsset:Object, inAssetID:String):Boolean
		{
			var isExist:Boolean = _objAssets[inAssetID] != undefined;
			
			_objAssets[inAssetID] = inAsset;
			_lastAddedAssetID = inAssetID;
			
			//dispatch event if exist data value changed
			if (isExist)
			{
				dispatchEvent(new ApplicationEvent(ApplicationEvent.CONTENT_CHANGED, null, inAssetID));
			}
			
			return true;
		}
		
		
		
		/**
		 * disabled function! : use getAsset instead of!
		 * @param	inNodeID
		 * @param	inAssetID
		 * @return
		 */
		override public function getData(inNodeID:*, inAssetID:String):*
		{
			Tracer.echo('SettingManager : getData : calling disabled function! : use getAsset instead of!', this, 0xff0000);
			return null;
		}
		
		/**
		 * disabled function! : use getAsset instead of!
		 * @param	inNodeID
		 * @param	inAssetID
		 * @return
		 */
		override public function hasData(inNodeID:*, inAssetID:String):Boolean
		{
			Tracer.echo('SettingManager : hasData : calling disabled function! : use hasAsset instead of!', this, 0xff0000);
			return false;
		}
		
		
	}

}