package myShopper.common.data.map
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Toshi
	 */
	public class MyShopMarkerVO extends InfoMarkerVO
	{
		public function MyShopMarkerVO
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
			super(inVOID, inName, inLat, inLng, inIcon, inMarkerType, inVisibleLevel);
		}
		
	}

}