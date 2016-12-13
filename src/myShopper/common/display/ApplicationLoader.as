package myShopper.common.display
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.events.FileEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDataDisplayObject;
	import myShopper.common.interfaces.IDisplayObjectList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	import myShopper.common.utils.TweenerEffect;
	
	[Event(name = "Complete", type = "myShopper.common.events.FileEvent")] 
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationLoader extends Loader implements IApplicationDisplayObject, IDataDisplayObject
	{
		protected var _vo:IVO;
		//public function get dataVO():IVO { return _dataVO; }
		public function get vo():IVO 
		{
			return _vo;
		}
		
		
		
		protected var _isLoaded:Boolean;
		public function get isLoaded():Boolean 
		{
			return _isLoaded;
		}
		
		/*protected var _loader:Loader
		public function get loader():Loader 
		{
			return _loader;
		}*/
		
		public function ApplicationLoader(/*inVO:IVO = null*/) 
		{
			super();
			//_loader = new Loader();
			
		}
		
		
		override public function loadBytes(bytes:ByteArray, context:LoaderContext = null):void 
		{
			addListener()
			
			try
			{
				super.loadBytes(bytes, context);
			}
			catch (e:Error)
			{
				removeListener();
				Tracer.echo(name + ' : loadBytes : ' + e.message, this, 0xff0000);
			}
		}
		
		override public function load(request:URLRequest, context:LoaderContext = null):void 
		{
			addListener();
			
			try
			{
				super.load(request, context);
			}
			catch (e:Error)
			{
				removeListener();
				Tracer.echo(name + ' : load : ' + e.message, this, 0xff0000);
			}
			
		}
		
		private function addListener():void 
		{
			addEventListener(AsyncErrorEvent.ASYNC_ERROR, errorHandlerAsyncErrorEvent, false, 0, true);
			addEventListener(IOErrorEvent.IO_ERROR, errorHandlerIOErrorEvent, false, 0, true);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerSecurityErrorEvent, false, 0, true);
			contentLoaderInfo.addEventListener(Event.COMPLETE, loaderEventHandler, false, 0, true);
			//contentLoaderInfo.addEventListener(Event.INIT, initHandler, false, 0, true);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, infoIOErrorEvent, false, 0, true);
		}
		
		private function removeListener():void 
		{
			removeEventListener(AsyncErrorEvent.ASYNC_ERROR, errorHandlerAsyncErrorEvent);
			removeEventListener(IOErrorEvent.IO_ERROR, errorHandlerIOErrorEvent);
			removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerSecurityErrorEvent);
			contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderEventHandler);
			//contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, infoIOErrorEvent);
		}
		
		override public function unload():void 
		{
			_isLoaded = false;
			super.unload();
		}
		
		
		protected function loaderEventHandler(e:Event):void 
		{
			removeListener()
			_isLoaded = true;
			dispatchEvent(new FileEvent(FileEvent.COMPLETE, this, null, null, null, content));
		}
		
		public function setInfo(inData:IVO):Boolean 
		{
			_vo = inData;
			return updateInfo();
		}
		
		public function updateInfo():Boolean 
		{
			if (_vo)
			{
				return true;
			}
			return false;
		}
		
		private function infoIOErrorEvent(e:IOErrorEvent):void 
		{
			Tracer.echo('infoIOErrorEvent : ' + e.toString(), this, 0xff0000);
		}
		
		private function errorHandlerSecurityErrorEvent(e:SecurityErrorEvent):void 
		{
			Tracer.echo('errorHandlerSecurityErrorEvent : ' + e.toString(), this, 0xff0000);
		}
		
		private function errorHandlerIOErrorEvent(e:IOErrorEvent):void 
		{
			Tracer.echo('errorHandlerIOErrorEvent : ' + e.toString(), this, 0xff0000);
		}
		
		private function errorHandlerAsyncErrorEvent(e:AsyncErrorEvent):void 
		{
			Tracer.echo('errorHandlerAsyncErrorEvent : ' + e.toString(), this, 0xff0000);
		}
		
		
		
		/* INTERFACE myShopper.common.interfaces.IApplicationDisplayObject */
		protected var _id:String;
		public function get id():String { return _id; }
		public function set id(value:String):void { _id = value; }
		
		protected var _isClosed:Boolean;
		public function get isClosed():Boolean { return _isClosed; }
		
		protected var _XMLSetting:XML
		public function get XMLSetting():XML { return _XMLSetting; }
		
		protected var _subDisplayObjectList:DisplayObjectList
		public function get subDisplayObjectList():IDisplayObjectList { return _subDisplayObjectList; }
		
		public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			
		}
		
		public function destroyDisplayObject():void
		{
			removeListener();
			try
			{
				close();
				
			}
			catch (e:Error)
			{
				Tracer.echo("ApplicationLoader : destroyDisplayObject : " + e.message, this, 0xff0000);
			}
			
			unload();
			unloadAndStop();
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
		
		
		public function closePage(inObjTweenerEffect:Object = null):void 
		{
			
		}
		
		public function showPage(inObjTweenerEffect:Object = null):void 
		{
			
		}
		
	}

}