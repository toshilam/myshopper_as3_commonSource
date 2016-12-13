package myShopper.common.interfaces 
{
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import myShopper.common.interfaces.IDataManager;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IPage extends IEventDispatcher
	{
		/**
		 * indicate whather the display object itself has removed from stage
		 */
		function get isClosed():Boolean;
		
		/**
		 * to remove the display object from stage
		 */
		function closePage(inObjTweenerEffect:Object = null):void;
		
		/**
		 * to start showing display object to the stage
		 */
		function showPage(inObjTweenerEffect:Object = null):void;
		
		//function initLayout(inMainStage:Stage, inDataManager:IDataManager, vo:IVO):void
	}
	
}