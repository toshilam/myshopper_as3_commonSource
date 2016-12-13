package myShopper.common.data.map 
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.overlays.MarkerOptions;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import myShopper.common.data.VO;
	import myShopper.common.events.VOEvent;
	/**
	 * ...
	 * @author Toshi
	 */
	public class MarkerVO extends VO
	{
		private var _name:String;
		private var _lat:Number;
		private var _lng:Number;
		private var _icon:DisplayObject;
		private var _markerType:String;
		private var _visibleLevel:int;
		
		private var _latLng:LatLng;
		private var _markerOption:MarkerOptions;
		
		public var initScaleSize:Number; //for scale marker icon when zoom in out
		public var initW:Number; //for position marker icon when zoom in out
		public var initH:Number; //for position marker icon when zoom in out
		public var initPoint:Point; //for position marker icon when zoom in out
		
		//this can be assign anything for specify case
		private var _extra:Object;
		
		public function MarkerVO(inVOID:String, inName:String = '', inLat:Number = 0, inLng:Number = 0, inIcon:DisplayObject = null, inMarkerType:String = '', inVisibleLevel:int = -1) 
		{
			super(inVOID);
			
			_name = inName;
			_lat = inLat;
			_lng = inLng;
			_icon = inIcon;
			_markerType = inMarkerType;
			_visibleLevel = inVisibleLevel;
			
			initH = initW = initScaleSize = -1;
			/*latLng = new LatLng(lat, lng);
			markerOption = new MarkerOptions
			({ 
				tooltip:name,
				icon:icon,
				hasShadow:false
			});
			
			Tracer.echo(latLng);
			Tracer.echo(markerOption);*/
		}
		
		
		
		override public function clear():void
		{
			_name = '';
			_lat = 0;
			_lng = 0;
			_icon = null;
			_markerType = '';
			_visibleLevel = -1;
			
			_latLng = null;
			_markerOption = null;
			
			_extra = null;
			
			initH = initW = initScaleSize = -1;
			initPoint = null;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
			dispatchChangeEvent('name', _name);
		}
		
		public function get lat():Number 
		{
			return _lat;
		}
		
		public function set lat(value:Number):void 
		{
			_lat = value;
			dispatchChangeEvent('lat', _lat);
		}
		
		public function get lng():Number 
		{
			return _lng;
		}
		
		public function set lng(value:Number):void 
		{
			_lng = value;
			dispatchChangeEvent('lng', _lng);
		}
		
		public function get icon():DisplayObject 
		{
			return _icon;
		}
		
		public function set icon(value:DisplayObject):void 
		{
			_icon = value;
			dispatchChangeEvent('icon', _icon);
		}
		
		public function get markerType():String 
		{
			return _markerType;
		}
		
		public function set markerType(value:String):void 
		{
			_markerType = value;
			dispatchChangeEvent('markerType', _markerType);
		}
		
		public function get visibleLevel():int 
		{
			return _visibleLevel;
		}
		
		public function set visibleLevel(value:int):void 
		{
			_visibleLevel = value;
			dispatchChangeEvent('visibleLevel', _visibleLevel);
		}
		
		public function get latLng():LatLng 
		{
			return _latLng;
		}
		
		public function set latLng(value:LatLng):void 
		{
			_latLng = value;
			dispatchChangeEvent('latLng', _latLng);
		}
		
		public function get markerOption():MarkerOptions 
		{
			return _markerOption;
		}
		
		public function set markerOption(value:MarkerOptions):void 
		{
			_markerOption = value;
			dispatchChangeEvent('markerOption', _markerOption);
		}
		
		public function get extra():Object 
		{
			return _extra;
		}
		
		public function set extra(value:Object):void 
		{
			_extra = value;
			dispatchChangeEvent('extra', _extra);
		}
		
		
	}

}