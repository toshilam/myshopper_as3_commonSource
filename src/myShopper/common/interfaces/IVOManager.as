package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IVOManager 
	{
		function registerVO(inVO:IVO, inVOID:String):Boolean;
		function retrieveVO(inVOID:String):IVO;
		function removeVO(inVOID:String):Boolean;
		function hasVO(inVOID:String):Boolean;
	}
	
}