package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IMoveableDisplayObject 
	{
		function get isMoving():Boolean;
		
		function startMoving(inData:Object = null):*
		
		function stopMoving(inData:Object = null):*
	}
	
}