package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IResponder 
	{
		/**
		 * method to be called back from remote server once data successfully received
		 * @param	data - object container result data
		 */
		function result(data:Object):void;
		
		/**
		 * method to be called back from remote server if failure
		 * @param	info - error info
		 */
		function fault(info:Object):void;
	}
	
}