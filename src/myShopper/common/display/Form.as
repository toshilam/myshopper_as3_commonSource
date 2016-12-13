package myShopper.common.display 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.text.TextField;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDataDisplayObject;
	import myShopper.common.interfaces.IForm;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.ui.TabbingManager;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.TweenerEffect;
	import myShopper.fl.FormAlerter;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class Form extends ApplicationDisplayObject implements IDataDisplayObject, IForm
	{
		//protected var _vo:IVO;
		public function get vo():IVO { return null; }
		
		protected var _arrFormElement:Vector.<DisplayObject>;
		public function get arrFormElement():Vector.<DisplayObject> { return _arrFormElement; }
		
		//protected var _initW:Number = 0;
		//protected var _initH:Number = 0;
		//protected var _alert:FormAlerter;
		
		public function Form() 
		{
			super();
			_arrFormElement = new Vector.<DisplayObject>();
			//_initW = super.width;
			//_initH = super.height;
		}
		
		/*override public function get width():Number 
		{
			return _alert && super.width  > _initW ? super.width - _alert.x + () : super.width;
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		
		override public function get height():Number 
		{
			return _initH > 0 ? _initH : super.height;
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}*/
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			
			if (parent)
			{
				parent.removeEventListener(ApplicationEvent.SET_INDEX, indexEventHandler);
			}
		}
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			
			if (parent)
			{
				parent.addEventListener(ApplicationEvent.SET_INDEX, indexEventHandler, false, 0, true);
			}
		}
		
		private function indexEventHandler(e:ApplicationEvent):void 
		{
			TabbingManager.getInstance().setTabForm(this);
		}
		
		override public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			/*if (inApplicationDisplayObject is FormAlerter)
			{
				
			}*/
			return super.addApplicationChild(inApplicationDisplayObject, inSettingSource, autoShowPage);
		}
		
		public function isValid():*
		{
			//closeAlerter();
			
			return null;
		}
		
		public function clear():void
		{
			if (arrFormElement) 
			{
				var numItem:int = arrFormElement.length
				for (var i:int = 0; i < numItem; i++)
				{
					if (arrFormElement[i] is TextField)
					{
						TextField(arrFormElement[i]).text = "";
					}
				}
			}
		}
		
		/* INTERFACE myShopper.common.interfaces.IDataDisplayObject */
		
		
		
		public function setInfo(inData:IVO):Boolean 
		{
			return false;
		}
		
		public function updateInfo():Boolean 
		{
			return false;
		}
		
		override public function showPage(inObjTweenerEffect:Object = null):void 
		{
			this.alpha = 0;
			Tweener.addTween(this, TweenerEffect.setAlpha(1, .5, "easeOutQuad"));
			
			var targetScale:Number = 1;
			
			if (ApplicationDisplayObject.isMobile())
			{
				targetScale = Tools.getScalingFactorByDPI();
			}
			
			Tweener.addTween(this, TweenerEffect.setScale(targetScale * .7, 0));
			Tweener.addTween(this, TweenerEffect.setScale(targetScale, 1.5, "easeOutElastic", function():void { setIsClosed(false) }, function():void{ onStageResize(stage) } ));
		}
		
		override public function closePage(inObjTweenerEffect:Object = null):void 
		{
			Tweener.addTween(this, TweenerEffect.setAlphaWithDelay(0, .4, 1, "easeOutQuad"));
			
			var targetScale:Number = 1;
			
			if (ApplicationDisplayObject.isMobile())
			{
				targetScale = Tools.getScalingFactorByDPI();
			}
			
			Tweener.addTween(this, TweenerEffect.setScale(targetScale, 0));
			Tweener.addTween(this, TweenerEffect.setScale(targetScale * .7, 1.5, "easeInElastic", function():void { setIsClosed(true) }, function():void{ onStageResize(stage) } ));
			
		}
		
		override public function onStageResize(inAppStage:Stage):void 
		{
			if (!inAppStage) return;
			
			super.onStageResize(inAppStage);
			
			this.x = (inAppStage.stageWidth - this.width) / 2 ;
			this.y = (inAppStage.stageHeight - this.height) / 2 ;
			
		}
		
		/*protected function closeAlerter():void
		{
			//remove alerter
			for (var i:uint = 0; i < this._subDisplayObjectList.length; i++)
			{
				if (this._subDisplayObjectList.getDisplayObjectByIndex(i) is FormAlerter)
				{
					this.removeApplicationChild(this._subDisplayObjectList.getDisplayObjectByIndex(i));
				}
			}
		}*/
		
	}

}