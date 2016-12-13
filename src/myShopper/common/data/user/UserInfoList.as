package myShopper.common.data.user
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserInfoList extends VOList
	{
		
		public function UserInfoList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (inVO is UserInfoVO)
			{
				return super.addVO(inVO);
			}
			
			Tracer.echo("UserInfoList : addVO : data mismatched, only UserInfoVO is accepted", this, 0xff0000);
			return 0;
		}
		
		public function getVOByUID(inUID:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (UserInfoVO(arrVO[i]).uid == inUID) return arrVO[i];
			}
			
			return null;
		}
		
	}

}