package myShopper.common.interfaces 
{
	import myShopper.common.display.Image;
	
	[Event(name = "sizeOver", type = "myShopper.common.events.FileEvent")]
	/**
	 * ...
	 * @author Toshi
	 */
	public interface ISystemFileLoader extends IDataDisplayObject
	{
		function get logo():Image;
		
		function setMaxSize(inSize:Number = -1):void
	}
	
}