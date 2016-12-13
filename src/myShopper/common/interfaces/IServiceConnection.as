package myShopper.common.interfaces 
{
	import flash.net.NetConnection;
	
	[Event(name="fault", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="connectFail", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="connectSuccess", type="myShopper.common.events.ServiceEvent")] 
	[Event(name="disconnected", type="myShopper.common.events.ServiceEvent")] 
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IServiceConnection extends IService
	{
		function get connection():NetConnection;
		
		function isConnected():Boolean;
		
		function connect(inURL:String, rest:Object = null):Boolean;
		
		function disconnect():void;
		
		
		
	}
	
}