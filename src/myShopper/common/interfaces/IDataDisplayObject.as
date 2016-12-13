package myShopper.common.interfaces 
{
	
	/**
	 * A display object which contains vo data
	 * @author Toshi Lam
	 */
	public interface IDataDisplayObject
	{
		function get vo():IVO
		
		function setInfo(inData:IVO):Boolean;
		
		function updateInfo():Boolean;
	}
	
}