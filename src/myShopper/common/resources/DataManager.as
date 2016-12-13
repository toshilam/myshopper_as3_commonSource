package myShopper.common.resources 
{
	import flash.events.EventDispatcher;
	import myShopper.common.interfaces.IDataManager;
	
	/**
	 * 
	 * @author Toshi
	 */
	public class DataManager extends EventDispatcher implements IDataManager
	{
		protected var _objAssets:Object;
		
		protected var _lastAddedAssetID:String;
		
		/**
		 * [read only]
		 */
		public function get lastAddedAssetID():String
		{
			return _lastAddedAssetID;
		}
		
		public function DataManager() 
		{
			super();
			
			_objAssets = new Object();
			
		}
		
		public function addAsset(inAsset:Object, inAssetID:String):Boolean
		{
			if (_objAssets[inAssetID] == undefined)
			{
				_lastAddedAssetID = inAssetID;
				_objAssets[inAssetID] = inAsset;
				return true;
			}
			
			return false;
		}
		
		public function getAsset(inAssetID:String):*
		{
			return _objAssets[inAssetID];
		}
		
		public function hasAsset(inAssetID:String):Boolean
		{
			if (_objAssets[inAssetID] == undefined) return false;
			
			return true;
		}
		
		public function getData(inDataID:*,  inAssetID:String):*
		{
			return null;
		}
		
		public function hasData(inDataID:*,  inLoaderInfoID:String):Boolean
		{
			return false;
		}
		
		public function removeAsset(inAssetID:String):Boolean
		{
			if (hasAsset(inAssetID))
			{
				delete _objAssets[inAssetID];
				return true;
			}
			
			return false;
		}
	}

}