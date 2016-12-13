package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserQuestionVO extends VO 
	{
		public var qno:String = '';
		//public var name:String;
		//public var email:String;
		//public var subject:String;
		public var message:String = '';
		public var date:String = '';
		
		//public var shopID:String //shop user id
		
		public function UserQuestionVO(inID:String) 
		{
			super(inID);
			
		}
		
		override public function clear():void 
		{
			//qno = name = email = subject = message = date = '';
			qno = date = message = '';
		}
	}

}