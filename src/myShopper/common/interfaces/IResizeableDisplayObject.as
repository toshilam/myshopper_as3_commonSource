package myShopper.common.interfaces 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IResizeableDisplayObject extends IPage
	{
		/**
		 * to be called once the stage size is being changed.
		 * @param	inApp
		 */
		function onStageResize(inApp:Stage):void;
	}
	
}