package org.puremvc.as3.multicore.patterns.proxy 
{
	import flash.net.Responder;
	import flash.utils.Dictionary;
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.emun.AMFServicesErrorID;
	import myShopper.common.emun.ServiceID;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.net.RemoteService;
	import myShopper.common.net.ServiceConnection;
	import myShopper.common.net.ServiceRequest;
	import myShopper.common.server.AMFResultFactory;
	import org.puremvc.as3.multicore.interfaces.IRemoteDataProxy;
	
	/**
	 * A proxy
	 */
	public class ApplicationRemoteProxy extends ApplicationProxy implements IResponder, IRemoteDataProxy
	{
		private var _service:RemoteService;
		//private var _responder:Responder;
		private var _arrReqObj:Array;
		
		public function ApplicationRemoteProxy(inName:String, inData:Object = null) 
		{
			super(inName, inData);
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			_service = serviceManager.getAsset(ServiceID.AMF);
			
			//_responder = new Responder(result, fault);
			_arrReqObj = new Array();
			
			if (!_service)
			{
				throw(new UninitializedError(multitonKey + ' : onRegister : unable to get AMF connection'));
			}
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			
			_service = null;
			_arrReqObj.length = 0;
			_arrReqObj = null;
		}
		
		/* INTERFACE myShopper.common.interfaces.IResponder */
		
		public function result(inData:Object):void 
		{
			var req:ServiceRequest = removeCalledRequest();
			var result:ResultVO = (!(inData is ResultVO)) ? AMFResultFactory.convert(inData) : inData as ResultVO;
			
			setRemoteData(result.service, result);
		}
		
		public function fault(info:Object):void 
		{
			var req:ServiceRequest = removeCalledRequest();
			
			if (!req)
			{
				throw(new Error('ApplicationRemoteProxy : fault : unknown call back : ' + info));
			}
			
			echo('fault : fail calling ' + req.type);
			
			var result:ResultVO = new ResultVO('', req.type, AMFServicesErrorID.CALL_FAIL, req, req.data[ServiceConnection.UNIQUE_ID_PN]);
			setRemoteData(result.service, result);
		}
		
		/* INTERFACE org.puremvc.as3.multicore.interfaces.IRemoteDataProxy */
		
		public function getRemoteData(inService:String, inData:Object = null):Boolean 
		{
			return false;
		}
		
		public function setRemoteData(inService:String, inData:Object):Boolean 
		{
			return false;
		}
		
		protected function call(inService:String, inData:Object = null):Boolean
		{
			echo('calling : ' + inService, this, 0xFF0000);
			
			var req:ServiceRequest = new ServiceRequest(inService, inData, this, true);
			_arrReqObj.push(req);
			_service.request(req);
			
			return true;
		}
		
		/**
		 * remove previous called request, AMF request call back always in order (first in first out)
		 * @return previous called request
		 */
		protected function removeCalledRequest():ServiceRequest
		{
			var req:ServiceRequest = null;
			
			//remove stored request
			if (_arrReqObj && _arrReqObj.length)
			{
				//req = _arrReqObj.slice(0, 1)[0];
				req = _arrReqObj.splice(0, 1)[0];
			}
			
			return req;
		}
	}
}