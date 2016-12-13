package myShopper.common.net 
{
	import com.greygreen.net.p2p.events.P2PEvent;
	import com.greygreen.net.p2p.model.P2PConfig;
	import com.greygreen.net.p2p.P2PClient;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import myShopper.common.data.FMS.FMSRequestVO;
	import myShopper.common.events.ServiceEvent;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.utils.Tracer;
	
	
	[Event(name = "response", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "connectFail", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "connectSuccess", type = "myShopper.common.events.ServiceEvent")] 
	[Event(name = "disconnected", type = "myShopper.common.events.ServiceEvent")] 
	
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class RTMFPServiceConnection extends ServiceConnection 
	{
		public static const METHOD_NAME:String = 'message'; 
		
		private var _isConnecting:Boolean;
		private var _rtmfp:P2PClient;
		
		private var _refreshTimer:Timer;
		private var _refreshInterval:int;
		
		private var _config:P2PConfig;
		
		//once connection is successfully made, a list of object need to be called to server (due to connection is not already)
		private var _subscribedCallList:Vector.<IServiceRequest>; 
		
		public function RTMFPServiceConnection(/*inConnection:FlashSocket*/) 
		{
			super(null);
			
			_rtmfp = new P2PClient();
			
			
			
			//_responderMap = new Object();
			//
			//_responder = new Responder(result, fault);
			_isConnecting = false;
			_subscribedCallList = new Vector.<IServiceRequest>();
			
			_refreshTimer = new Timer(1000 * 60);
			_refreshTimer.addEventListener(TimerEvent.TIMER, timerEventHandler, false, 0, true);
		}
		
		override public function get connection():NetConnection 
		{
			Tracer.echo('RTMFPServiceConnection : connection : call disabled function! call rtmfpConnection instead of!');
			return null;
		}
		
		public  function get rtmfpConnection():P2PClient
		{
			return _rtmfp;
		}
		
		
		/**
		 * autometically disconnect and re-connect to server in a indicated time
		 * @param	inValue - time to be refresh connection in millisecond (do noting if inValue = 0)
		 */
		public function autoRefreshConnection(inValue:int):void 
		{
			if (_refreshTimer.running)
			{
				_refreshTimer.reset();
				_refreshTimer.stop();
			}
			
			_refreshInterval = inValue;
			if (_refreshInterval > 0)
			{
				_refreshTimer.delay = _refreshInterval;
				_refreshTimer.start();
			}
		}
		
		private function timerEventHandler(e:TimerEvent):void 
		{
			if (isConnected())
			{
				disconnect();
				
			}
			
			if (_config) setTimeout(connect, 1000, _config.groupName);
			
			
		}
		
		override public function isConnected():Boolean 
		{
			return _rtmfp && _rtmfp.connected;
		}
		
		
		override public function connect(inGroupName:String, inData:Object = null):Boolean 
		{
			if (_isConnecting)
			{
				
				return false;
			}
			
			if (!isConnected())
			{
				_isConnecting = true;
				
				_rtmfp.addEventListener(P2PEvent.FAILED, onError);
				_rtmfp.addEventListener(P2PEvent.CONNECTED, onConnect);
				_rtmfp.addEventListener(P2PEvent.PEER_CONNECTED, onPeerConnect);
				_rtmfp.addEventListener(P2PEvent.CLOSED, onDisconnect);
				_rtmfp.listen(result, METHOD_NAME);
				//to be handled by proxy
				//_rtmfp.addEventListener(P2PEvent.STATE_RESTORED, onStateRestored);
				//_rtmfp.addEventListener(P2PEvent.STATE_RESTORE_FAILED, onFailure);
				//_rtmfp.addEventListener(P2PEvent.PEER_CONNECTED, userJoin);
				//_rtmfp.addEventListener(P2PEvent.PEER_DISCONNECTED, userLeave);
				
				//_rtmfp.listen(messageReceived, "message");
				
				//_rtmfp.listen(userRegister, "user");
				
				_config = new P2PConfig({
					//groupName: "p2p/chat/1",
					groupName: inGroupName,
					saveState: "false"
				});
				_rtmfp.connect(_config);
				
				_rtmfp.receive = true;
				return true;
			}
			
			Tracer.echo('RTMFPServiceConnection : connect : is not connected or already authenticated!', this, 0xFF0000);
			return false;
		}
		
		override public function disconnect():void 
		{
			//not to use super, as fms disconnect event should be dispatched once netstatus event received
			//super.disconnect();
			if (_rtmfp /*&& _ws.connected*/) 
			{
				
				//to be handled by proxy
				//_rtmfp.removeEventListener(P2PEvent.STATE_RESTORED, onStateRestored);
				//_rtmfp.removeEventListener(P2PEvent.STATE_RESTORE_FAILED, onFailure);
				//_rtmfp.removeEventListener(P2PEvent.PEER_CONNECTED, userJoin);
				//_rtmfp.removeEventListener(P2PEvent.PEER_DISCONNECTED, userLeave);
				
				if (isConnected())
				{
					//_ws.send(new FMSRequestVO(FMSServicesType.USER_LOGOUT, null, null), FMS_METHOD_NAME);
				}
				
				//_ws.close();
				
				_isConnected = false;
				
				_rtmfp.disconnect();
				//onDisconnect(null);
			}
			
			
		}
		
		//for fail connect fms call back
		public function close():void
		{
			disconnect();
		}
		
		override public function request(inRequest:IServiceRequest):Boolean
		{
			if (!(inRequest.data is FMSRequestVO))
			{
				Tracer.echo('RTMFPServiceConnection : request : unknown data type : ' + inRequest , this, 0xFF0000);
				return false;
			}
			
			var vo:FMSRequestVO = inRequest.data as FMSRequestVO;
			
			if (!isConnected() || !_rtmfp.group.neighborCount)
			{
				if (!vo.addBuffer)
				{
					Tracer.echo('RTMFPServiceConnection : request : server is not connected yet!', this, 0xFF0000);
					return false;
				}
				
				Tracer.echo('remoteCall : FMS server is not connected, request vo is added in list, and will be call once connection is made');
				_subscribedCallList.push(inRequest);
				
				
			}
			else
			{
				vo.uniqueID = getUniqueID();
				
				Tracer.echo('RTMFPServiceConnection : request : ' + vo.service , this, 0xFF0000);
				
				remoteCall(METHOD_NAME, vo, null);
			}
			
			return true;
		}
		
		override protected function remoteCall(inServiceType:String, inData:Object, inResponder:Responder):void
		{
			_rtmfp.send(inData, inServiceType);
		}
		
		//to be call when receiving event "message" (P2PPacket)
		override public function result(data:Object):void 
		{
			//var result:ResultVO = data as ResultVO;
			Tracer.echo('RTMFPServiceConnection : result : ' + data, this, 0xFF0000);
			//Tracer.echo(data, this, 0xFF0000);
			
			if (!data)
			{
				return;
			}
			
			
			//var result:ResultVO = AMFResultFactory.convert(data);
			
			
			//dispatch vo if successfully converted to resultVO, else pass data object
			dispatchEvent(new ServiceEvent(ServiceEvent.RESPONSE, null, data));
			
			//Tracer.echo('RTMFPServiceConnection : result : no service requester found! ', this, 0xFF0000);
		}
		
		private function onConnect(e:P2PEvent):void 
		{
			_isConnected = true;
			_isConnecting = false;
			
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_SUCCESS, null, e));
			
			retry();
		}
		
		private function onPeerConnect(e:P2PEvent):void 
		{
			retry();
		}
		
		private function retry():void 
		{
			if (_rtmfp.group.neighborCount)
			{
				while (_subscribedCallList.length)
				{
					var fmsRequest:IServiceRequest = _subscribedCallList.splice(0, 1)[0] as IServiceRequest;
					Tracer.echo('RTMFPServiceConnection : onConnect : connection is made, and calling subscribed request : ' + fmsRequest.type);
					request(fmsRequest);
				}
			}
			
		}
		
		
		private function onError(e:P2PEvent):void 
		{
			_isConnected = _isConnecting = false;
			Tracer.echo('ServiceConnection : onError : ' + e.type, this, 0xFF0000);
			disconnect();
			dispatchEvent(new ServiceEvent(ServiceEvent.CONNECT_FAIL, null, e));
		}
		
		private function onDisconnect(e:P2PEvent):void 
		{
			Tracer.echo('ServiceConnection : onDisconnect : ' + e, this, 0xFF0000);
			_isConnected = _isConnecting = false;
			
			_rtmfp.removeEventListener(P2PEvent.FAILED, onError);
			_rtmfp.removeEventListener(P2PEvent.CONNECTED, onConnect);
			_rtmfp.removeEventListener(P2PEvent.CLOSED, onDisconnect);
			_rtmfp.unlisten(METHOD_NAME, result);
			
			dispatchEvent(new ServiceEvent(ServiceEvent.DISCONNECTED, null, e));
		}
		
	}

}