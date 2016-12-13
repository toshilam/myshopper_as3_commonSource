package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class GoogleEvent extends ApplicationEvent 
	{
		public static const NAME:String = 'googleEvent';
		
		public static const LOGIN:String = NAME + 'Login';
		public static const PRINTER_SEARCH:String = NAME + 'printerSearch';
		
		
		public function GoogleEvent(type:String, inTarget:DisplayObject = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			
			super(type, inTarget, inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GoogleEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GoogleEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}