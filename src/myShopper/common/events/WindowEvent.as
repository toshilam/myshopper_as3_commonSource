package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.data.AlerterVO;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.utils.Tracer;
	import myShopper.fl.window.BaseWindow;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class WindowEvent extends ApplicationEvent 
	{
		public static const NAME:String = 'WindowEvent';
		
		public static const CREATE:String = NAME + 'Create';
		public static const CLOSE:String = NAME + 'Close';
		
		private var _window:BaseWindow
		public function get window():BaseWindow 
		{
			return _window;
		}
		
		public function get windowID():String
		{
			return _window ? _window.id : '';
		}
		
		public function WindowEvent(type:String, inDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, inDisplayObject, inData, bubbles, cancelable);
			_window = inDisplayObject as BaseWindow;
		} 
		
		public override function clone():Event 
		{ 
			return new WindowEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WindowEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
		
		
	}
	
}