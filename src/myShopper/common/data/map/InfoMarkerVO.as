package myShopper.common.data.map 
{
	import com.google.maps.InfoWindowOptions;
	import flash.display.DisplayObject;
	import myShopper.common.display.map.InfoWindow;
	
	/**
	 * info marker with infoWindow & window option
	 * @author Toshi
	 */
	public class InfoMarkerVO extends MarkerVO
	{
		public var infoWindow:InfoWindow;
		public var infoWindowOption:InfoWindowOptions;
		
		public function InfoMarkerVO(inVOID:String, inName:String = '', inLat:Number = 0, inLng:Number = 0, inIcon:DisplayObject = null, inMarkerType:String = '', inVisibleLevel:int = -1) 
		{
			super(inVOID, inName, inLat, inLng, inIcon, inMarkerType, inVisibleLevel);
			
		}
		
		override public function clear():void 
		{
			super.clear();
			
			infoWindow = null;
			infoWindowOption = null;
		}
	}

}