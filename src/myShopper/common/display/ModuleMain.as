package myShopper.common.display 
{
	import flash.display.DisplayObjectContainer;
	import myShopper.common.data.SetupVO;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IModuleMain;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ModuleMain extends ApplicationDisplayObject implements IModuleMain 
	{
		protected var _moduleName:String = 'moduleMain';
		
		protected var _container:IApplicationDisplayObject;
		protected var _setupVO:SetupVO;
		
		
		public function ModuleMain() 
		{
			super();
		}
		
		public function setup(inContainer:DisplayObjectContainer, inSetupVO:IVO = null):Boolean 
		{
			if (!(inSetupVO is SetupVO) || !(inContainer is IApplicationDisplayObject))
			{
				Tracer.echo(moduleName + ' : setup() : unknow data type!', this, 0xff0000);
				return false;
			}
			
			_container = inContainer as IApplicationDisplayObject;
			_setupVO = inSetupVO as SetupVO;
			
			Tracer.echo(moduleName + ' : setup()', this, 0xff0000);
			
			return true;
		}
		
		/*public function get language():String 
		{
			return _setupVO.language;
		}*/
		
		public function get moduleName():String 
		{
			return _moduleName;
		}
		
		public function get view():IApplicationDisplayObject 
		{
			return _container;
		}
		
		public function get assetManager():IDataManager 
		{
			return _setupVO.assetManager;
		}
		
		public function get xmlManager():IDataManager 
		{
			return _setupVO.xmlManager;
		}
		
		public function get settingManager():IDataManager 
		{
			return _setupVO.settingManager;
		}
		
		public function get serviceManager():IDataManager 
		{
			return _setupVO.serviceManager;
		}
		
		public function get voManager():IDataManager 
		{
			return _setupVO.voManager;
		}
		
		public function get soundManager():IDataManager 
		{
			return _setupVO.soundManager;
		}
		
		public function get setupVO():SetupVO 
		{
			return _setupVO;
		}
	}

}