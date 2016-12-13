package myShopper.common.worker 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.MessageChannel;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import myShopper.common.data.worker.ImageWorkerVO;
	import myShopper.common.data.worker.WorkerVO;
	import myShopper.common.emun.WorkerType;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class MediaWorker extends Object
	{
		protected static var _dispatcher:EventDispatcher = new EventDispatcher();
		private static var _queue:Array = new Array();
		
		private static var _numRequested:int;
		private static var _worker:Worker;
		private static var _bm:MessageChannel;
		private static var _mb:MessageChannel;
		
		public static function get isSupported():Boolean
		{
			return WorkerDomain.isSupported;
		}
		
		public function MediaWorker() 
		{
			if (WorkerDomain.isSupported)
			{
				//Disabled on 15/04/2014 as fail packaging IPA, because of Embed tag
				/*try 
				{
					_worker = WorkerDomain.current.createWorker(Workers.MediaWorker);
					_bm = _worker.createMessageChannel(Worker.current);
					_mb = Worker.current.createMessageChannel(_worker);
					
					_worker.setSharedProperty(WorkerType.MEDIA_WORKER_TO_MAIN, _bm);
					_worker.setSharedProperty(WorkerType.MAIN_TO_MEDIA_WORKER, _mb);
					
					_bm.addEventListener(Event.CHANNEL_MESSAGE, onBackToMain);
					
					_worker.start();
				}
				catch (e:Error)
				{
					Tracer.echo('MediaWorker : unable to create worker');
				}*/
			}
			else
			{
				Tracer.echo('MediaWorker : worker is not supported!');
			}
		}
		
		
		
		protected static function getUniqueID():String
		{
			return String(_numRequested++).toString();
		}
		
		/**
		 * encode image by worker
		 * @param	inImageWorkerVO - source vo, result will be autometically set if fileImageVO is set
		 * @return an unique ID will be returned, which assicated with the result inside ApplicationEvent.WORKER_RESULT
		 */
		public static function encodeImage(inImageWorkerVO:ImageWorkerVO):String
		{
			/*if (_mb && _bm)
			{
				var uniqueID:String = getUniqueID();
				var vo:ImageWorkerVO = inImageWorkerVO;
				var workerVO:WorkerVO = new WorkerVO(uniqueID);
				workerVO.requestData = vo;
				workerVO.type = WorkerType.TYPE_IMAGE_ENCODE;
				
				_queue.push( workerVO );
				_mb.send(workerVO);
				
				return uniqueID;
			}*/
			
			Tracer.echo('MediaWorker : encodeImage : no worker channel found!');
			return null;
		}
		
		private static function onBackToMain(event:Event):void
		{
			if(_bm.messageAvailable)
			{
				var workerVO:WorkerVO = _bm.receive();
				
				if (workerVO)
				{
					for (var i:int = 0; i < _queue.length; i++)
					{
						var currWorkerVO:WorkerVO = _queue[i];
						if (currWorkerVO && currWorkerVO.id == workerVO.id)
						{
							_queue.splice(i, 1);
							
							var imageWorkerVO:ImageWorkerVO = currWorkerVO.requestData as ImageWorkerVO;
							var imageByte:ByteArray = workerVO.responseData as ByteArray;
							
							if (imageWorkerVO && imageWorkerVO.fileVO && imageByte)
							{
								imageWorkerVO.fileVO.data = imageByte;
							}
							
							if (imageWorkerVO.responder)
							{
								imageWorkerVO.responder.result(currWorkerVO);
							}
							
							
							dispatchEvent(new ApplicationEvent(ApplicationEvent.WORKER_RESULT, null, workerVO));
							break;
						}
					}
				}
				else
				{
					throw new Error('MediaWorker : onBackToMain : unknown data object : ' + workerVO);
				}
			}
		}
		
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public static function dispatchEvent(event:Event):Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		
		public static function hasEventListener(type:String):Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean
		{
			return _dispatcher.willTrigger(type);
		}
	}

}