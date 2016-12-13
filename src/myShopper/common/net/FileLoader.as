package myShopper.common.net 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import myShopper.common.emun.FileType;
	import myShopper.common.events.FileEvent;
	import myShopper.common.utils.Tracer;
	
	[Event(name = "Complete", type = "myShopper.common.events.FileEvent")]
	[Event(name="ioError", type="flash.events.IOErrorEvent")]
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FileLoader extends EventDispatcher implements IEventDispatcher 
	{
		private var loader:Loader;
		private var urlloader:URLLoader;
		
		private var currentURL:String;
		private var currentFileType:String;
		private var currentFileID:String;
		
		public var useContext:Boolean;
		
		public function FileLoader() 
		{
			useContext = true;
		}
		
		public function load(inURL:String, inFileType:String, inID:String):Boolean
		{
			if (inFileType != FileType.TYPE_SWF && inFileType != FileType.TYPE_XML && inFileType != FileType.TYPE_BYTE)
			{
				Tracer.echo('FileLoader : load : unknown file type : ' + inFileType, this, 0xff0000);
				return false;
			}
			
			getFunctionByFileType(inFileType)(inURL, inID);
			return true;
		}
		
		private function getFunctionByFileType(inFileType:String):Function
		{
			return inFileType == FileType.TYPE_SWF ? loadSWF : inFileType == FileType.TYPE_XML ? loadXML : loadByte;
		}
		
		private function loadByte(inURL:String, inID:String):void
		{
			currentURL = inURL;
			currentFileType = FileType.TYPE_BYTE;
			currentFileID = inID;
			urlloader = new URLLoader();
			urlloader.dataFormat = URLLoaderDataFormat.BINARY;
			urlloader.addEventListener(Event.COMPLETE, loaderEventHandler);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorEventHandler);
			
			try
			{
				urlloader.load(new URLRequest(inURL));
			}
			catch (e:Error)
			{
				Tracer.echo('FileLoader : loadXML : error loading file : ' + currentURL /*+ ', error id : ' + e..errorID*/, this, 0xff0000);
			}
		}
		
		private function loadXML(inURL:String, inID:String):void
		{
			currentURL = inURL;
			currentFileType = FileType.TYPE_XML;
			currentFileID = inID;
			urlloader = new URLLoader();
			urlloader.addEventListener(Event.COMPLETE, loaderEventHandler);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorEventHandler);
			
			try
			{
				urlloader.load(new URLRequest(inURL));
			}
			catch (e:Error)
			{
				Tracer.echo('FileLoader : loadXML : error loading file : ' + currentURL /*+ ', error id : ' + e..errorID*/, this, 0xff0000);
			}
		}
		
		private function loadSWF(inURL:String, inID:String):void
		{
			currentURL = inURL;
			currentFileType = FileType.TYPE_SWF;
			currentFileID = inID;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderEventHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorEventHandler);
			
			try
			{
				loader.load(new URLRequest(inURL), useContext ? new LoaderContext(false, ApplicationDomain.currentDomain) : null);
			}
			catch (e:Error)
			{
				Tracer.echo('FileLoader : loadSWF : error loading file : ' + currentURL /*+ ', error id : ' + e..errorID*/, this, 0xff0000);
			}
			
		}
		
		private function loaderErrorEventHandler(e:IOErrorEvent):void 
		{
			Tracer.echo('FileLoader : loaderErrorEventHandler : error loading file : ' + currentURL /*+ ', error id : ' + e..errorID*/, this, 0xff0000);
			dispatchEvent(e.clone());
		}
		
		private function loaderEventHandler(e:Event):void 
		{
			var targetLoader:Object = currentFileType == FileType.TYPE_XML || currentFileType == FileType.TYPE_BYTE ? urlloader : loader;
			var targetData:Object = targetLoader is URLLoader ? urlloader.data : loader.content;
			dispatchEvent
			(
				new FileEvent
				(
					FileEvent.COMPLETE, 
					targetLoader, 
					currentURL, 
					currentFileType,
					currentFileID,
					targetData
				)
			);
		}
	}

}