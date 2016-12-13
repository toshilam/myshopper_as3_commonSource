package myShopper.common.data 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import myShopper.common.events.VOEvent;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class DataVO extends VO implements ISelectableVO
	{
		protected var _isSelected:Boolean = false;
		public function get isSelected():Boolean { return _isSelected; }
		public function set isSelected(value:Boolean):void 
		{
			_isSelected = value;
		}
		
		public var data:Object;
		public var label:String;
		
		public function DataVO(inID:String, inData:Object, inLabel:String) 
		{
			super(inID);
			
			data = inData;
			label = inLabel;
		}
		
		override public function clear():void 
		{
			super.clear();
			data = null;
			label = null;
		}
		
		override public function clone():IVO 
		{
			return new DataVO(id, data, label);
		}
		
	}

}