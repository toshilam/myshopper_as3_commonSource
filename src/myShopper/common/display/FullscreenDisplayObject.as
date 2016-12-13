package myShopper.common.display 
{
	import caurina.transitions.Tweener;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import myShopper.common.display.button.Button;
	import myShopper.common.utils.TweenerEffect;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FullscreenDisplayObject extends Button 
	{
		private var _initPoint:Point;
		private var _marginTB:Point;
		private var _marginLR:Point;
		
		/**
		 * 
		 * @param	inInitPoint - -1 set to center, -2 do nothing
		 */
		public function FullscreenDisplayObject(inInitPoint:Point = null) 
		{
			super();
			_initPoint = inInitPoint ? inInitPoint : new Point ( -1, -1); //if no point = -1, set object to center
			_marginTB = new Point();
			_marginLR = new Point();
		}
		
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			//stopListener();
			_initPoint = null;
			_marginTB = null;
			_marginLR = null;
			
		}
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			onStageResize(inStage);
			
			Tweener.addTween(this, TweenerEffect.setGlow(1, 'easeOutSine', 0x000000, 10, 5, .5));
			
		}
		
		override public function startListener():void 
		{
			super.startListener();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		override public function stopListener():void 
		{
			super.stopListener();
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			onStageResize(_appStage);
		}
		
		public function setMargin(inTopBottom:Point, inLeftRight:Point = null):void
		{
			_marginTB = inTopBottom;
			if(inLeftRight) _marginLR = inLeftRight;
		}
		
		public function setInitPoint(inPoint:Point):void
		{
			_initPoint = inPoint;
		}
		
		
		private function enterFrameHandler(e:Event):void 
		{
			if (!stage) return;
			
			var marginT:Number = _marginTB ? _marginTB.x : 0;
			var marginB:Number = _marginTB ? _marginTB.y : 0;
			
			if (height > stage.stageHeight - _marginTB.x - _marginTB.y) 
			{
				//var adjectHeight:int = 40;
				
				var marginTB:Number = marginT + marginB;
				
				var targetMouseY:Number = stage.mouseY - marginB;
				var targetStageHeight:Number = stage.stageHeight - marginTB;
				var spareHeight:Number = height - targetStageHeight;
				var posPercentageH:Number = targetMouseY / targetStageHeight; 
				var targetY:Number = -(spareHeight) * posPercentageH /*- marginB*/;
				
				//var targetStageHeight:Number = stage.stageHeight;
				//var spareHeight:Number = height - targetStageHeight;
				//var posPercentageH:Number = stage.mouseY / targetStageHeight; 
				//var targetY:Number = -(spareHeight) * posPercentageH;
				y = marginT + targetY;
				
				
				trace(y);
			}
			else
			{
				if (_initPoint.y != -2) y = _initPoint.y != -1 ? _initPoint.y : stage.stageHeight - height >> 1;
			}
			
			if (width > stage.stageWidth - _marginLR.x - _marginLR.y) 
			{
				var targetStageWidth:Number = stage.stageWidth;
				var spareWidth:Number = width - targetStageWidth;
				var posPercentageW:Number = stage.mouseX / targetStageWidth; 
				var targetX:Number = -(spareWidth) * posPercentageW;
				x = targetX;
			}
			else
			{
				if (_initPoint.x != -2) x = _initPoint.x != -1 ? _initPoint.x : stage.stageWidth- width >> 1;
			}
		}
		
		override public function onStageResize(inAppStage:Stage):void 
		{
			super.onStageResize(inAppStage);
			
			if (_initPoint.x != -2) x = _initPoint.x != -1 ? _initPoint.x : inAppStage.stageWidth - width >> 1;
			if (_initPoint.y != -2) y = _initPoint.y != -1 ? _initPoint.y : inAppStage.stageHeight - height >> 1;
			
		}
	}

}