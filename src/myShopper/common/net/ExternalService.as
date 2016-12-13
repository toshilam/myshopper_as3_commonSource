package myShopper.common.net 
{
	
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.ICommServiceRequest;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IService;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.utils.Tracer;
	
	[Event(name="response", type="myShopper.common.events.ServiceEvent")] 
	/**
	 * service for helping each module do the communication
	 * @author Toshi Lam
	 */
	public class ExternalService extends EventDispatcher implements IService
	{
		public static const REQUEST:String = 'request';
		//public static const ADD_COMMUNICATOR:String = 'addCommunicator'; 				//add communicator to the subscriber list, subscriber will be notified once a notfication is received
		//public static const REMOVE_COMMUNICATOR:String = 'removeCommunicator'; 			//remove communicator from list
		//public static const GET_COMMUNICATOR:String = 'getCommunicator'; 				//to get target communicator
		//public static const NOTIFICATION:String = 'communicationServiceNotification'; 	//send notification to all communicator
		
		
		//protected var _responderMap:Object;
		
		private static var instance:ExternalService;
		public function ExternalService(inPvtClass:PrivateClass) 
		{
			//_responderMap = new Object();
			//to be called by javascript
			
			if (ExternalInterface.available)
			{
				//paypal and wheel event for firefox and chrome
				ExternalInterface.addCallback(REQUEST, response);

			}
			
		}
		
		
		
		public static function getInstance():ExternalService
		{
			if (ExternalService.instance == null) 
			{
				ExternalService.instance = new ExternalService(new PrivateClass());
			}
			
			return ExternalService.instance;
		}
		
		public function get available():Boolean
		{
			return ExternalInterface.available;
		}
		
		//to be called javascript
		private function response(inData:Object):void 
		{
			Tracer.echo('ExternalService : a request receive from external : ' + inData, this, 0xFF0000);
			
			if (!inData || !inData.request)
			{
				Tracer.echo('ExternalService : unknown data object : ' + inData, this, 0xFF0000);
				return;
			}
			
			dispatchEvent(new ServiceEvent(ServiceEvent.RESPONSE, new ServiceResponse(new ServiceRequest(inData.request.type, inData.request.data), inData.data)));
		}
		
		public function request(inRequest:IServiceRequest):Boolean
		{
			if (!(inRequest is IServiceRequest))
			{
				Tracer.echo('ExternalService : unknown data type : ' + inRequest, this, 0xFF0000);
				return false;
			}
			
			if (!ExternalInterface.available)
			{
				Tracer.echo('setRemoteData : unable to start paypal flow as no ExternalInterface available!');
				dispatchEvent(new ServiceEvent(ServiceEvent.FAULT));
				
				return false;
			}
			
			//call javascript
			ExternalInterface.call(REQUEST, inRequest);
			/*
			
			var request:IServiceRequest = inRequest as IServiceRequest;
			
			switch(request.type)
			{
				case ADD_COMMUNICATOR:
				{
					_responderMap[request.communicatorID] = inRequest;
					
					Tracer.echo('CommunicationService : newly added a new communicator : ' + request.communicatorID, this, 0xFF0000);
					
					
					break;
				}
				case REMOVE_COMMUNICATOR:
				{
					if (_responderMap[request.communicatorID])
					{
						delete _responderMap[request.communicatorID]
						Tracer.echo('CommunicationService : removed a communicator : ' + request.communicatorID, this, 0xFF0000);
					}
					else
					{
						Tracer.echo('CommunicationService : no communicator found : ' + REMOVE_COMMUNICATOR + ' : ' + request.communicatorID, this, 0xFF0000);
						return false;
					}
					break;
				}
				case NOTIFICATION:
				{
					notificationHandler(request);
					break;
				}
				default:
				{
					Tracer.echo('CommunicationService : request : unknown service type ' + inRequest.type, this, 0xFF0000);
				}
			}*/
			
			return true;
		}
		
		/*private function notificationHandler(inRequest:ICommServiceRequest):void 
		{
			var requesterID:String = inRequest.communicatorID;
			
			for (var i:String in _responderMap)
			{
				var target:ICommServiceRequest = _responderMap[i];
				if (target) 
				{
					if (target.communicatorID == requesterID) continue; //no need to call back to request maker
					
					if (target.requester.result is Function)
					{
						Tracer.echo('CommunicationService : notificationHandler : sending request to ' + target.communicatorID, this, 0xFF0000);
						target.requester.result(inRequest);
					}
					else
					{
						Tracer.echo('CommunicationService : notificationHandler : target object has no response function avaliable :  ' + target.communicatorID, this, 0xFF0000);
					}
				}
				else
				{
					Tracer.echo('CommunicationService : notificationHandler : unable to get target object ' + _responderMap[i], this, 0xFF0000);
				}
			}
		}*/
		
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}