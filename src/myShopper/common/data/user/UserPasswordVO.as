package myShopper.common.data.user 
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.VO;
	/**
	 * for changing password
	 * @author Toshi
	 */
	public class UserPasswordVO extends VO
	{
		public var oldPassword:String;
		public var newPassword:String;
		
		public function UserPasswordVO(inVOID:String) 
		{
			super(inVOID);
		}
		
		override public function clear():void
		{
			oldPassword = newPassword = '';
		}
		
		
	}

}