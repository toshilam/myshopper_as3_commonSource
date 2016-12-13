package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.data.user.UserShoppingCartVO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShoppingEvent extends ApplicationEvent 
	{
		public static const ORDER:String = 'order'; //make a order and notify shop
		public static const CHECK_OUT:String = 'checkOut'; //pay now
		public static const CONFIRM_RECEIVED_ORDER:String = 'confirmReceivedOrder';
		
		//public static const PAY_SUCCESS:String = 'paySuccess';
		
		protected var _vo:IVO;
		public function get vo():IVO { return _vo; }
		
		public function ShoppingEvent(type:String, inDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, inDisplayObject, inData, bubbles, cancelable);
			
			_vo = inData as IVO;
		} 
		
		public override function clone():Event 
		{ 
			return new ShoppingEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ShoppingEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}