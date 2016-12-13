package myShopper.common.display.map 
{
	import com.google.maps.LatLng;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.interfaces.IDataDisplayObject;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * base info window object
	 * @author Toshi
	 */
	public class InfoWindow extends ApplicationDisplayObject implements IDataDisplayObject
	{
		//to indecate which area/district is
		/*protected var _id:String;
		public function get id():String { return _id; }
		
		public function set id(value:String):void 
		{
			_id = value;
		}*/
		
		/*protected var _url:String;
		public function get url():String { return _url; }
		
		public function set url(value:String):void 
		{
			_url = value.toLowerCase();
		}
		
		//lat lng related to marker object (not this info window itself)
		protected var _latlng:LatLng;
		public function get latlng():LatLng { return _latlng; }
		
		public function set latlng(value:LatLng):void 
		{
			_latlng = value;
		}*/
		
		protected var _vo:IVO;
		public function get vo():IVO 
		{
			return _vo;
		}
		
		public function InfoWindow() 
		{
			super();
			
		}
		
		
		
		
		public function setInfo(inData:IVO):Boolean 
		{
			_vo = inData;
			return true;
		}
		
		public function updateInfo():Boolean 
		{
			return false;
		}
		
	}

}