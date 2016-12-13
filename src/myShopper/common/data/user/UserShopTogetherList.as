package myShopper.common.data.user
{
	import myShopper.common.data.communication.UserUserCommVOList;
	import myShopper.common.data.VOList;
	import myShopper.common.events.VOEvent;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * a list of user vo who are currently shopping together
	 * auto remove vo whenever there is user logged off
	 * @author Toshi
	 */
	public class UserShopTogetherList extends UserInfoList
	{
		//host user id
		private var _hostUID:String;
		private var _groupID:String;
		
		private var _chatList:UserUserCommVOList;
		public function get chatList():UserUserCommVOList { return _chatList; }
		
		public function UserShopTogetherList(inID:String) 
		{
			super(inID);
			_hostUID = '';
			_groupID = '';
			_chatList = new UserUserCommVOList(inID);
			
		}
		
		override public function clear():void 
		{
			super.clear();
			_hostUID = '';
			_groupID = '';
			_chatList.clear();
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			var uVO:UserInfoVO = inVO as UserInfoVO;
			
			//check is this user has already added in list
			if (uVO && !getVOByUID(uVO.uid))
			{
				//handle vo change event for whenever there is a user disccnnected suddenly
				uVO.addEventListener(VOEvent.VALUE_CHANGED, voEventHandler, false, 0, true);
				
				return super.addVO(uVO);
			}
			
			Tracer.echo('UserShopTogetherList : addVO : user already in list!');
			return 0;
		}
		
		private function voEventHandler(e:VOEvent):void 
		{
			if (e.propertyName == 'isLogged' && e.propertyValue === false)
			{
				var uVO:UserInfoVO = e.data as UserInfoVO;
				uVO.removeEventListener(VOEvent.VALUE_CHANGED, voEventHandler);
				
				super.removeVO(uVO);
			}
		}
		
		public function get hostUID():String 
		{
			return _hostUID;
		}
		
		public function set hostUID(value:String):void 
		{
			_hostUID = value;
			dispatchChangeEvent('hostUID', hostUID);
		}
		
		public function get groupID():String 
		{
			return _groupID;
		}
		
		public function set groupID(value:String):void 
		{
			_groupID = value;
			dispatchChangeEvent('groupID', groupID);
		}
		
	}

}