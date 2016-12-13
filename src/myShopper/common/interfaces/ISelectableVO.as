package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface ISelectableVO extends IVO
	{
		function get isSelected():Boolean;
		function set isSelected(inValue:Boolean):void;
	}
	
}