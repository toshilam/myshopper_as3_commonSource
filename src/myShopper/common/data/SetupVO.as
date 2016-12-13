package myShopper.common.data 
{
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class SetupVO extends VO 
	{
		protected var _assetManager:IDataManager;
		protected var _xmlManager:IDataManager;
		protected var _settingManager:IDataManager;
		protected var _serviceManager:IDataManager;
		protected var _soundManager:IDataManager;
		protected var _voManager:IDataManager;
		
		protected var _language:String;
		protected var _prefixURL:String;
		public var parameters:Object;
		
		public function SetupVO
		(
			inID:String, 
			inAssetManager:IDataManager, 
			inXMLManager:IDataManager, 
			inSettingManager:IDataManager,
			inServiceManager:IDataManager,
			inVOManager:IDataManager,
			inLanguage:String = 'cht',
			inPrefixURL:String = '',
			inSoundManager:IDataManager = null
		) 
		{
			super(inID);
			
			_assetManager = inAssetManager;
			_xmlManager = inXMLManager;
			_settingManager = inSettingManager;
			_serviceManager = inServiceManager;
			_soundManager = inSoundManager;
			_voManager = inVOManager;
			_language = inLanguage;
			
			_prefixURL = inPrefixURL;
		}
		
		
		public function get assetManager():IDataManager 
		{
			return _assetManager;
		}
		
		public function get xmlManager():IDataManager 
		{
			return _xmlManager;
		}
		
		public function get settingManager():IDataManager 
		{
			return _settingManager;
		}
		
		public function get serviceManager():IDataManager 
		{
			return _serviceManager;
		}
		
		public function get voManager():IDataManager 
		{
			return _voManager;
		}
		
		public function get soundManager():IDataManager
		{
			return _soundManager
		}
		
		public function get language():String 
		{
			return _language;
		}
		
		public function set language(value:String):void 
		{
			_language = value;
		}
		
		public function get prefixURL():String 
		{
			return _prefixURL;
		}
		
		public function set prefixURL(value:String):void 
		{
			_prefixURL = value;
		}
		
		override public function clone():IVO 
		{
			return new SetupVO(_id, _assetManager, _xmlManager, _settingManager, _serviceManager, _voManager, _language, _prefixURL);
		}
	}

}