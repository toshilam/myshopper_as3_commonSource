package myShopper.common.utils 
{
	import flash.net.NetConnection;
	/**
	 * ...
	 * @author Macentro
	 */
	public class ConnectionManager extends Manager
	{
		
		public function ConnectionManager() 
		{
			super();
		}
		
		public function registerConnection(inConnection:NetConnection, inID:String):Boolean
		{
			return super.register(inConnection, inID);
		}
		
		public function retrieveConnection(inID:String):NetConnection
		{
			return super.retrieve(inID) as NetConnection;
		}
		
		public function removeConnection(inID:String):Boolean
		{
			return super.remove(inID);
			
		}
		
		public function hasConnection(inID:String):Boolean
		{
			return super.hasObject(inID);
		}
	}

}