package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IServiceResponse 
	{
		function get request():IServiceRequest;
		
		function get data():Object;
		
	}
	
}