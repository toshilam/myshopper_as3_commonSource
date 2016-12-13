package myShopper.common.display.button 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.display.DisplayObjectList;
	import myShopper.common.events.ButtonEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IButton;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	
	[Event(name = "buttonClick", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonOver", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonOut", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonUp", type = "myShopper.common.events.ButtonEvent")] 
	[Event(name = "buttonDown", type = "myShopper.common.events.ButtonEvent")] 
	
	public class Button extends ApplicationDisplayObject implements IButton
	{
		// these functions to be implemented by child object
		public var onMouseClick:Function;
		public var onMouseOver:Function;
		public var onMouseOut:Function;
		public var onMouseUp:Function;
		public var onMouseDown:Function;
		//on stage resize
		public var onResize:Function;
		
		protected var _dispatcherList:DisplayObjectList;
		public function get dispatcherList():DisplayObjectList { return _dispatcherList; }
		
		
		
		public function Button() 
		{
			super();
			
			_dispatcherList = new DisplayObjectList();
			
			onMouseClick 	= new Function();
			onMouseOver 	= new Function();
			onMouseOut 		= new Function();
			onMouseUp 		= new Function();
			onMouseDown 	= new Function();
			onResize 		= new Function();
		}
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			
			startListener();
		}
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			stopListener();
			if (_dispatcherList)
			{
				_dispatcherList.clear();
			}
			
			_dispatcherList = null;
			onMouseClick 	= null;
			onMouseOver 	= null;
			onMouseOut 		= null;
			onMouseUp 		= null;
			onMouseDown 	= null;
			onResize 		= null;
			
		}
		
		public function init(inSource:*):*
		{
			return null;
		}
		
		public function startListener():void
		{
			if (!hasEventListener(MouseEvent.CLICK))
			{
				addEventListener(MouseEvent.CLICK, 		mouseEventHandler);
				addEventListener(MouseEvent.MOUSE_UP, 	mouseEventHandler);
				addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);
				addEventListener(MouseEvent.MOUSE_OUT, 	mouseEventHandler);
				addEventListener(MouseEvent.MOUSE_OVER, mouseEventHandler);
			}
			
			useHandCursor = true;
			buttonMode = true;
		}
		
		public function stopListener():void
		{
			if (hasEventListener(MouseEvent.CLICK))
			{
				removeEventListener(MouseEvent.CLICK, 		mouseEventHandler);
				removeEventListener(MouseEvent.MOUSE_UP, 	mouseEventHandler);
				removeEventListener(MouseEvent.MOUSE_DOWN, 	mouseEventHandler);
				removeEventListener(MouseEvent.MOUSE_OUT, 	mouseEventHandler);
				removeEventListener(MouseEvent.MOUSE_OVER, 	mouseEventHandler);
			}
			
			useHandCursor = false;
			buttonMode = false;
			//alpha = .6;
		}
		
		protected function mouseEventHandler(e:MouseEvent):void 
		{
			//Tracer.echo(name + " : mouseEventHandler : type : " + e.type, this, 0xff0000);
			switch(e.type)
			{
				case MouseEvent.CLICK: 
				case MouseEvent.MOUSE_OVER:
				case MouseEvent.MOUSE_OUT:
				case MouseEvent.MOUSE_UP:
				case MouseEvent.MOUSE_DOWN:
				{
					getFunctionByEventType(e.type)(); 
					dispatchEvent(getEventByMouseEventType(e.type, e));
					
					break;
				}
			}
			
			dispatchEventToDispatcher(e);
		}
		
		protected function getFunctionByEventType(inType:String):Function
		{
			if 		(inType == MouseEvent.CLICK) 		return onMouseClick;
			else if (inType == MouseEvent.MOUSE_OVER) 	return onMouseOver;
			else if (inType == MouseEvent.MOUSE_OUT) 	return onMouseOut;
			else if (inType == MouseEvent.MOUSE_UP) 	return onMouseUp;
			else if (inType == MouseEvent.MOUSE_DOWN) 	return onMouseDown;
			
			Tracer.echo(name + ' : getFunctionByEventType no matched tyep found!');
			return new Function;
		}
		
		protected function getEventByMouseEventType(inType:String, inEvent:Event):Event
		{
			if 		(inType == MouseEvent.CLICK) 		return new ButtonEvent(ButtonEvent.CLICK,	this, null, false, false, inEvent);
			else if (inType == MouseEvent.MOUSE_OVER) 	return new ButtonEvent(ButtonEvent.OVER, 	this, null, false, false, inEvent);
			else if (inType == MouseEvent.MOUSE_OUT) 	return new ButtonEvent(ButtonEvent.OUT, 	this, null, false, false, inEvent);
			else if (inType == MouseEvent.MOUSE_UP) 	return new ButtonEvent(ButtonEvent.UP, 		this, null, false, false, inEvent);
			else if (inType == MouseEvent.MOUSE_DOWN) 	return new ButtonEvent(ButtonEvent.DOWN, 	this, null, false, false, inEvent);
			
			Tracer.echo(name + ' : getEventTypeByMouseEventType no matched tyep found!');
			return null;
		}
		
		protected function dispatchEventToDispatcher(e:Event):void
		{
			if (_dispatcherList)
			{
				for (var i:int = 0; i < _dispatcherList.length; i++)
				{
					if 
					(
						e.type == MouseEvent.CLICK 		||
						e.type == MouseEvent.MOUSE_OVER ||
						e.type == MouseEvent.MOUSE_OUT 	||
						e.type == MouseEvent.MOUSE_UP 	||
						e.type == MouseEvent.MOUSE_DOWN
					)
					{
						_dispatcherList.getDisplayObjectByIndex(i).dispatchEvent(getEventByMouseEventType(e.type, e));
					}
				}
			}
			
		}
		
		
		
		
		public function addDispatcher(inListenObject:IApplicationDisplayObject):void
		{
			_dispatcherList.addDisplayObject(inListenObject);
		}
		
		public function getDispatcher(inIndex:int = -1):*
		{
			if (inIndex == -1) return _dispatcherList;
			return _dispatcherList.getDisplayObjectByIndex(inIndex);
		}
		
		override public function onStageResize(inAppStage:Stage):void 
		{
			super.onStageResize(inAppStage)
			onResize();
		}
		
		
		//override public function closePage(inObjTweenerEffect:Object = null):void 
		//{
			//super.closePage(TweenerEffect.setAlpha(0, .2, "easeInSine"));
			//Tweener.addTween(ApplicationDisplayObject(this), TweenerEffect.setAlpha(0, .2, "easeInSine"/*, function():void { isClosed = true; }*/ ));
		//}
		
		
		
	}

}