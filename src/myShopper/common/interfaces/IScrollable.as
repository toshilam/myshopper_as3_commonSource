package myShopper.common.interfaces 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IScrollable extends IApplicationDisplayObject
	{
		function get content():InteractiveObject;
		function get mask():DisplayObject;
	}
	
}