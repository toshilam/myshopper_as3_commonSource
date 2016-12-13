package myShopper.common.data 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import myShopper.common.events.VOEvent;
	import myShopper.common.interfaces.IVO;
	
	[Event(name="valueChanged", type="myShopper.common.events.VOEvent")] 
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class VO extends EventDispatcher implements IVO 
	{
		//protected static var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _selectedLangCode:String;
		
		protected var _id:String;
		
		public function VO(inID:String, inLangCode:String = '') 
		{
			super();
			_id = inID;
			_selectedLangCode = inLangCode;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(inValue:String):void 
		{
			_id = inValue;
		}
		
		public function get selectedLangCode():String 
		{
			return _selectedLangCode;
		}
		
		public function set selectedLangCode(value:String):void 
		{
			_selectedLangCode = value;
		}
		
		public function clear():void 
		{
			
		}
		
		public function clone():IVO 
		{
			return null;
		}
		
		protected function dispatchChangeEvent(inPropertyName:String, inValue:Object):void
		{
			dispatchEvent(new VOEvent(VOEvent.VALUE_CHANGED, null, this, inPropertyName, inValue));
		}
		
		/*public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public static function dispatchEvent(event:Event):Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		
		public static function hasEventListener(type:String):Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean
		{
			return _dispatcher.willTrigger(type);
		}*/
		
	}

}