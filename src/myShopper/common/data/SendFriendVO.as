package myShopper.common.data 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class SendFriendVO extends VO
	{
		public var yourName:String;
		public var yourMail:String;
		public var FriendMail:String;
		public var FriendName:String;
		public var message:String;
		public var sendMe:Boolean;
		
		public function SendFriendVO(inVOID:String) 
		{
			super(inVOID);
			clear();
		}
		
		override public function clear():void
		{
			yourName = '';
			yourMail = '';
			FriendMail = '';
			FriendName = '';
			message = '';
			sendMe = false;
			
		}
	}

}