package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IServiceRequest
	{
		/**
		 * type of service request
		 */
		function get type():String;
		
		function set type(inValue:String):void;
		
		function get data():Object;
		
		function set data(inValue:Object):void;
		
		function get requester():IResponder;
	}
	
}