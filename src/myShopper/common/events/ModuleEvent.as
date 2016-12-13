package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ModuleEvent extends ApplicationEvent 
	{
		public static const MODULE_READY_ALL:String = 'moduleReadyAll';
		
		
		public function ModuleEvent(type:String, inDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, inDisplayObject, inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ModuleEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ModuleEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}