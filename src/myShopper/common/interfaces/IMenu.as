package myShopper.common.interfaces 
{
	import flash.geom.Point;
	
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IMenu 
	{
		//function get buttonList():IButtonList;
		//
		//function addButtons(inButtonList:IButtonList, inLayout:String = 'horizontal'):void;
		//function removeButtons():IButtonList;
		//
		//function getButtonByID(inButtonID:String):IButton;
		//function getButtonByIndex(inButtonIndex:uint):IButton;
		
		function get layoutType():String;
		function get layoutDistance():int;
		function setLayout(inLayout:String = 'horizontal', inDistance:int = 10, initPoint:Point = null):void;
		
		function disable():void
		
		function enable():void
		
	}
	
}