package myShopper.common.server 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class FMSClient extends EventDispatcher implements IEventDispatcher
	{
		
		public function FMSClient(target:IEventDispatcher = null) 
		{
			super(target);
			
		}
		
	}

}