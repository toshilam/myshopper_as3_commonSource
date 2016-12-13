package myShopper.common.interfaces 
{
	import flash.display.DisplayObjectContainer;
	import myShopper.common.data.SetupVO;
	
	[Event(name = "moduleReadyAll", type = "myShopper.common.events.ModuleEvent")]
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IModuleMain extends IApplicationDisplayObject
	{
		function setup(inStage:DisplayObjectContainer, inVO:IVO = null):Boolean;
		//function tearDown(inStage:DisplayObjectContainer, inVO:IVO = null):Boolean;
		
		function get view():IApplicationDisplayObject;
		
		function get moduleName():String;
		
		function get assetManager():IDataManager 
		
		function get xmlManager():IDataManager 
		
		function get settingManager():IDataManager 
		
		function get serviceManager():IDataManager 
		
		function get voManager():IDataManager 
		
		function get soundManager():IDataManager 
		
		function get setupVO():SetupVO;
		
		//function get language():String;
	}
	
}