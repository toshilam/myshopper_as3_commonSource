package myShopper.common.data.worker 
{
	import flash.display.DisplayObject;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IResponder;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ImageWorkerVO extends VO 
	{
		public var width:Number;
		public var height:Number;
		public var quality:int;
		public var displayObject:DisplayObject;
		public var fileVO:FileImageVO;
		
		//that object that handling response from worker
		public var responder:IResponder;
		
		public function ImageWorkerVO(inID:String, inDisplayObject:DisplayObject, inWidth:Number, inHeight:Number, inQuality:int, inFileVO:FileImageVO, inResponder:IResponder) 
		{
			super(inID);
			displayObject = inDisplayObject;
			width = inWidth;
			height = inHeight;
			quality = inQuality;
			fileVO = inFileVO;
			responder = inResponder;
		}
		
	}

}