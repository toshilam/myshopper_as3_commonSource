package myShopper.common.display 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IScrollable;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ScrollMask extends ApplicationDisplayObject 
	{
		public var initPoint:Point;
		private var _offset:Point;
		private var _extraSpace:int;
		
		private var _hasMove:Boolean;
		public function get hasMove():Boolean {return _hasMove;}
		
		private var _layoutType:String;
		public function get layoutType():String { return _layoutType; }
		public function set layoutType(inLayoutType:String):void 
		{
			_layoutType = inLayoutType != Menu.LAYOUT_VERTICAL && inLayoutType != Menu.LAYOUT_HORIZONTAL ? Menu.LAYOUT_VERTICAL : inLayoutType;
		}
		
		private var _scrollTarget:IScrollable;
		public function get scrollTarget():IScrollable {return _scrollTarget;}
		public function set scrollTarget(inValue:IScrollable):void 
		{
			_scrollTarget = inValue;
			if (_scrollTarget) initScrollBar();
			else tearDownScrollBar();
			
		}
		
		private var _hasScollBar:Boolean;
		public function get hasScollBar():Boolean {return _hasScollBar;}
		public function set hasScollBar(value:Boolean):void 
		{
			_hasScollBar = value;
		}
		
		private var _scrollSpeed:uint;
		public function get scrollSpeed():uint {return _scrollSpeed;}
		public function set scrollSpeed(value:uint):void 
		{
			_scrollSpeed = value;
		}
		
		public function get maskWH():Number 
		{
			return _scrollTarget && _scrollTarget.mask ? _scrollTarget.mask[_layoutType == Menu.LAYOUT_HORIZONTAL ? 'width' : 'height'] : 0;
		}
		
		public function get contentWH():Number 
		{
			return _scrollTarget ? _scrollTarget.content[_layoutType == Menu.LAYOUT_HORIZONTAL ? 'width' : 'height'] : 0;
		}
		
		public function ScrollMask(inLayoutType:String = 'vertical', inInitPoint:Point = null) 
		{
			super();
			layoutType = inLayoutType;
			initPoint = inInitPoint ? inInitPoint : new Point();
			_offset = new Point();
			//_mask.mouseEnabled = _mask.mouseChildren = false;
		}
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			scrollTarget = null;
		}
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			
			///*_mask.*/addEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler2);
			///*_mask.*/addEventListener(MouseEvent.MOUSE_UP, buttonEventHandler2);
			//addEventListener(ButtonEvent.OVER, buttonEventHandler2);
			//addEventListener(ButtonEvent.OUT, buttonEventHandler2);
			//_mask.alpha = 0.5;
			_scrollSpeed = 5;
			
			disableScrollBar();
		}
		
		/*override protected function drawMark(inX:Number, inY:Number, inWidth:Number, inHeight:Number):void 
		{
			if (_mask)
			{
				_mask.graphics.clear();
				_mask.graphics.beginFill(0x000000);
				_mask.graphics.drawRect(inX, inY, inWidth, inHeight);
				_mask.graphics.endFill();
			}
			else
			{
				Tracer.echo(name + ' : drawMarker : display object is not init!', this, 0xff0000);
			}
		}
		*/
		public function refresh():void
		{
			updateTargetSpace();
		}
		
		private function disableScrollBar(inIsEnable:Boolean = false):void
		{
			mouseChildren = mouseEnabled = inIsEnable;
		}
		
		private function buttonEventHandler2(e:MouseEvent):void 
		{
			switch(e.type)
			{
				
				case MouseEvent.MOUSE_DOWN:
				{
					//_initScrollBarY = scrollBarThumb.y /*- upBtn.height*/
					_offset.x = mouseX
					_offset.y  = mouseY;
					_hasMove = false;
					/*_mask.*/_scrollTarget.content.addEventListener(/*Event.ENTER_FRAME*/MouseEvent.MOUSE_MOVE, scrollingHandler);
					_appStage.addEventListener(MouseEvent.MOUSE_UP, stageEventHandler);
					break;
				}
				case MouseEvent.MOUSE_UP:
				//case ButtonEvent.OUT:
				{
					if (/*_mask.*/_scrollTarget.content.hasEventListener(/*Event.ENTER_FRAME*/MouseEvent.MOUSE_MOVE))
					{
						/*_mask.*/_scrollTarget.content.removeEventListener(/*Event.ENTER_FRAME*/MouseEvent.MOUSE_MOVE, scrollingHandler);
						_appStage.removeEventListener(MouseEvent.MOUSE_UP, stageEventHandler);
						
						if (_hasMove)
						{
							//e..stopImmediatePropagation();
							//var arrObject:Array = _appStage.getObjectsUnderPoint(new Point(_appStage.mouseX, _appStage.mouseY));
							//trace(e.currentTarget, e.target/*, arrObject*/);
						}
					}
					break;
				}
			}
		}
		
		private function stageEventHandler(e:MouseEvent):void 
		{
			buttonEventHandler2(new MouseEvent(MouseEvent.MOUSE_UP));
		}
		
		
		private function scrollingHandler(e:Event, inCheckMouseY:Boolean = true):void 
		{
			_hasMove = true;
			
			if (_hasScollBar)
			{
				var delta:int = _layoutType == Menu.LAYOUT_HORIZONTAL ? mouseX < _offset.x ? 1 : 0 : mouseY < _offset.y ? 1 : 0;
				//_scrollTarget.content.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_WHEEL, e.bubbles, e.cancelable, null, null, this, false, false, false, false, delta));
				dispatchEvent(new ApplicationEvent(ApplicationEvent.CONTENT_CHANGING, this, Boolean( delta <= 0 )));
			}
			else
			{
				var xy:String = (_layoutType == Menu.LAYOUT_HORIZONTAL) ? 'x' : 'y';
				var targetXY:Number = 0;
				
				targetXY = _scrollTarget.content[xy];
				targetXY -= _layoutType == Menu.LAYOUT_HORIZONTAL ? mouseX < _offset.x ? _scrollSpeed : -_scrollSpeed : mouseY < _offset.y ? _scrollSpeed : -_scrollSpeed;
				
				if (targetXY > initPoint[xy])
				{
					targetXY = initPoint[xy];
				}
				else if (targetXY < _extraSpace + initPoint[xy])
				{
					targetXY = _extraSpace + initPoint[xy];
				}
				
				_scrollTarget.content[xy] = targetXY;
				
				//trace(_scrollTarget.content[xy], _offset, _extraSpace);
			}
			
			_offset.x = mouseX;
			_offset.y = mouseY;
		}
		
		private function initScrollBar():void 
		{
			scrollTarget.content.addEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler2);
			scrollTarget.content.addEventListener(MouseEvent.MOUSE_UP, buttonEventHandler2);
			scrollTarget.content.addEventListener(ApplicationEvent.CHILD_ADDED, contentEventHandler);
			scrollTarget.content.addEventListener(ApplicationEvent.CHILD_REMOVED, contentEventHandler);
			
			updateTargetSpace();
		}
		
		private function tearDownScrollBar():void
		{
			if (scrollTarget && scrollTarget.content)
			{
				if (scrollTarget.content.hasEventListener(ApplicationEvent.CHILD_ADDED))
				{
					scrollTarget.content.removeEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler2);
					scrollTarget.content.removeEventListener(MouseEvent.MOUSE_UP, buttonEventHandler2);
					scrollTarget.content.removeEventListener(ApplicationEvent.CHILD_ADDED, contentEventHandler);
					scrollTarget.content.removeEventListener(ApplicationEvent.CHILD_REMOVED, contentEventHandler);
				}
			}
		}
		
		private function contentEventHandler(e:ApplicationEvent):void 
		{
			if (!_scrollTarget || !_scrollTarget.content)
			{
				Tracer.echo(name + ' : ScrollBar : contentEventHandler : scrollTarget/content null object!', this, 0xff0000);
				return;
			}
			
			updateTargetSpace();
			
			//if (e.type == ApplicationEvent.CHILD_REMOVED)
			//{
				//scrollBarThumb.y = 0/*upBtn.height*/;
				//
			//}
			//scrollingHandler(null, false);
			var xy:String = (_layoutType == Menu.LAYOUT_HORIZONTAL) ? 'x' : 'y';
			_scrollTarget.content[xy] = initPoint[xy];
		}
		
		private function updateTargetSpace():void
		{
			//added 08/03/2014
			if (!scrollTarget) return;
			
			var cWH:Number = contentWH;
			var mWH:Number = maskWH;
			var hasExtraSpace:Boolean = cWH > mWH;
			disableScrollBar(hasExtraSpace);
			
			if (hasExtraSpace)
			{
				
				_extraSpace = mWH - cWH;
				
				if (!scrollTarget.content.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					scrollTarget.content.addEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler2);
					scrollTarget.content.addEventListener(MouseEvent.MOUSE_UP, buttonEventHandler2);
				}
				
				//trace(name + ' : ScrollBar : updateTargetSpace : ', _extraSpace,  mWH, cWH, scrollBarThumb.height, sbt)
			}
			else
			{
				_extraSpace = 0;
				
				if (scrollTarget.content.hasEventListener(MouseEvent.MOUSE_DOWN))
				{
					scrollTarget.content.removeEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler2);
					scrollTarget.content.removeEventListener(MouseEvent.MOUSE_UP, buttonEventHandler2);
				}
			}
			
			
		}
		
		private function mouseWheelHandler(e:MouseEvent):void 
		{
			//if (e.delta > 0)
			//{
				//scrollBarThumb.y -= _scrollSpeed;
			//}
			//else
			//{
				//scrollBarThumb.y += _scrollSpeed;
			//}
			//
			//scrollingHandler(null, false);
		}
	}

}