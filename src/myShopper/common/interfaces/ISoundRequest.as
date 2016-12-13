package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface ISoundRequest extends IRequest
	{
		function get startTime():Number;
		
		function get loops():int;
		
		function get volume():Number;
		
		function get isBGSound():Boolean;
		function set isBGSound(inValue:Boolean):void;
		
		/**
		 * an unique id that assign by soundService
		 */
		function get soundID():String;
	}
	
}