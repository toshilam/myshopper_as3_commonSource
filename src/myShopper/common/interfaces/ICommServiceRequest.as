package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface ICommServiceRequest extends IServiceRequest
	{
		/**
		 * type of service request
		 */
		function get communicatorID():String
		
		function get communicationType():String
	}
	
}