package myShopper.common.net 
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import myShopper.common.emun.RequestType;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.IService;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.utils.Tracer;
	
	//this event will be dispatched by userMgt module, once all fb friend data received
	//[Event(name = "receivedFdData", type = "myShopper.common.events.FacebookEvent")] 
	//
	//[Event(name="response", type="myShopper.common.events.ServiceEvent")] 
	//[Event(name="fault", type="myShopper.common.events.ServiceEvent")] 
	//[Event(name="connectFail", type="myShopper.common.events.ServiceEvent")] 
	//[Event(name="connectSuccess", type="myShopper.common.events.ServiceEvent")] 
	//[Event(name="disconnected", type="myShopper.common.events.ServiceEvent")] 
	/**
	 * 
	 * @author Toshi Lam
	 */
	public class LocalDataService extends EventDispatcher implements IService
	{
		public static const STORAGE:int = 1024 * 500; //500kb
		public static const ORDER:String = 'order';
		public static const SETTING:String = 'setting';
		
		private static var instance:LocalDataService;
		
		protected var _key:String;
		protected var _so:SharedObject;
		
		public function LocalDataService(inPvtClass:PrivateClass/*, inKey:String*/) 
		{
			super();
			
			
		}
		
		public static function getInstance(/*inKey:String*/):LocalDataService
		{
			if (LocalDataService.instance == null) 
			{
				LocalDataService.instance = new LocalDataService(new PrivateClass()/*, inKey*/);
			}
			
			return LocalDataService.instance;
		}
		
		public function init(inKey:String):Boolean
		{
			//inKey = shopNo SP-XXXXXX
			_key = inKey;
			
			try
			{
				_so = SharedObject.getLocal(inKey, '/');
				
				if (_so)
				{
					if (!_so.data[LocalDataService.ORDER]) _so.data[LocalDataService.ORDER] = {};
					if (!_so.data[LocalDataService.SETTING]) _so.data[LocalDataService.SETTING] = {};
				}
				
			}
			catch(e:Error)
			{
				dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL));
				Tracer.echo('LocalDataService : unable to retreve so!');
				
				return false;
			}
			
			return true;
		}
		
		public function request(inRequest:IServiceRequest):Boolean
		{
			if (!(inRequest is LocalDataServiceRequest))
			{
				Tracer.echo('LocalDataService : unknown data type : ' + inRequest, this, 0xFF0000);
				return false;
			}
			
			if (!isAvailable())
			{
				Tracer.echo('LocalDataService : request : not connected/no ExternalInterface available!');
				dispatchEvent(new ServiceEvent(ServiceEvent.FAULT));
				
				return false;
			}
			
			var request:LocalDataServiceRequest = inRequest as LocalDataServiceRequest;
			
			/*if (!(request.requester is IServiceResponse) || !request.data || !request.key)
			{
				Tracer.echo('LocalDataService : request : no requester found!');
				return false;
			}*/
			
			
			
			switch(request.type)
			{
				case RequestType.LOCAL_DATA_SAVE_ORDER:
				{
					if (!request.data || !request.key)
					{
						Tracer.echo("LocalDataService : request : Could not write SharedObject to disk!");
						return false;
					}
					
					_so.data[LocalDataService.ORDER][request.key] = request.data;
					
					var flushStatus:String = null;
					try 
					{
						flushStatus = _so.flush(/*STORAGE*/);
					} 
					catch (error:Error) 
					{
						Tracer.echo("LocalDataService : request : Could not write SharedObject to disk!");
						return false;
					}
					
					if (flushStatus == SharedObjectFlushStatus.PENDING)
					{
						Tracer.echo("LocalDataService : request : Requesting permission to save object!");
						_so.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
						return false;
					}
					else if (flushStatus == SharedObjectFlushStatus.FLUSHED)
					{
						return true;
					}
					
					break;
				}
				case RequestType.LOCAL_DATA_REMOVE_ORDER:
				{
					delete _so.data[LocalDataService.ORDER][request.key];
					return true;
					break;
				}
				case RequestType.LOCAL_DATA_GET_ORDER_BY_NO:
				{
					var tempOrder:Object = _so.data[LocalDataService.ORDER][request.key]
					request.requester.result(new ServiceResponse(request, tempOrder));
					return !!tempOrder;
					break;
				}
				case RequestType.LOCAL_DATA_GET_ORDERS:
				{
					request.requester.result(new ServiceResponse(request, _so.data[LocalDataService.ORDER]));
					return true;
					break;
				}
				case RequestType.LOCAL_DATA_LANGUAGE:
				case RequestType.LOCAL_DATA_USER_INFO:
				{
					if (request.data)
					{
						_so.data[LocalDataService.SETTING][request.type] = request.data;
					}
					else
					{
						request.requester.result(new ServiceResponse(request, _so.data[LocalDataService.SETTING][request.type]));
					}
					
					return true;
					break;
				}
				default:
				{
					Tracer.echo('LocalDataService : request : no matched request type found!');
				}
			}
			
			
			return true;
		}
		
		private function onFlushStatus(e:NetStatusEvent):void 
		{
			//TODO
		}
		
		public function isAvailable():Boolean 
		{
			/*CONFIG::desktop
			{
				return true;
			}*/
			
			return !!_so;
		}
		
		
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}