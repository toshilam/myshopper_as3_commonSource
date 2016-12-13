package myShopper.common.interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IVO extends IEventDispatcher
	{
		function get id():String;
		function set id(inValue:String):void;
		
		function get selectedLangCode():String;
		function set selectedLangCode(inValue:String):void;
		
		function clear():void;
		function clone():IVO;
	}
	
}