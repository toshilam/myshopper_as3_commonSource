package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.data.AlerterVO;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class VOEvent extends ApplicationEvent 
	{
		public static const VALUE_CHANGED:String = 'valueChanged';
		public static const VO_ADDED:String = 'voAdded'; //will be used on VOlist
		public static const VO_REMOVED:String = 'voRemoved'; //will be used on VOlist
		
		public var vo:IVO;
		public var propertyName:String;
		public var propertyValue:Object;
		
		public function VOEvent(type:String, inDisplayObject:DisplayObject = null, inData:Object = null, inPropertyName:String = null, inPropertyValue:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			super(type, inDisplayObject, inData, bubbles, cancelable);
			if (inData is IVO) vo = inData as IVO;
			propertyName = inPropertyName;
			propertyValue = inPropertyValue;
		} 
		
		public override function clone():Event 
		{ 
			return new VOEvent(type, _targetDisplayObject, _data, propertyName, propertyValue, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("VOEvent", "type", "bubbles", "cancelable", "eventPhase", "vo", "propertyName" , "propertyValue"); 
		}
		
		
		
	}
	
}