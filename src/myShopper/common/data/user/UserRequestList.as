package myShopper.common.data.user 
{
	import myShopper.common.data.VOList;
	import myShopper.common.emun.RequestType;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserRequestList extends VOList
	{
		
		public function UserRequestList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (inVO is UserRequestVO)
			{
				return super.addVO(inVO);
			}
			
			Tracer.echo('UserRequestList : addVO : mismatched value type : only object UserRequestList is accepted', this, 0xff0000);
			return 0;
		}
		
		public function getShopTogetherRequestVOByUID(inFromUID:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				var vo:UserRequestVO = arrVO[i] as UserRequestVO;
				if (vo.type == RequestType.USER_SHOP_TOGETHER_REQUEST && vo.fromUID == inFromUID)
				{
					return arrVO[i];
				}
			}
			
			return null;
		}
		
		public function getAddFriendRequestVOByUID(inFromUID:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				var vo:UserRequestVO = arrVO[i] as UserRequestVO;
				if (vo.type == RequestType.USER_ADD_FRIEND_REQUEST && vo.fromUID == inFromUID)
				{
					return arrVO[i];
				}
			}
			
			return null;
		}
		
		public function removeAddFriendRequestVOByUID(inFromUID:String):UserRequestVO
		{
			var vo:UserRequestVO = getAddFriendRequestVOByUID(inFromUID) as UserRequestVO;
			if (vo)
			{
				return super.removeVO(vo) as UserRequestVO;
			}
			
			return null;
		}
		
		public function removeShopTogetherRequestVOByUID(inFromUID:String):UserRequestVO
		{
			var vo:UserRequestVO = getShopTogetherRequestVOByUID(inFromUID) as UserRequestVO;
			if (vo)
			{
				return super.removeVO(vo) as UserRequestVO;
			}
			
			return null;
		}
	}

}