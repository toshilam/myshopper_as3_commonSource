package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	import myShopper.common.emun.RequestType;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserShopTogetherRequestVO extends UserRequestVO
	{
		public var fromName:String = '';
		public var toName:String = '';
		
		public var groupID:String = '';
		
		public function UserShopTogetherRequestVO(inFromUID:String, inToUID:String, inMessage:String, inFromName:String, inToName:String, inGroupID:String) 
		{
			super(inFromUID, inToUID, RequestType.USER_SHOP_TOGETHER_REQUEST, inMessage );
			//fromUID = inFromUID;
			//toUID = inToUID;
			//data = inMessage;
			fromName = inFromName;
			toName = inToName;
			
			groupID = inGroupID;
			
			isAccept = false;
		}
		
		override public function clear():void
		{
			super.clear();
			
			fromName = '';
			toName = '';
			groupID = '';
			isAccept = false;
		}
		
		override public function clone():IVO 
		{
			return new UserShopTogetherRequestVO(fromUID, toUID, String(data), fromName, toName, groupID);
		}
	}

}