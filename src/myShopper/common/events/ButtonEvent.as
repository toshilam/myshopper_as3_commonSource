package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.interfaces.IButton;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ButtonEvent extends ApplicationEvent 
	{
		public static const CLICK:String = 'buttonClick';
		public static const OVER:String = 'buttonOver';
		public static const OUT:String = 'buttonOut';
		public static const UP:String = 'buttonUp';
		public static const DOWN:String = 'buttonDown';
		
		public var targetButton:IButton;
		public var event:Event; //orginal event / mouse event
		
		public function ButtonEvent(type:String, inTargetButton:IButton = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false, inEvent:Event = null) 
		{ 
			targetButton = inTargetButton;
			event = inEvent;
			
			super(type, (inTargetButton as DisplayObject), inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}