package myShopper.common.display 
{
	import flash.display.DisplayObject;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDisplayObjectList;
	/**
	 * ...
	 * @author Toshi
	 */
	public class DisplayObjectList implements IDisplayObjectList
	{
		private var _arrDisplayObject:Vector.<IApplicationDisplayObject>;
		
		public function DisplayObjectList() 
		{
			_arrDisplayObject = new Vector.<IApplicationDisplayObject>();
		}
		
		/* INTERFACE myShopper.common.interfaces.IDisplayObjectList */
		
		public function get length():uint
		{
			return _arrDisplayObject.length;
		}
		
		public function addDisplayObject(inDisplayObject:IApplicationDisplayObject):void
		{
			_arrDisplayObject.push(inDisplayObject);
		}
		
		public function removeDisplayObject(inDisplayObject:IApplicationDisplayObject):IApplicationDisplayObject
		{
			var targetObjectIndex:int = _arrDisplayObject.indexOf(inDisplayObject);
			if (targetObjectIndex == -1) return null;
			return _arrDisplayObject.splice(targetObjectIndex, 1)[0];
		}
		
		/**
		 * it return the object which matched with this object name or id
		 * @param	inDisplayObjectID - name or id of this object
		 * @return
		 */
		public function getDisplayObjectByID(inDisplayObjectID:String):IApplicationDisplayObject
		{
			for (var i:uint = 0 ; i < _arrDisplayObject.length; i++)
			{
				if 
				(
					DisplayObject(_arrDisplayObject[i]).name == inDisplayObjectID ||
					_arrDisplayObject[i].id == inDisplayObjectID 
				)
				{
					return _arrDisplayObject[i];
				}
			}
			return null;
		}
		
		public function getDisplayObjectByIndex(inDisplayObjectIndex:uint):IApplicationDisplayObject
		{
			return _arrDisplayObject[inDisplayObjectIndex];
		}
		
		public function clear():void 
		{
			_arrDisplayObject.length = 0;
			//_arrDisplayObject = null;
		}
		
	}

}