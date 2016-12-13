package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	import myShopper.common.emun.RequestType;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserAddFriendRequestVO extends UserRequestVO
	{
		//public var uid:String;
		//public var friendUID:String;
		//public var message:String;
		public var fromName:String;
		public var toName:String;
		public var headerMessage:String; //the message shown on the display object
		
		
		
		public function UserAddFriendRequestVO(inFromUID:String, inToUID:String, inMessage:String, inFromName:String, inToName:String, inHeaderMessage:String = '') 
		{
			super(inFromUID, inToUID, RequestType.USER_ADD_FRIEND_REQUEST, inMessage );
			//fromUID = inFromUID;
			//toUID = inToUID;
			//data = inMessage;
			fromName = inFromName;
			toName = inToName;
			headerMessage = inHeaderMessage;
			
			isAccept = false;
		}
		
		override public function clear():void
		{
			super.clear();
			
			fromName = '';
			toName = '';
			headerMessage = '';
			isAccept = false;
		}
		
		override public function clone():IVO 
		{
			return new UserAddFriendRequestVO(fromUID, toUID, String(data), fromName, toName, headerMessage);
		}
	}

}