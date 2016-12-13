package myShopper.common.data.map
{
	import flash.display.DisplayObject;
	import myShopper.common.data.user.UserInfoVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class MyUserMarkerVO extends UserMarkerVO
	{
		public function MyUserMarkerVO
		(
			inVOID:String, 
			inName:String = '', 
			inID:String = '', 
			inLat:Number = 0, 
			inLng:Number = 0, 
			inIcon:DisplayObject = null,
			inMarkerType:String = '',
			inVisibleLevel:int = -1
		) 
		{
			super(inVOID, inName, inID, inLat, inLng, inIcon, inMarkerType, inVisibleLevel);
		}
		
	}

}