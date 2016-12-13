package myShopper.common.interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IService extends IEventDispatcher
	{
		function request(inRequest:IServiceRequest):Boolean;
	}
	
}