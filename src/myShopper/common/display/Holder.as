package myShopper.common.display 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import myShopper.common.display.button.Button;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDisplayObjectList;
	import myShopper.common.interfaces.IMaskableDisplayObject;
	import myShopper.common.interfaces.IMenu;
	import myShopper.common.interfaces.IScrollable;
	import myShopper.common.utils.Tracer;
	/**
	 * a holder contain a list of display object which are positioned in order
	 * @author Toshi Lam
	 */
	public class Holder extends MaskedDisplayObject implements IScrollable
	{
		protected var _content:Menu;
		
		public function get content():InteractiveObject
		{
			return _content;
		}
		
		override public function get subDisplayObjectList():IDisplayObjectList 
		{
			return _content.subDisplayObjectList;
		}
		
		protected var _scrollMask:ScrollMask;
		
		//NOTE : it will be dragable if the holder is set with scrollBar
		protected var _isDragable:Boolean;
		public function get isDragable():Boolean { return _isDragable; }
		public function set isDragable(value:Boolean):void 
		{
			_isDragable = value;
			_scrollMask.scrollTarget = value ? this : null;
		}
		
		public function get hasDraged():Boolean { return _scrollMask.hasMove; }
		
		public function Holder() 
		{
			super();
			
			
		}
		
		/*override public function get x():Number 
		{
			return super.x;
		}
		
		override public function set x(value:Number):void 
		{
			super.x = value;
		}*/
		
		override public function destroyDisplayObject():void 
		{
			if (_subDisplayObjectList && _subDisplayObjectList.length)
			{
				
				while (subDisplayObjectList.length)
				{
					removeApplicationChild( subDisplayObjectList.getDisplayObjectByIndex(0), false);
				}
			}
			
			super.removeApplicationChild(_content, false);
			_content = null;
		}
		
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			
			_content = super.addApplicationChild(new Menu(), null, false) as Menu;
			_scrollMask = super.addApplicationChild(new ScrollMask(_content.layoutType), null, false) as ScrollMask;
		}
		
		override public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, autoShowPage:Boolean = false):IApplicationDisplayObject 
		{
			return addItem(inApplicationDisplayObject/* as Button*/, inSettingSource);
		}
		
		override public function addApplicationChildAt(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, inIndex:uint = 0, autoShowPage:Boolean = false):IApplicationDisplayObject 
		{
			return addItem(inApplicationDisplayObject/* as Button*/, inSettingSource);
		}
		
		public function refresh():void
		{
			_scrollMask.refresh();
		}
		
		private function addItem(inItem:IApplicationDisplayObject, inSettingSource:Object):IApplicationDisplayObject
		{
			/*if (!inItem)
			{
				Tracer.echo(name + ' : addApplicationChild : unknown object type : ' + inItem, this, 0xff0000);
				return null;
			}*/
			
			return _content.addApplicationChild(inItem, inSettingSource, false);
		}
		
		override public function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = false):void 
		{
			_content.removeApplicationChild(inApplicationDisplayObject, autoClosePage);
			_content.refresh();
		}
		
		override public function setMask(inX:Number, inY:Number, inWidth:Number, inHeight:Number):void 
		{
			super.setMask(inX, inY, inWidth, inHeight);
			//_scrollMask.setMask(inX, inY, inWidth, inHeight);
		}
		
		public function setLayout(inLayout:String = 'horizontal', inDistance:int = 10, initPoint:Point = null):void 
		{
			_content.setLayout(inLayout, inDistance, initPoint);
			_scrollMask.layoutType = _content.layoutType;
			
		}
		
		public function disable():void 
		{
			_content.disable();
		}
		
		public function enable():void 
		{
			_content.enable();
		}
		
		
	}

}