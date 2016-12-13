package myShopper.common.utils 
{
	/**
	 * ...
	 * @author Macentro
	 */
	public class ApplicationConnectionManager extends ConnectionManager
	{
		private static var instance:ApplicationConnectionManager;
		
		public function ApplicationConnectionManager(pvt:PrivateClass) 
		{
			
		}
		
		public static function getInstance():ApplicationConnectionManager
		{
			if (ApplicationConnectionManager.instance == null) 
			{
				ApplicationConnectionManager.instance = new ApplicationConnectionManager(new PrivateClass());
			}
			
			return ApplicationConnectionManager.instance;
		}
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}