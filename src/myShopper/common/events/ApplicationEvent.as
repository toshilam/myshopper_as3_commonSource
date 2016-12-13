package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationEvent extends Event 
	{
		private static const NAME:String = 'ApplicationEvent';
		
		public static const STARTUP:String = NAME + 'startup';
		public static const LANGUAGE:String = NAME + 'language';
		
		//public static const FILE_LOADED:String = NAME + 'filesLoaded';
		//public static const FILE_LOADED_COMPLETE:String = NAME + 'filesLoaded';
		//public static const FILE_UPLOAD:String = NAME + 'filesUpload';
		//public static const FILE_DOWNLOAD:String = NAME + 'filesDownload';
		//public static const FILE_READY:String = NAME + 'filesReady';
		//public static const FILE_SIZE_OVER:String = NAME + 'fileSizeOver';
		
		public static const CONTENT_CHANGED:String = NAME + 'contentChanged';
		public static const CONTENT_CHANGING:String = NAME + 'contentChanging';
		
		//public static const ERROR_IO:String = NAME + 'errorIO';
		
		public static const INIT_ASSET:String = NAME + 'initAsset';
		public static const INIT_ASSET_COMPLETE:String = NAME + 'initAssetComplete';
		
		//public static const INIT_GOOGLE_MAP:String = NAME + 'initGoogleMap';
		
		//public static const BUTTON_CLICK:String = NAME + 'buttonClick';
		//public static const BUTTONS_REMOVED:String = NAME + 'buttonsRemoved';
		
		public static const PAGE_CLOSED:String = NAME + 'pageClosed';
		public static const PAGE_SHOW:String = NAME + 'pageShow';
		
		//to change the display object to another display object
		//public static const DISPLAY_OBJECT_CHANGE_TO:String = NAME + 'displayObjectChangeTo';
		//to change the current page (SWF address) to another one
		//public static const PAGE_CHANGE_TO:String = NAME + 'pageChangeTo';
		//to save the page id, to be used later
		//public static const PAGE_SUBSCRIBE:String = NAME + 'pageSubscribe';
		
		//public static const PAGE_MOVE:String = NAME + 'pageMove';
		//public static const STAGE_RESIZE:String = NAME + 'stageResize';
		
		public static const CANCEL:String = NAME + 'cancel';
		public static const CLOSE:String = NAME + 'close';
		public static const SET_INDEX:String = NAME + 'setIndex';
		
		public static const CHILD_ADDED:String = NAME + 'ChildAdded';
		public static const CHILD_REMOVED:String = NAME + 'Childremoved';
		
		public static const DELETE:String = NAME + 'Delete';
		public static const MODIFY:String = NAME + 'Modify';
		public static const CLONE:String = NAME + 'Clone';
		public static const SHARE:String = NAME + 'Share'; //fb share
		public static const MORE:String = NAME + 'More';
		
		public static const PRINT:String = NAME + 'print';
		
		public static const WORKER_RESULT:String = NAME + 'WorkerResult';
		
		
		protected var _targetDisplayObject:DisplayObject;
		public function get targetDisplayObject():DisplayObject { return _targetDisplayObject; }
		
		protected var _data:Object;
		public function get data():Object { return _data; }
		
		public function ApplicationEvent(type:String, inTargetDisplayObject:DisplayObject = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{ 
			_targetDisplayObject = inTargetDisplayObject;
			_data = inData;
			
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ApplicationEvent", "type", "bubbles", "cancelable", "eventPhase", "targetDisplayObject", "data"); 
		}
		
		
		
	}
	
}