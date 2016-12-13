package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserLoginFormVO extends VO
	{
		//login info
		public var email:String;
		public var password:String;
		
		
		public function UserLoginFormVO
		(
			inVOID:String,
			inEmail:String = '', 
			inPassword:String = ''
		) 
		{
			super(inVOID);
			
			email = inEmail;
			password = inPassword;
		}
		
		override public function clear():void
		{
			email = '';
			password = '';
		}
		
	}

}