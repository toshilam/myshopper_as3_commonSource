package myShopper.common.interfaces 
{
	import flash.display.Stage;
	
	[Event(name = "pageClosed", type = "myShopper.common.events.ApplicationEvent")]
	
	[Event(name = "pageShow", type = "myShopper.common.events.ApplicationEvent")]
	
	[Event(name = "ChildAdded", type = "myShopper.common.events.ApplicationEvent")]
	
	[Event(name = "Childremoved", type = "myShopper.common.events.ApplicationEvent")]
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IApplicationDisplayObject extends IResizeableDisplayObject
	{
		function get id():String;
		
		function set id(inID:String):void;
		/**
		 * the setting of this display object itself
		 */
		function get XMLSetting():XML;
		
		/**
		 * a list of sub display objects which are under this object
		 */
		function get subDisplayObjectList():IDisplayObjectList;
		
		/**
		 * to init the display object ifself, set position, size, txt ...
		 * @param	inDisplayObject - setting source
		 * @param	inStage - main stage
		 */
		function initDisplayObject(inSettingSource:Object, inStage:Stage):void;
		
		/**
		 * to remove all the veriables, listeners which were added initDisplayObject
		 */
		//function destroyDisplayObject():void
		
		/**
		 * 
		 * @param	inApplicationDisplayObject - the display object to be added into diplayObject list, and this parent object
		 * @param	inSettingSource - setting source
		 * @param	inStage - main stage (NOTE : this will not be used)
		 * @return  the added display object
		 */
		function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, /*inStage:Stage,*/ autoShowPage:Boolean = true):IApplicationDisplayObject;
		
		/**
		 * 
		 * @param	inApplicationDisplayObject - the display object to be added into diplayObject list, and this parent object
		 * @param	inSettingSource - setting source
		 * @param	inStage - main stage (NOTE : this will not be used)
		 * @return  the added display object
		 */
		function addApplicationChildAt(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, /*inStage:Stage,*/ inIndex:uint = 0, autoShowPage:Boolean = true):IApplicationDisplayObject;
		
		/**
		 * 
		 * @param	inApplicationDisplayObject - the display object to be removed from displayObject list, and this parent object
		 * @param	autoClosePage - call closePage() before removeChild if true, else call removeChild directly
		 */
		function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = true):void;
		
		/**
		 * indicate whather this display object contain the 'inApplicationDisplayObject' child object
		 * @param	inApplicationDisplayObject - the object to be checked
		 * @return true if display object found
		 */
		function hasApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject):Boolean
		
		/**
		 * to init the display object position
		 * @param	inAppStage
		 */
		//function initDisplayObjectPosition(inAppStage:Stage):void;
	}
	
}