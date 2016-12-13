package myShopper.common.data.map
{
	import flash.display.DisplayObject;
	import myShopper.common.data.user.UserInfoVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserMarkerVO extends InfoMarkerVO
	{
		public var uid:String;
		public var userInfoVO:UserInfoVO;
		
		public function UserMarkerVO
		(
			inVOID:String, 
			inName:String = '', 
			inUID:String = '', 
			inLat:Number = 0, 
			inLng:Number = 0, 
			inIcon:DisplayObject = null,
			inMarkerType:String = '',
			inVisibleLevel:int = -1
		) 
		{
			super(inVOID, inName, inLat, inLng, inIcon, inMarkerType, inVisibleLevel);
			uid = inUID;
		}
		
	}

}