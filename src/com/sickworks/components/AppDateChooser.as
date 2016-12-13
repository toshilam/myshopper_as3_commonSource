package com.sickworks.components 
{
	import flash.events.Event;
	import flash.display.Stage;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDisplayObjectList;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class AppDateChooser extends DateChooser implements IApplicationDisplayObject 
	{
		
		public function AppDateChooser(allowMultipleSelection:Boolean=false, month:int=-1, year:int=-1) 
		{
			super(allowMultipleSelection, month, year);
			
		}
		
		public function get id():String 
		{
			return '';
		}
		
		public function set id(value:String):void 
		{
			
		}
		
		public function get XMLSetting():XML 
		{
			return null;
		}
		
		public function get subDisplayObjectList():IDisplayObjectList 
		{
			return null;
		}
		
		public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			
		}
		
		public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			return null;
		}
		
		public function addApplicationChildAt(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, inIndex:uint = 0, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			return null;
		}
		
		public function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = true):void 
		{
			
		}
		
		public function hasApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject):Boolean 
		{
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
		
		public function destroyDisplayObject ():void
		{
			
		}
		
	}

}