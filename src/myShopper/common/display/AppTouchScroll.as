package myShopper.common.display 
{
	import com.doitflash.consts.Easing;
	import com.doitflash.consts.Orientation;
	import com.doitflash.consts.ScrollConst;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import com.doitflash.utils.scroll.TouchScroll;
	import flash.display.Stage;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDisplayObjectList;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class AppTouchScroll extends TouchScroll implements IApplicationDisplayObject 
	{
		private var _scroller:TouchScroll;
		
		public function AppTouchScroll(inData:DisplayObject = null) 
		{
			super();
			//_scroller =  addChild(new TouchScroll());
			//------------------------------------------------------------------------------ set Scroller
			
			enableVirtualBg = true;
			mouseWheelSpeed = 5;
			orientation = Orientation.VERTICAL; // accepted values: Orientation.AUTO, Orientation.VERTICAL, Orientation.HORIZONTAL
			easeType = Easing.Expo_easeOut;// Easing.Strong_easeOut;
			scrollSpace = 0;
			aniInterval = .5;
			blurEffect = false;
			lessBlurSpeed = 3;
			yPerc = 0; // min value is 0, max value is 100
			xPerc = 0; // min value is 0, max value is 100
			mouseWheelSpeed = 2;
			isMouseScroll = false;
			isTouchScroll = true;
			bitmapMode = ScrollConst.NORMAL; // use it for smoother scrolling, special when working on mobile devices, accepted values: "normal", "weak", "strong"
			isStickTouch = false;
			holdArea = 30;
			
			if(inData) maskContent = inData;
		}
		
		public function set scrollTarget(inData:DisplayObject):void
		{
			maskContent = inData;
		}
		
		/* INTERFACE myShopper.common.interfaces.IApplicationDisplayObject */
		
		
		protected var _XMLSetting:XML;
		public function get XMLSetting():XML 
		{
			return _XMLSetting;
		}
		
		public function get subDisplayObjectList():IDisplayObjectList 
		{
			return null;
		}
		
		public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			
			
		}
		
		public function destroyDisplayObject():void
		{
			
		}
		
		
		public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			Tracer.echo('AppTouchScroll : addApplicationChild : disable function!');
			return null;
		}
		
		public function addApplicationChildAt(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, inIndex:uint = 0, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			Tracer.echo('AppTouchScroll : addApplicationChildAt : disable function!');
			return null;
		}
		
		public function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = true):void 
		{
			Tracer.echo('AppTouchScroll : removeApplicationChild : disable function!');
		}
		
		public function hasApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject):Boolean 
		{
			Tracer.echo('AppTouchScroll : hasApplicationChild : disable function!');
			return false;
		}
		
		public function onStageResize(inApp:Stage):void 
		{
			
		}
		
		public function get isClosed():Boolean 
		{
			return false;
		}
		
		public function closePage(inObjTweenerEffect:Object = null):void 
		{
			
		}
		
		public function showPage(inObjTweenerEffect:Object = null):void 
		{
			
		}
		
		/*public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return false
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return false
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return false;
		}*/
		
	}

}