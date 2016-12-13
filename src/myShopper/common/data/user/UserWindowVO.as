package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserWindowVO extends VO
	{
		public var windowName:String;
		public var data:Object;
		
		public function UserWindowVO(inVOID:String, inWindowName:String, inData:Object) 
		{
			super(inVOID);
			windowName = inWindowName;
			data = inData;
		}
		
		override public function clear():void
		{
			windowName = '';
			data = null;
		
		}
	}

}