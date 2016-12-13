package myShopper.common.resources 
{
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author toshi lam
	 */
	public class XMLManager extends DataManager implements IDataManager
	{
		
		public function XMLManager() 
		{
			super();
			
		}
		
		override public function addAsset(inAsset:Object, inAssetID:String):Boolean
		{
			if (_objAssets[inAssetID] != undefined || !(inAsset is XML))
			{
				Tracer.echo('XMLManager : addAsset : asset exists/invalid data type : ' + inAssetID, this, 0xff0000);
				return false;
			}
			
			_objAssets[inAssetID] = inAsset;
			_lastAddedAssetID = inAssetID;
			
			return true;
		}
		
		override public function getData(inNodeID:*, inAssetID:String):*
		{
			if (inNodeID is String && hasData(inNodeID, inAssetID))
			{
				return XML(_objAssets[inAssetID])[inNodeID];
			}
			
			return null;
		}
		
		override public function hasData(inNodeID:*, inAssetID:String):Boolean
		{
			if (_objAssets[inAssetID] == undefined || !(inNodeID is String)) 
			{
				Tracer.echo('XMLManager : hasData : inAssetID : ' + inAssetID + ' : not found!', this, 0xff0000);
				return false;
			}
			
			return XML(_objAssets[inAssetID])[inNodeID].length();
		}
		
		
		/**
		 * NOTE : xml formet is supposed to be : (data / string)
		 * @param	inID - the targeted node attribute id
		 * @param	inNodeName - target node name
		 * @param	inAssetLibID - aseet lib id 
		 * @return message if found else null
		 */
		public function getString(inID:String, inNodeName:String = 'string', inAssetLibID:String = 'langCommon'):String
		{
			var xmlList:XMLList = getData(inNodeName, inAssetLibID);
			if (xmlList && xmlList.length())
			{
				var xml:XML = xmlList.(@id == inID)[0];
				if (xml)
				{
					return xml.toString();
				}
				
				Tracer.echo('XMLManager : getString : target xml node not found!', this, 0xff0000);
				
			}
			else
			{
				Tracer.echo('XMLManager : getString : no data found!', this, 0xff0000);
			}
			
			return '';
		}
		
	}

}