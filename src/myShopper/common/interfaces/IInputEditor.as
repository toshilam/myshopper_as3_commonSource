package myShopper.common.interfaces 
{
	import flash.text.TextField;
	
	
	//[Event(name = "buttonDown", type = "myShopper.common.events.ButtonEvent")] 
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IInputEditor extends IApplicationDisplayObject
	{
		function get textField():TextField;
		function get button():IButton
	}
	
}