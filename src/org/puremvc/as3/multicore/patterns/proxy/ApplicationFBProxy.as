package org.puremvc.as3.multicore.patterns.proxy 
{
	import myShopper.common.data.AlerterVO;
	import myShopper.common.emun.AlerterType;
	import myShopper.common.emun.MessageID;
	import myShopper.common.emun.ServiceID;
	import myShopper.common.events.AlerterEvent;
	import myShopper.common.interfaces.IFacebookResponder;
	import myShopper.common.net.FacebookService;
	import myShopper.common.net.ServiceRequest;
	import myShopper.common.utils.Alert;
	import myShopper.fl.Alerter;
	import myShopper.fl.ConfirmAlerter;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ApplicationFBProxy extends ApplicationProxy implements IFacebookResponder
	{
		protected var _service:FacebookService;
		
		
		//private var _isHandleError:Boolean;
		//protected function get isHandleError():Boolean {return _isHandleError;}
		
		public function ApplicationFBProxy(inName:String, inData:Object=null) 
		{
			super(inName, inData);
			
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			_service = serviceManager.getAsset(ServiceID.FACEBOOK);
			
			if (!_service)
			{
				throw(new UninitializedError(multitonKey + ' : onRegister : unable to retreve service!'));
			}
			
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			_service = null;
		}
		
		/* INTERFACE myShopper.common.interfaces.IFacebookResponder */
		
		public function fbResult(inData:Object, inFault:Object/*, inHandleError:Boolean = true*/):Boolean 
		{
			if (inData)
			{
				result(inData);
				return true;
			}
			else if (inFault)
			{
				fault(inFault);
			}
			
			return false;
		}
		
		public function result(data:Object):void 
		{
			
		}
		
		public function fault(info:Object):void 
		{
			/*if (info)
			{
				var error:Object = info['error'];
				
				if (error)
				{
					var code:String = String(error['code']);
					if (code) //currently, asume all error is caused by permission
					{
						var ca:ConfirmAlerter = Alert.show(new AlerterVO('', AlerterType.CONFIRM, '', null, getMessage(MessageID.ERROR_TITLE), getMessage(MessageID.ERROR_FB_PERMISSION))) as ConfirmAlerter;
						
						//NOTE, event may not be caught, if this proxy removed before user make decision
						if (ca)
						{
							ca.addEventListener(AlerterEvent.CANCEL, alerterEventHandler, false, 0, true);
							ca.addEventListener(AlerterEvent.CLOSE, alerterEventHandler, false, 0, true);
							ca.addEventListener(AlerterEvent.CONFIRM, alerterEventHandler, false, 0, true);
						}
					}
				}
				
			}*/
			
		}
		
		/*protected function alerterEventHandler(e:AlerterEvent):void 
		{
			e.targetDisplayObject.removeEventListener(AlerterEvent.CANCEL, alerterEventHandler);
			e.targetDisplayObject.removeEventListener(AlerterEvent.CLOSE, alerterEventHandler);
			e.targetDisplayObject.removeEventListener(AlerterEvent.CONFIRM, alerterEventHandler);
			
			if (e.type == AlerterEvent.CONFIRM && _service)
			{
				if (!_service.connect('', null, true))
				{
					echo('alerterEventHandler : unable to connect to fb service');
				}
			}
		}*/
		
		public function isConnected(inAutoConnect:Boolean = false):Boolean
		{
			var isConnected:Boolean = _service.isConnected();
			
			if (!isConnected && inAutoConnect)
			{
				var ca:ConfirmAlerter = Alert.show(new AlerterVO('', AlerterType.CONFIRM, '', null, getMessage(MessageID.CONFIRM_TITLE), getMessage(MessageID.CONFIRM_LOGIN_FB))) as ConfirmAlerter;
				//NOTE, event may not be caught, if this proxy removed before user make decision
				ca.addEventListener(AlerterEvent.CANCEL, alertEventHandler, false, 0, true)
				ca.addEventListener(AlerterEvent.CONFIRM, alertEventHandler, false, 0, true)
				ca.addEventListener(AlerterEvent.CLOSE, alertEventHandler, false, 0, true)
				
			}
			return isConnected;
		}
		
		protected function alertEventHandler(e:AlerterEvent):void 
		{
			e.targetDisplayObject.removeEventListener(AlerterEvent.CANCEL, alertEventHandler);
			e.targetDisplayObject.removeEventListener(AlerterEvent.CLOSE, alertEventHandler);
			e.targetDisplayObject.removeEventListener(AlerterEvent.CONFIRM, alertEventHandler);
			
			if (e.type == AlerterEvent.CONFIRM && _service)
			{
				_service.connect('');
			}
		}
		
		public function call(inService:String, inData:Object = null, inResponder:IFacebookResponder = null):Boolean
		{
			return _service.request(new ServiceRequest(inService, inData, inResponder ? inResponder : this));
		}
		
		
	}

}