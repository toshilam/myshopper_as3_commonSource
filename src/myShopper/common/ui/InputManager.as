package myShopper.common.ui 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.events.ButtonEvent;
	import myShopper.common.interfaces.IInputEditor;
	import myShopper.common.utils.Tools;
	
	/**
	 * for mobile uses only
	 * @author Toshi
	 */
	public class InputManager extends EventDispatcher
	{
		private static var instance:InputManager;
		
		private static var _container:ApplicationDisplayObject; //the container that contain editor
		private static var _editor:IInputEditor;
		private static var _stage:Stage;
		private static var _currTarget:TextField; //target textField
		
		
		public function InputManager(pvt:PrivateClass) 
		{
			
		}
		
		public static function getInstance(inContainer:ApplicationDisplayObject = null, inStage:Stage = null, inEditor:IInputEditor = null):InputManager
		{
			if (InputManager.instance == null) 
			{
				_container = inContainer;
				_stage = inStage;
				_editor = inEditor;
				
				if (!_container || !_stage || !_editor)
				{
					throw new UninitializedError('InputManager : getInstance : unknow data object!');
				}
				
				if (!Tools.isIPad())
				{
					_stage.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, eventHandler);
					_stage.addEventListener(SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, eventHandler);
					
					_editor.textField.addEventListener(Event.CHANGE, inputEventHandler);
					_editor.button.addEventListener(ButtonEvent.CLICK, buttonEventHandler);
				}
				
				InputManager.instance = new InputManager(new PrivateClass());
			}
			
			return InputManager.instance;
		}
		
		static private function inputEventHandler(e:Event):void 
		{
			if (_stage.focus === _editor.textField && _currTarget)
			{
				_currTarget.text = _editor.textField.text;
				_currTarget.dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		static private function buttonEventHandler(e:ButtonEvent):void 
		{
			keyboardDeactivate();
		}
		
		private static function eventHandler(e:SoftKeyboardEvent):void 
		{
			if (e.type == SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE)
			{
				keyboardDeactivate();
			}
			else if (e.type == SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE)
			{
				keyboardActivate();
			}
		}
		
		static private function keyboardActivate():void 
		{
			if ( !_currTarget && isInputTextField(_stage.focus as TextField) )
			{
				_container.addApplicationChild(_editor, null, false);
				
				setFocusWithValue(_stage.focus as TextField);
				
				//disable tabbing, as hard to manage which one to be tabbed
				_stage.addEventListener(KeyboardEvent.KEY_UP, keyboardEventHandler);
				//_stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, focusEventHandler);
				
			}
		}
		
		static private function keyboardDeactivate():void 
		{
			_stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardEventHandler);
			//_stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, focusEventHandler);
			
			_container.removeApplicationChild(_editor, false);
			
			if ( isInputTextField(_currTarget) )
			{
				_currTarget.text = _editor.textField.text;
				_stage.focus = null;
			}
			
			_currTarget = null;				
		}
		
		
		/*static private function focusEventHandler(e:FocusEvent):void 
		{
			if (_container.hasApplicationChild(_editor) && isInputTextField(_currTarget))
			{
				_currTarget.text = _editor.textField.text;
			}
			
			if ( !setFocusWithValue(_stage.focus as TextField) )
			{
				keyboardDeactivate();
			}
		}*/
		
		private static function isInputTextField(inData:TextField):Boolean
		{
			return inData && inData.type == TextFieldType.INPUT;
		}
		
		private static function setFocusWithValue(inData:TextField):Boolean
		{
			if ( _container.hasApplicationChild(_editor) && isInputTextField(inData as TextField) )
			{
				_currTarget = inData as TextField;
				_editor.textField.text = _currTarget.text;
				_editor.textField.multiline = _currTarget.multiline;
				_editor.textField.restrict = _currTarget.restrict;
				_editor.textField.displayAsPassword = _currTarget.displayAsPassword;
				_stage.focus = _editor.textField;
				
				return true;
			}
			
			return false;
		}
		
		private static function keyboardEventHandler(e:KeyboardEvent):void 
		{
			if (!_editor || !_stage)
			{
				return;
			}
			
			if (e.keyCode == Keyboard.TAB)
			{
				e.preventDefault();
                e.stopImmediatePropagation();
			}
		}
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}