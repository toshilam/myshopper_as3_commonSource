package myShopper.common.net 
{
	
	import com.facebook.graph.data.FacebookAuthResponse;
	import com.facebook.graph.data.FacebookSession;
	import com.facebook.graph.Facebook;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.NetConnection;
	import flash.utils.setTimeout;
	import myShopper.common.emun.FacebookServicesType;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.ICommServiceRequest;
	import myShopper.common.interfaces.IFacebookResponder;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.IService;
	import myShopper.common.interfaces.IServiceConnection;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.interfaces.IServiceResponse;
	import myShopper.common.utils.Tracer;
	
	//this event will be dispatched by userMgt module, once all fb friend data received
	[Event(name = "receivedFdData", type = "myShopper.common.events.FacebookEvent")] 
	
	[Event(name="response", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="fault", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="connectFail", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="connectSuccess", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="disconnected", type="myShopper.common.events.ServiceEvent")] 
	/**
	 * 
	 * @author Toshi Lam
	 */
	public class FacebookService extends EventDispatcher implements IService
	{
		
		public static const TYPE_SHARE:String = ''
		
		protected var _appID:String;
		protected var _fbSession:FacebookAuthResponse;
		protected var _permissions:Array;
		protected var _connected:Boolean;
		protected var _isBusy:Boolean;
		protected var _hasAllPermission:Boolean;
		
		protected var _uid:String;
		public function get uid():String
		{
			return _uid;
		}
		
		protected var _allowedPermission:Array;
		//protected var _responderMap:Object;
		
		private static var instance:FacebookService;
		public function FacebookService(inPvtClass:PrivateClass, inAppID:String, inPermission:Array) 
		{
			super();
			_allowedPermission = new Array();
			_hasAllPermission = false;
			
			_permissions = inPermission;
			_appID = inAppID;
			
			//if not init yet!, first get init
			if (!isAvailable())
			{
				Tracer.echo('FacebookService : no ExternalInterface available!');
				return;
			}
			
			
			Facebook.init(inAppID, fbInitHandler, {/*status:false, */oauth:true});
			Facebook.addJSEventListener("auth.login", jsLoginHandler); 
			Facebook.addJSEventListener("auth.logout", jsLogoutHandler);
		}
		
		private function jsLoginHandler(result:Object):void 
		{
			//if use connect (can be in other site)
			if (result && result.status == "connected")
			{
				_connected = true;
				
				//and whather need to be init again
				//CHANGE : as call back can be before init call back
				//if(!isConnected()
			}
		} 
		
		private function jsLogoutHandler(result:Object):void 
		{ 
			_connected = false;
			dispatchEvent(new ServiceEvent(ServiceEvent.DISCONNECTED));
		}
		
		public static function getInstance(inAppID:String, inPermission:Array):FacebookService
		{
			if (FacebookService.instance == null) 
			{
				FacebookService.instance = new FacebookService(new PrivateClass(), inAppID, inPermission);
			}
			
			return FacebookService.instance;
		}
		
		public function request(inRequest:IServiceRequest):Boolean
		{
			if (!(inRequest is IServiceRequest))
			{
				Tracer.echo('FacebookService : unknown data type : ' + inRequest, this, 0xFF0000);
				return false;
			}
			
			if (!isAvailable() || !isConnected())
			{
				Tracer.echo('FacebookService : request : not connected/no ExternalInterface available!');
				dispatchEvent(new ServiceEvent(ServiceEvent.FAULT));
				
				return false;
			}
			
			var request:IServiceRequest = inRequest as IServiceRequest;
			
			if (!(request.requester is IFacebookResponder) || !(IFacebookResponder(request.requester).fbResult is Function))
			{
				Tracer.echo('FacebookService : request : no requester found!');
				return false;
			}
			
			
			
			switch(request.type)
			{
				case FacebookServicesType.ADD_FD_FEED:
				case FacebookServicesType.ADD_LIKE:
				{
					var id:String = request.data['id'];
					if (id)
					{
						delete request.data['id'];
						Facebook.api(id + request.type, IFacebookResponder(request.requester).fbResult, request.data, 'post');
					}
					
					break;
				}
				case FacebookServicesType.ADD_ME_FEED:
				{
					//_responderMap[request.communicatorID] = inRequest;
					//directly callback to the requester
					Facebook.api(request.type, IFacebookResponder(request.requester).fbResult, request.data, 'post');
					
					break;
				}
				case FacebookServicesType.GET_ME_FRIENDS:
				case FacebookServicesType.GET_ME:
				{
					Facebook.api(request.type, IFacebookResponder(request.requester).fbResult);
					break;
				}
				default:
				{
					Tracer.echo('CommunicationService : request : unknown service type : ' + inRequest.type, this, 0xFF0000);
				}
			}
			
			return true;
		}
		
		/*private function responseHandler(success:Object, fail:Object):void 
		{
			dispatchEvent(new ServiceEvent(ServiceEvent.RESPONSE, null, success));
		}*/
		
		/**
		 * always return nul for FB service
		 */
		public function get connection():NetConnection 
		{
			return null;
		}
		
		public function isAvailable():Boolean 
		{
			return ExternalInterface.available;
		}
		
		public function isConnected():Boolean 
		{
			return _fbSession != null && _connected && _hasAllPermission;
		}
		
		
		public function isAllowed(inPermission:String):Boolean
		{
			return _allowedPermission.indexOf(inPermission) != -1;
		}
		
		
		
		/**
		 * login to facebook
		 * @param	inURL - no used in fb service
		 * @param	inPermissions - a list of permission
		 * @return	true if successfully making connect to fb
		 */
		public function connect(inURL:String, inPermissions:Object = null, inForceConnect:Boolean = false):Boolean 
		{
			if (!isAvailable())
			{
				Tracer.echo('FacebookService : connect : no external service available');
				return false;
			}
			
			if (_isBusy) 
			{
				Tracer.echo('FacebookService : connect : busy');
				return false;
			}
			
			if (isConnected() && !inForceConnect)
			{
				Tracer.echo('FacebookService : connect : user already connected');
				return false;
			}
			
			if (inPermissions is Array && (inPermissions as Array).length )
			{
				_permissions = inPermissions as Array;
			}
			
			/*var permissions:Array = ['publish_stream','create_event','rsvp_event','sms','offline_access','email','read_insights','read_stream','user_about_me',
			'user_activities','user_birthday','user_education_history','user_events','user_groups','user_hometown',
			'user_interests','user_likes','user_location','user_notes','user_online_presence',
			'user_photo_video_tags','user_photos','user_relationships','user_religion_politics','user_status',
			'user_videos','user_website','user_work_history','read_friendlists','read_requests','user_notes'];*/
			//setTimeout(Facebook.login, 200, handleLogin/*, {perms:Config.FB_PERMISSIONS}*/);
			Tracer.echo('FacebookService : connect : connecting...');
			
			var currenPermission:String = _permissions && _permissions.length ? _permissions.toString() : null;
			
			_isBusy = true;
			Facebook.login(handleLogin, currenPermission ? { perms:currenPermission } : null);
			return true;
			
		}
		
		private function fbInitHandler(inResponse:FacebookAuthResponse, inError:Object):void 
		{
			_fbSession = inResponse;
			
			if (!_fbSession)
			{
				_connected = false;
				Tracer.echo('FacebookService : fbInitHandler : no session is created yet!');
			}
			else
			{
				//set connected to true once callback return authResponse
				_uid = inResponse.uid;
				_connected = true;
				
				//to dispatch event after checking permission
				//dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_SUCCESS));
				
				//if no permission required, directly dispatch event
				if (!checkPermission())
				{
					dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_SUCCESS));
				}
			}
		}
		
		public function disconnect():void 
		{
			if (_isBusy) 
			{
				Tracer.echo('FacebookService : disconnect : busy!');
				return;
			}
			
			if (!isConnected()) 
			{
				Tracer.echo('FacebookService : disconnect : is not connected yet!');
				return;
			}
			
			_isBusy = true;
			_connected = false;
			_fbSession = null;
			Facebook.logout(handleLogout);
			
		}
		
		protected function handleLogin(response:Object, fail:Object):void 
		{
			_isBusy = false;
			_fbSession = response as FacebookAuthResponse;
			_connected = _fbSession is FacebookAuthResponse;
			Tracer.echo('FacebookService : handleLogin : ' + response);
			
			//to dispatch event after checking permission
			//dispatchEvent(new ServiceEvent(_fbSession ? ServiceEvent.CONNECT_SUCCESS : ServiceEvent.CONNECT_FAIL));
			
			//if no permission required or it is not connected, directly dispatch event
			if (!_connected || !checkPermission())
			{
				dispatchEvent(new ServiceEvent(_fbSession ? ServiceEvent.CONNECT_SUCCESS : ServiceEvent.CONNECT_FAIL));
			}
		}
		
		protected function handleLogout(success:Boolean):void 
		{
			_isBusy = false;
			//always dispatch disconnected
			Tracer.echo('FacebookService : handleLogout : ' + success);
			dispatchEvent(new ServiceEvent(success ? ServiceEvent.DISCONNECTED : ServiceEvent.DISCONNECTED));
		}
		
		protected function checkPermission():Boolean
		{
			if (_permissions && _permissions.length)
			{
				Facebook.fqlQuery("SELECT {0} FROM permissions WHERE uid=me()", onFQLResponse, [_permissions.toString()]);
				return true
			}
			
			return false;
			
		}
		
		private function onFQLResponse(success:Object, fail:Object):void 
		{
			Tracer.echo(success);
			var results:Array = success as Array; 
			
			
			if (success && results) 
			{ 
				//clear all previous stored permission
				_allowedPermission.length = 0;
				
				_hasAllPermission = true;
				
				for (var i:int = 0; i < results.length; i++) 
				{ 
					var queryResult:Object = results[i]; 
					
					for (var param:String in queryResult) 
					{ 
						if (String(queryResult[param]) == '1') 
						{ 
							_allowedPermission.push(param);
						}
						else
						{
							_hasAllPermission = false;
						}
					}
				}
			}
			
			//connect success only if all permissions are allowed
			dispatchEvent(new ServiceEvent(isConnected() && _hasAllPermission ? ServiceEvent.CONNECT_SUCCESS : ServiceEvent.CONNECT_FAIL));
		}
		
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}