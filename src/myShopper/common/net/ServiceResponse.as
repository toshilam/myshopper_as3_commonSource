package myShopper.common.net 
{
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.interfaces.IServiceResponse;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ServiceResponse extends Object implements IServiceResponse
	{
		private var _request:IServiceRequest;
		private var _data:Object;
		
		public function ServiceResponse(inRequest:IServiceRequest, inData:Object) 
		{
			super();
			
			_request = inRequest;
			_data = inData;
		}
		
		public function get request():IServiceRequest 
		{
			return _request;
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
	}

}