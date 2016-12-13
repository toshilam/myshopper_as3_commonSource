package myShopper.common.worker 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Toshi
	 */
	public class Workers 
	{
		//Disabled on 15/04/2014 as fail packaging IPA, because of Embed tag
		//[Embed(source="../../../../../../../../deploy/debug/appMediaWorker.swf", mimeType="application/octet-stream")]
		//private static var appMediaWorker_ByteClass:Class;
		
		public static function get MediaWorker():ByteArray
		{
			//return new appMediaWorker_ByteClass();
			return new ByteArray();
		}
		
		public function Workers() 
		{
			
		}
		
	}

}