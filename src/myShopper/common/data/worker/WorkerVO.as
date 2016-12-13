package myShopper.common.data.worker 
{
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class WorkerVO extends VO 
	{
		public var requestData:Object;
		public var responseData:Object;
		public var type:String; //reference WorkerType
		
		public function WorkerVO(inID:String) 
		{
			//an uniqueID that share between main and back worker
			super(inID);
			
		}
		
	}

}