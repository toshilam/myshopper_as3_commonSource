package myShopper.common.data.user
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserFriendList extends VOList
	{
		
		public function UserFriendList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (inVO is UserFriendInfoVO)
			{
				return super.addVO(inVO);
			}
			
			Tracer.echo('UserFriendList : addVO : data mismatched!', this, 0xff0000);
			return 0;
		}
		
		public function getVOByUID(inUID:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (UserFriendInfoVO(arrVO[i]).uid == inUID) return arrVO[i];
			}
			
			return null;
		}
		
		
	}

}