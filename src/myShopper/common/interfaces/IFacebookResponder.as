package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IFacebookResponder extends IResponder
	{
		function fbResult(inData:Object, inFault:Object/*, inHandleError:Boolean = true*/):Boolean;
	}
	
}