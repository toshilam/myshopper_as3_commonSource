package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class FacebookEvent extends ApplicationEvent 
	{
		public static const RECEIVED_FD_DATA:String = 'receivedFdData';
		public static const SEND_ME_FEED:String = 'sendMeFeed';
		public static const SEND_FD_FEED:String = 'sendFdFeed';
		public static const LIKE:String = 'like';
		
		public function FacebookEvent(type:String, inTargetButton:DisplayObject = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			
			super(type, (inTargetButton as DisplayObject), inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new FacebookEvent(type, _targetDisplayObject as DisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FacebookEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}