package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopperEvent extends ApplicationEvent 
	{
		public static const NAME:String = 'ShopperEvent';
		
		public static const CONTACT_US:String = 'ContactUs';
		
		public function ShopperEvent(type:String, inTargetDisplayObject:DisplayObject=null, inData:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, inTargetDisplayObject, inData, bubbles, cancelable);
			
		}
		
		public override function clone():Event 
		{ 
			return new ShopperEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ShopperEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}

}