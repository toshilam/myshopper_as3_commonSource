package myShopper.common.data.map
{
	import com.google.maps.InfoWindowOptions;
	import flash.display.DisplayObject;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class DistrictMarkerVO extends InfoMarkerVO
	{
		public var url:String;
		
		public function DistrictMarkerVO
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
		
		override public function clear():void 
		{
			super.clear();
			url = '';
		}
		
		override public function clone():IVO 
		{
			var vo:DistrictMarkerVO = super.clone() as DistrictMarkerVO;
			vo.url = url;
			return vo;
			
		}
	}

}