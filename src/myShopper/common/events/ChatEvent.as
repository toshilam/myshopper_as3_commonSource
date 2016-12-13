package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.interfaces.IButton;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ChatEvent extends ApplicationEvent 
	{
		//shop together group chat
		public static const START_ST_USER_CHAT:String = 'startSTUserChat';
		public static const END_ST_USER_CHAT:String = 'endSTUserChat';
		public static const SEND_ST_USER_MESSAGE:String = 'sendSTUserMessage';
		public static const RECEIVE_ST_USER_MESSAGE:String = 'receiveSTUserMessage';
		
		//user
		public static const START_USER_CHAT:String = 'startUserChat';
		public static const END_USER_CHAT:String = 'endUserChat';
		public static const SEND_USER_MESSAGE:String = 'sendUserMessage';
		public static const RECEIVE_USER_MESSAGE:String = 'receiveUserMessage';
		
		//shop
		public static const START_SHOP_CHAT:String = 'startShopChat';
		public static const END_SHOP_CHAT:String = 'endShopChat';
		public static const SEND_SHOP_MESSAGE:String = 'sendShopMessage';
		public static const RECEIVE_SHOP_MESSAGE:String = 'receiveShopMessage';
		
		public function ChatEvent(type:String, inTargetButton:DisplayObject = null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			
			super(type, (inTargetButton as DisplayObject), inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ChatEvent(type, _targetDisplayObject as DisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ChatEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}