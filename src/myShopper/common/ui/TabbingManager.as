package myShopper.common.ui 
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import myShopper.common.interfaces.IForm;
	import myShopper.common.utils.Tracer;
	/**
	 * Managing keyboard tab from user
	 * @author Toshi
	 */
	public class TabbingManager extends EventDispatcher
	{
		private static var instance:TabbingManager;
		
		
		private var _stage:Stage;
		public function set stage(value:Stage):void 
		{
			_stage = value;
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyboardEventHandler);
		}
		
		private var _tabForm:IForm;
		private var _tabObject:InteractiveObject;
		
		public function TabbingManager(pvt:PrivateClass) 
		{
			
		}
		
		public static function getInstance():TabbingManager
		{
			if (TabbingManager.instance == null) 
			{
				TabbingManager.instance = new TabbingManager(new PrivateClass());
			}
			
			return TabbingManager.instance;
		}
		
		public function setTabForm(inForm:IForm):Boolean
		{
			_tabForm = inForm;
			_tabObject = null;
			
			/*var numItem:int = _tabForm.arrFormElement.length;
			if (numItem)
			{
				for (var i:int = 0; i < numItem; i++)
				{
					var target:InteractiveObject = _tabForm.arrFormElement[i] as InteractiveObject;
					if (target)
					{
						_stage.focus = target;
						break;
					}
				}
				
			}*/
			
			return true;
		}
		
		public function getTabForm():IForm
		{
			return _tabForm;
		}
		
		public function getTabFormObjectIndex():int
		{
			if (_tabForm)
			{
				if (_stage.focus)
				{
					return _tabForm.arrFormElement.indexOf(_stage.focus);
				}
			}
			
			return -1;
		}
		
		private function keyboardEventHandler(e:KeyboardEvent):void 
		{
			if (!_tabForm)
			{
				return;
			}
			
			if (!_stage)
			{
				Tracer.echo('TabbingManager : data not set!');
				return;
			}
			
			if (e.keyCode == Keyboard.TAB && _tabForm.arrFormElement.length)
			{
				var currTabIndex:int = getTabFormObjectIndex();
				var numTabObject:int = _tabForm.arrFormElement ? _tabForm.arrFormElement.length : 0;
				var targetTabIndex:int;
				
				if (e.shiftKey)
				{
					targetTabIndex = currTabIndex == -1 || currTabIndex - 1 < 0 ? numTabObject - 1 : currTabIndex - 1;
				}
				else
				{
					targetTabIndex = currTabIndex == -1 || currTabIndex + 1 >= numTabObject ? 0 : currTabIndex + 1;
				}
				
				_tabObject = _tabForm.arrFormElement[targetTabIndex] as InteractiveObject;
				
				if (_tabObject)
				{
					_stage.focus = _tabObject;
				}
				
			}
		}
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}