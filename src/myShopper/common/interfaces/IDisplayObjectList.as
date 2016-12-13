package myShopper.common.interfaces 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IDisplayObjectList 
	{
		function get length():uint;
		
		function clear():void;
		
		function addDisplayObject(inDisplayObject:IApplicationDisplayObject):void;
		
		function removeDisplayObject(inDisplayObject:IApplicationDisplayObject):IApplicationDisplayObject;
		
		/**
		 * it return the object which matched with this object name or id
		 * @param	inDisplayObjectID - name or id of this object
		 * @return
		 */
		function getDisplayObjectByID(inDisplayObjectID:String):IApplicationDisplayObject;
		
		function getDisplayObjectByIndex(inDisplayObjectIndex:uint):IApplicationDisplayObject;
	}
	
}