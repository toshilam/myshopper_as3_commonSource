package myShopper.common.display 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.worker.ImageWorkerVO;
	import myShopper.common.data.worker.WorkerVO;
	import myShopper.common.events.FileEvent;
	import myShopper.common.events.VOEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDataDisplayObject;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	import myShopper.common.worker.MediaWorker;
	
	[Event(name = "Complete", type = "myShopper.common.events.FileEvent")]
	[Event(name = "ioError", type = "myShopper.common.events.FileEvent")]
	/**
	 * 
	 * @author Toshi Lam
	 */
	public class Image extends MaskedDisplayObject implements IDataDisplayObject, IResponder
	{
		protected var _loader:ApplicationLoader
		
		protected var _vo:FileImageVO;
		public function get vo():IVO 
		{
			return _vo;
		}
		
		protected var _autoSize:Boolean;
		public function get autoSize():Boolean {return _autoSize;}
		public function set autoSize(value:Boolean):void 
		{
			_autoSize = value;
			resizeImage();
		}
		
		private var _soomthing:Boolean;
		public function get soomthing():Boolean {return _soomthing;}
		public function set soomthing(value:Boolean):void 
		{
			_soomthing = value;
			
			if (_soomthing && _loader && _loader.isLoaded && _loader.content is Bitmap)
			{
				Bitmap(_loader.content).smoothing = true;
			}
		}
		
		public function get isLoaded():Boolean
		{
			return _loader && _loader.isLoaded;
		}
		
		override public function get width():Number 
		{
			return mask && mask.width && _loader.isLoaded ? _loader.content.width < mask.width ? _loader.content.width : mask.width : super.width;
		}
		
		override public function set width(inValue:Number):void
		{
			if (mask && mask.width && _loader.isLoaded)
			{
				_loader.content.width = inValue; 
			}
			else
			{
				super.width = inValue;
			}
		}
		
		override public function get height():Number 
		{
			return mask && mask.height && _loader.isLoaded ? _loader.content.height < mask.height ? _loader.content.height : mask.height : super.height;
		}
		
		override public function set height(inValue:Number):void
		{
			if (mask && mask.height && _loader.isLoaded)
			{
				_loader.content.height = inValue; 
			}
			else
			{
				super.height = inValue;
			}
		}
		
		
		
		public function Image() 
		{
			super();
			_loader = super.addApplicationChild(new ApplicationLoader(), null, false) as ApplicationLoader;
			autoSize = false;
			soomthing = true;
		}
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			if (_vo)
			{
				_vo.removeEventListener(VOEvent.VALUE_CHANGED, voEventHandler);
				_vo = null;
			}
			removeLoaderListener(_loader);
			_loader = null;
			
		}
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
		}
		
		override public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			Tracer.echo(name + ' : addApplicationChild : disabled function, please use holder object to add object', this, 0xff0000);
			return null;
		}
		
		override public function addApplicationChildAt(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, inIndex:uint = 0, autoShowPage:Boolean = true):IApplicationDisplayObject 
		{
			Tracer.echo(name + ' : addApplicationChild : disabled function, please use holder object to add object', this, 0xff0000);
			return null;
		}
		
		override public function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = true):void 
		{
			super.removeApplicationChild(inApplicationDisplayObject, autoClosePage);
			//Tracer.echo(name + ' : addApplicationChild : disabled function, please use holder object to remove object', this, 0xff0000);
		}
		
		//NOTE : after a mask is set, no more event to be dispatched
		override public function setMask(inX:Number, inY:Number, inWidth:Number, inHeight:Number):void 
		{
			super.setMask(inX, inY, inWidth, inHeight);
			resizeImage();
		}
		
		public function setInfo(inData:IVO):Boolean 
		{
			if (inData is FileImageVO)
			{
				if (_vo)
				{
					_vo.removeEventListener(VOEvent.VALUE_CHANGED, voEventHandler);
					_vo = null;
				}
				
				_vo = inData as FileImageVO;
				_vo.addEventListener(VOEvent.VALUE_CHANGED, voEventHandler);
				return updateInfo();
			}
			
			return false;
		}
		
		private function voEventHandler(e:VOEvent):void 
		{
			if (_vo && e.propertyName == 'data' && _vo.data)
			{
				updateInfo();
			}
		}
		
		public function updateInfo():Boolean 
		{
			if (_vo)
			{
				if (_loader && _vo.data && _vo.data.bytesAvailable)
				{
					_loader.unload();
					addLoaderListener(_loader);
					_loader.loadBytes(_vo.data);
				}
				
				return true;
			}
			
			return false;
		}
		
		public function unload():void
		{
			if (_loader) _loader.unload();
		}
		
		public function load(inURL:String):void
		{
			if (inURL.indexOf('http://') == -1 && inURL.indexOf('https://') == -1) return;
			
			addLoaderListener(_loader);
			
			try
			{
				_loader.unload();
				var req:URLRequest = new URLRequest(inURL);
				_loader.load(req/*, new LoaderContext(false, ApplicationDomain.currentDomain)*/);
			}
			catch (err:Error)
			{
				removeLoaderListener(_loader);
				Tracer.echo(name + ' : error : ' + err.message + ' : loading photo : ' + inURL, this, 0xff0000);
				dispatchEvent(new FileEvent(FileEvent.IO_ERROR, this));
			}
		}
		
		
		protected function addLoaderListener(inLoader:ApplicationLoader):void
		{
			if (inLoader)
			{
				inLoader.addEventListener(FileEvent.COMPLETE, loaderEventHandler, false, 0, true);
				inLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioEventHandler, false, 0, true);
				//inLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
			}
			
		}
		
		protected function removeLoaderListener(inLoader:ApplicationLoader):void
		{
			if (inLoader)
			{
				inLoader.removeEventListener(FileEvent.COMPLETE, loaderEventHandler);
				inLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioEventHandler);
				//inLoader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			}
			
		}
		
		protected function ioEventHandler(e:IOErrorEvent):void 
		{
			removeLoaderListener(_loader);
			Tracer.echo(name + ': ioEventHandler : error : loading photo : ' /*+ e.errorID*/, this, 0xff0000);
			dispatchEvent(new FileEvent(FileEvent.IO_ERROR, this));
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void 
		{
			removeLoaderListener(_loader);
			Tracer.echo(name + ': httpStatusHandler : error : loading photo : ' /*+ e.errorID*/, this, 0xff0000);
		}
		
		private function loaderEventHandler(e:FileEvent):void 
		{
			removeLoaderListener(_loader);
			
			soomthing = soomthing;
			
			//DISABLED on 06/04/2014 as worker is not working correctly
			//if (_vo && !_vo.data)
			//{
				//var content:DisplayObject = _loader.content;
				//
				//if (MediaWorker.isSupported)
				//{
					//MediaWorker.encodeImage(new ImageWorkerVO('', content, content.width, content.height, 100, _vo, this));
				//}
				//else
				//{
					//_vo.data = Tools.getByteByDisplayObject(content , content.width, content.height);
				//}
				//
			//}
			//else
			//{
				resizeImage();
				dispatchEvent(new FileEvent(e.type, this));
			//}
			
			
		}
		
		/**
		 * calling back from MeidaWorker 
		 * @param	data - workerVO that containe image btyearray
		 */
		public function result(data:Object):void 
		{
			Tracer.echo('Image : result : calling from worker!');
			
			var workerVO:WorkerVO = data as WorkerVO;
			if (workerVO && workerVO.responseData is ByteArray)
			{
				_vo.data = workerVO.responseData as ByteArray;
			}
		}
		
		/**
		 * NOT USED
		 * @param	info
		 */
		public function fault(info:Object):void 
		{
			
		}
		
		
		protected function resizeImage():void
		{
			if (autoSize && _loader)
			{
				if (mask && _loader.isLoaded)
				{
					if (_loader.content.width > mask.width)
					{
						_loader.content.width = mask.width;
						_loader.content.scaleY = _loader.content.scaleX;
					}
					
					/*if ( _loader.content.height > _mask.height)
					{
						_loader.content.height = _mask.height;
						_loader.content.scaleX = _loader.content.scaleY;
					}*/
					
				}
			}
		}
	}

}