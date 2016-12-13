package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.events.ApplicationEvent;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class GoogleMapEvent extends ApplicationEvent 
	{
		private static const NAME:String = 'GoogleMapEvent';
		
		//public static const GET_DISTRICTS:String = NAME + 'getDistricts';
		public static const GET_AREAS:String = NAME + 'getAreas';
		public static const GET_SHOPS_BY_AREA:String = NAME + 'getShopsByArea';
		public static const GET_HOT_SHOPS_BY_AREA:String = NAME + 'getHotShopsByArea';
		public static const GET_SHOPS_BY_LATLNG_BOUND:String = NAME + 'getShopsByLatLngBound';
		
		public static const MARKER_ROLL_OVER:String = NAME + 'markerRollOver';
		public static const MARKER_ROLL_OUT:String = NAME + 'markerRollOut';
		public static const MARKER_CLICK:String = NAME + 'markerClick';
		public static const MARKER_DRAG_START:String = NAME + 'markerDragStart';
		public static const MARKER_DRAG_END:String = NAME + 'markerDragEnd';
		
		public static const CLEARED_ALL_MARKERS:String = NAME + 'clearedAllMarkers'; //to be dispatched once clearOverLays is being called
		
		public static const CLOSE_INFO_WINDOW:String = NAME + 'closeInfoWindow';
		public static const MORE_INFO:String = NAME + 'moreInfo';
		
		public static const UPDATE_LAT_LNG:String = NAME + 'updateLatLng';
		
		public static const RESULT_GEOCODING:String = NAME + 'resultGeocoding';
		
		private var _targetMapObject:Object;
		public function get targetMapObject():Object { return _targetMapObject; }
		
		public function GoogleMapEvent(type:String, inTargetDisplayObject:DisplayObject = null, inData:Object = null, inMapObject:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, inTargetDisplayObject, inData, bubbles, cancelable);
			_targetMapObject = inMapObject;
		} 
		
		public override function clone():Event 
		{ 
			return new GoogleMapEvent(type, _targetDisplayObject, _data, _targetMapObject, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GoogleMapEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}