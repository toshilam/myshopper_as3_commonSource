package myShopper.common.interfaces 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	[Event(name = "buttonClick", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonOver", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonOut", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonUp", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonDown", type = "myShopper.common.events.ButtonEvent")] 
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IButton extends IApplicationDisplayObject
	{
		/**
		 * to init the button object with 'inSource' if any
		 * @param	inSource - the source to be used if needed
		 * @return result if any
		 */
		function init(inSource:*):*;
		
		/**
		 * to set the button object interface by adding text
		 * @param	inText - the text to be displayed in the button interface
		 */
		//function setText(inText:String):void;
		
		/**
		 * to start listener mouse event(s)
		 */
		function startListener():void;
		
		/**
		 * to stop listener mouse event(s)
		 */
		function stopListener():void;
		
		
		/**
		 * to dispatch event to the targeted listen Object (can be more than one)
		 * @param	inDisplayObject
		 */
		function addDispatcher(inListenObject:IApplicationDisplayObject):void
		
		/**
		 * to get the list of targeted listen Object(s)
		 * @param	inDisplayObject
		 */
		function getDispatcher(inIndex:int = -1):*
		
		
		
		
	}
	
}