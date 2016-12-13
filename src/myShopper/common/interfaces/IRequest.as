package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IRequest extends IVO
	{
		function get type():String;
		
		function get data():Object;
		
		function get responder():IResponder
	}
	
}