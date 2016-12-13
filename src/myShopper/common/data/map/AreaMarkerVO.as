package myShopper.common.data.map 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class AreaMarkerVO extends DistrictMarkerVO
	{
		public var district:String = '';
		public var part:String = ''; //hk / kln / nt / other
		public var areaName:String = ''; 
		public var areaNo:String = '';
		public var areaID:String = '';
		
		public function AreaMarkerVO
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
		
		override public function clear():void 
		{
			super.clear();
			district = '';
			areaName = '';
			areaNo = '';
		}
		
	}

}