package myShopper.common.interfaces 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IForm 
	{
		function get arrFormElement():Vector.<DisplayObject>
		
		/**
		 * set data object which is used to store user input
		 * @param	inVO
		 */
		//function setVO(inVO:IVO):void;
		/**
		 * the data object which is used to store user input
		 * @param	inVO
		 */
		//function getVO():IVO;
		
		/**
		 * a function checking user input
		 * @return true if no problem found, else return a vector array which contains problem textfields
		 */
		function isValid():*
		
		/**
		 * to clear all the text in each text field
		 */
		function clear():void;
		
		
	}
	
}