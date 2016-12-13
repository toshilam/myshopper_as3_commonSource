package myShopper.common.display 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IButton;
	import myShopper.common.interfaces.IDisplayObjectList;
	import myShopper.common.interfaces.IMenu;
	import myShopper.common.utils.TweenerEffect;
	import myShopper.common.utils.XMLAttributesConvertor;
	import myShopper.common.display.button.Button;
	import myShopper.common.utils.Tracer;
	
	/// @eventType	myShopper.common.events.ApplicationEvent.BUTTONS_REMOVED
	//[Event(name = "buttonsRemoved", type = "myShopper.common.events.ApplicationEvent")]
	
	/**
	 * this class has to be used with swf lib, always have to re-complie swf lib after making changes in this class
	 * @author Toshi
	 */
	public class Menu extends MaskedDisplayObject implements IMenu
	{
		public static const LAYOUT_HORIZONTAL:String = 'horizontal';
		public static const LAYOUT_VERTICAL:String = 'vertical';
		public static const LAYOUT_DISTANCE:int = 10;
		
		//item list only contain the button object which will be positioning / subDisplayObjectList contain any type of object
		protected var _itemList:DisplayObjectList;
		public function get itemList():DisplayObjectList { return _itemList; }
		
		protected var _initPoint:Point;
		
		
		protected var _layoutType:String;
		public function get layoutType():String
		{
			return _layoutType;
		}
		
		protected var _layoutDistance:int;
		public function get layoutDistance():int
		{
			return _layoutDistance;
		}
		
		public function Menu() 
		{
			super();
			
			_itemList = new DisplayObjectList();
			_initPoint = new Point();
			_layoutType = LAYOUT_HORIZONTAL;
			_layoutDistance = LAYOUT_DISTANCE;
		}
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			_itemList.clear();
		}
		
		override public function get subDisplayObjectList():IDisplayObjectList 
		{
			return _itemList;
		}
		
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			
		}
		
		/**
		 * add a list of buttons into this menu, plus remove the previous buttons if any
		 * @param	inButtonList
		 * @param	inLayout
		 */
		override public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, /*inStage:Stage,*/ autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			/*if (!(inApplicationDisplayObject is IButton))
			{
				Tracer.echo(name + ' : Menu : addApplicationChild : unknown object type : ' + inApplicationDisplayObject, this, 0xff0000);
				return null;
			}*/
			
			var o:IApplicationDisplayObject = inApplicationDisplayObject;
			_itemList.addDisplayObject(o);
			
			super.addApplicationChild(o, inSettingSource, /*inStage,*/ autoShowPage);
			setLayout(_layoutType, _layoutDistance);
			return o;
		}
		
		override public function addApplicationChildAt(inObject:IApplicationDisplayObject, inSettingSource:Object, /*inStage:Stage,*/ inIndex:uint = 0, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			Tracer.echo(name + ' : Menu : addApplicationChildAt : call disabled function : ' + inObject, this, 0xff0000);
			return null;
		}
		
		override public function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = true):void 
		{
			super.removeApplicationChild(inApplicationDisplayObject, autoClosePage);
			_itemList.removeDisplayObject(inApplicationDisplayObject);
		}
		
		
		public function setLayout(inLayout:String = LAYOUT_HORIZONTAL, inDistance:int = LAYOUT_DISTANCE, inInitPoint:Point = null):void
		{
			if (inLayout != LAYOUT_VERTICAL && inLayout != LAYOUT_HORIZONTAL)
			{
				Tracer.echo(name + " : Menu : setLayout : unknown layout type : " + inLayout, this, 0xff0000);
				return;
			}
			
			if (inInitPoint) _initPoint = inInitPoint;
			_layoutType = inLayout;
			_layoutDistance = inDistance;
			
			setPosition();
		}
		
		protected function setPosition():void
		{
			var xy:String = (_layoutType == LAYOUT_HORIZONTAL) ? 'x' : 'y';
			var xy2:String = (_layoutType == LAYOUT_HORIZONTAL) ? 'y' : 'x';
			var wh:String = (_layoutType == LAYOUT_HORIZONTAL) ? 'width' : 'height';
			
			var numItem:int = _itemList.length;
			for (var i:int = 0; i < numItem; i++)
			{
				//NOTE : only ordering button object, avoid to order other type of object
				//CHANGED : 22/05/2012 : ordering applicationDisplay not only button
				//var b:Button = _itemList.getDisplayObjectByIndex(i) as Button;
				var b:ApplicationDisplayObject = _itemList.getDisplayObjectByIndex(i) as ApplicationDisplayObject;
				
				if (b)
				{
					if (i)
					{
						var targetItem:ApplicationDisplayObject = _itemList.getDisplayObjectByIndex(i - 1) as ApplicationDisplayObject;
						b[xy] = targetItem[xy] + targetItem[wh] + _layoutDistance;
					}
					else
					{
						b[xy] = _initPoint[xy];
					}
					
					b[xy2] = _initPoint[xy2];
				}
				else
				{
					Tracer.echo(name + ' : setPosition : unable to get object/unknown object type : ' + _itemList.getDisplayObjectByIndex(i), this, 0xff0000);
					continue;
				}
				
				Tracer.echo(name + ' : setPosition : ' + b.name + ' : x :' + b.x + ', y :' + b.y + ', width : ' + b.width + ', height : ' + b.height);
			}
		}
		
		public function removeAllButton():void
		{
			if (_itemList.length)
			{
				
				var numItem:int = subDisplayObjectList.length;
				for (var i:int = 0; i < numItem; i++)
				{
					var b:IApplicationDisplayObject = subDisplayObjectList.getDisplayObjectByIndex(0);
					
					if (b)
					{
						removeApplicationChild(b, false)
					}
				}
				
			}
		}
		
		public function refresh():void
		{
			setPosition();
		}
		
		public function disable():void
		{
			setMenuItem('stopListener');
		}
		
		public function enable():void
		{
			setMenuItem('startListener');
		}
		
		protected function setMenuItem(inFunctionName:String):void
		{
			if (subDisplayObjectList.length)
			{
				var numItem:int = subDisplayObjectList.length;
				for (var i:int = 0; i < numItem; i++)
				{
					var b:Button = subDisplayObjectList.getDisplayObjectByIndex(i) as Button;
					
					if (b && b[inFunctionName])
					{
						b[inFunctionName]();
					}
				}
				
			}
		}
		
		/*public function addButtons(inButtonList:IButtonList, inLayout:String = 'layoutHorizontal' ):void
		{
			if (inButtonList == null) return;
			
			if (_buttonList != null && _buttonList.length > 0) 
			{
				removeButtons();
			}
			
			_buttonList = inButtonList;
			
			var xy:String = (inLayout == LAYOUT_HORIZONTAL) ? 'x' : 'y';
			var wh:String = (inLayout == LAYOUT_HORIZONTAL) ? 'width' : 'height';
			
			for (var i:int = 0; i < _buttonList.length; i++)
			{
				Button(_buttonList.getButtonByIndex(i))[xy] = (!i) ? 0 : Button(_buttonList.getButtonByIndex(i - 1))[xy] + Button(_buttonList.getButtonByIndex(i - 1))[wh] + Config.BUTTON_GAP;
				
				addApplicationChild(Button(_buttonList.getButtonByIndex(i)), null, null, false);
				
				Button(_buttonList.getButtonByIndex(i)).showPage(TweenerEffect.setAlphaWithDelay(1, .5, i * .2));
			}
			
		}*/
		/*
		public function removeButtons():IButtonList
		{
			if (_buttonList != null && _buttonList.length > 0)
			{
				var numButton:uint = _buttonList.length;
				for (var i:int = 0; i < numButton; i++)
				{
					var button:Button = _buttonList.removeButton() as Button;
					//only listen the list button is removed from stage
					if (i == numButton -1) button.addEventListener(ApplicationEvent.PAGE_CLOSED, buttonEventHandler);
					
					removeApplicationChild(button);
				}
			}
			
			return _buttonList;
			
			//if (_buttonList == null || _buttonList.length == 0) 
			//{
				//_buttonList = null;
				//dispatchEvent(new ApplicationEvent(ApplicationEvent.BUTTONS_REMOVED));
				//return null;
			//}
			//
			//
			//var targetButton:IButton = _buttonList.removeButton();
			//Button(targetButton).addEventListener(ApplicationEvent.PAGE_CLOSED, function(e:ApplicationEvent):void { removeButtons(); } );
			//removeApplicationChild(targetButton);
			//
			//return _buttonList;
		}*/
		
		/*private function buttonEventHandler(e:ApplicationEvent):void 
		{
			dispatchEvent(new ApplicationEvent(ApplicationEvent.BUTTONS_REMOVED));
		}*/
		
		/*public function getButtonByID(inButtonID:String):IButton
		{
			return _buttonList.getButtonByID(inButtonID);
		}
		
		public function getButtonByIndex(inButtonIndex:uint):IButton
		{
			return _buttonList.getButtonByIndex(inButtonIndex);
		}*/
		
	}

}