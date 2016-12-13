package myShopper.common.interfaces
{
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IDataManager extends IEventDispatcher
	{
		/**
		 * the last asset id which just added
		 */
		function get lastAddedAssetID():String;
		
		/**
		 * the asset object which container a pack of data
		 * @param	inAsset - asset object
		 * @param	inAssetID - asset id (key) for retrieving data
		 * @return	true if successfully added
		 */
		function addAsset(inAsset:Object, inAssetID:String):Boolean;
		
		/**
		 * to get the added asset object
		 * @param	inAssetID - an identifier for retrieving asset object
		 * @return	asset object if successfully found
		 */
		function getAsset(inAssetID:String):*;
		
		/**
		 * check whather asset object exist in list
		 * @param	inAssetID - an identifier for checking asset object
		 * @return	true if asset found
		 */
		function hasAsset(inAssetID:String):Boolean;
		
		/**
		 * to remove existing asset from list
		 * @param	inAssetID - an identifier for removing asset object
		 * @return	true if successfully removed
		 */
		function removeAsset(inAssetID:String):Boolean;
		
		/**
		 * to get data from a added asset object
		 * @param	inID - the data id
		 * @param	inAssetID - asset id
		 * @return
		 */
		function getData(inID:*,  inAssetID:String):*;
		
		/**
		 * check whather an asset object containing the targeted data object
		 * @param	inDataID - data id
		 * @param	inAssetID - asset id
		 * @return	true if data object found
		 */
		function hasData(inDataID:*,  inAssetID:String):Boolean;
		
		
	}
	
}