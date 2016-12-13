package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.data.AlerterVO;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class AlerterEvent extends ApplicationEvent 
	{
		public static const CONFIRM:String = 'confirm';
		public static const CANCEL:String = 'cancel';
		public static const CLOSE:String = 'close';
		
		protected var _vo:AlerterVO;
		public function get vo():AlerterVO { return _vo; }
		
		public function AlerterEvent(type:String, inDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, inDisplayObject, inData, bubbles, cancelable);
			
			_vo = inData as AlerterVO;
		} 
		
		public override function clone():Event 
		{ 
			return new AlerterEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AlerterEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}