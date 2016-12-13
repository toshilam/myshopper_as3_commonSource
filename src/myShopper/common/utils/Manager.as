package myShopper.common.utils 
{
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Macentro
	 */
	public class Manager
	{
		protected var objList:Object;
		
		public function Manager() 
		{
			objList = new Object();
		}
		
		protected function register(inObj:Object, inID:String):Boolean
		{
			if (objList[inID] == undefined || objList[inID] == null)
			{
				objList[inID] = inObj;
				return true;
			}
			Tracer.echo('Manager : register : already exist : ' + inID, this, 0xff0000);
			return false;
		}
		
		protected function retrieve(inID:String):Object
		{
			return objList[inID];
		}
		
		protected function remove(inID:String):Boolean
		{
			if (objList[inID] == undefined || objList[inID] == null)
			{
				Tracer.echo('Manager : remove : not found : ' + inID, this, 0xff0000);
				return false;
				
			}
			
			objList[inID] = null;
			return true;
			
		}
		
		protected function hasObject(inID:String):Boolean
		{
			if (objList[inID] == undefined || objList[inID] == null)
			{
				return false;
			}
			
			return true;
		}
	}

}