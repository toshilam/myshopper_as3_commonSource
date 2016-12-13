package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.interfaces.IButton;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class PageEvent extends ApplicationEvent 
	{
		public static const URL_CHANGED:String = 'urlChanged';
		public static const URL_ADDED:String 	= 'urlAdded';
		public static const URL_REMOVED:String = 'urlRemoved';
		public static const URL_NOT_VALIDATE:String = 'urlNotValidate';
		
		public var pageID:String; //the page id which just change
		public var URL:String; //the whole url path
		public var pages:Array; // the whole url path in an Array
		
		public function PageEvent(type:String, inPageID:String, inURL:String, inPages:Array = null, inData:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, null, inData, bubbles, cancelable);
			
			pageID = inPageID;
			URL = inURL;
			pages = inPages;
		} 
		
		public override function clone():Event 
		{ 
			return new PageEvent(type, pageID, URL, pages, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}