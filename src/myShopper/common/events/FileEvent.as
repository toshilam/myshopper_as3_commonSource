package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * if const changed may have to re-complie appMain.swf, as FileEvent is cashed in (only const affected?)
	 * @author Toshi Lam
	 */
	public class FileEvent extends ApplicationEvent 
	{
		public static const NAME:String = 'FileEvent';
		public static const COMPLETE:String = 'Complete';
		public static const COMPLETE_ALL_FILE:String = 'CompleteAllFile';
		public static const UPLOAD:String = 'upload';
		public static const DOWNLOAD:String = 'download';
		public static const SIZE_OVER:String = 'sizeOver';
		public static const NUM_FILE_OVER:String = 'numFileOver';
		public static const IO_ERROR:String = 'ioError';
		
		public var fileURL:String;
		public var fileType:String;
		public var fileID:String;
		public var loader:Object;
		
		public function FileEvent(type:String, inLoader:Object = null, inURL:String = null, inFileType:String = null, inFileID:String = null, inData:Object = null) 
		{
			super(type, null, null, false, false);
			loader = inLoader;
			fileURL = inURL;
			fileType = inFileType;
			fileID = inFileID;
			_data = inData;
		}
		
		public override function clone():Event 
		{ 
			return new FileEvent(type, loader, fileURL, fileType, fileID, _data);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FileEvent", "loader", "url", "fileType", "type", "id", "bubbles", "cancelable", "eventPhase"); 
		}
	}

}