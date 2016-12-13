package myShopper.common.interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IApplicationSound extends IEventDispatcher
	{
		function play():Boolean
		
		function stop():void
		
		function get volume():Number 
		function set volume(value:Number):void 
		
		function get isPlaying():Boolean 
		
		function get id():String
	}
	
}