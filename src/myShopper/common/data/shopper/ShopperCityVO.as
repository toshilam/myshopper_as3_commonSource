package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperCityVO extends VO
	{
		
		//No from DB, and will be used as VO ID
		public var cityNo:String;
		public var cityName:String;
		public var cityID:String;
		public var cityLat:Number;
		public var cityLng:Number;
		
		public var countryID:String;
		public var stateID:String;
		
		//used for defined whather this city should be shown on shopper main menu
		public var isActive:Boolean;
		
		protected var _areaList:ShopperAreaList;
		public function get areaList():ShopperAreaList { return _areaList; }
		public function set areaList(value:ShopperAreaList):void 
		{
			_areaList = value;
		}
		
		public function ShopperCityVO
		(
			inVOID:String,
			inCityNo:String = '', 
			inCityName:String = '',
			inCityID:String = '',
			inCityLat:Number = 0,
			inCityLng:Number = 0,
			inCountryID:String = '',
			inStateID:String = ''
		) 
		{
			super(inVOID);
			
			cityNo = inCityNo;
			cityName = inCityName;
			cityID = inCityID;
			cityLat = inCityLat;
			cityLng = inCityLng;
			
			countryID = inCountryID;
			stateID = inStateID;
			
			isActive = false;
			_areaList = new ShopperAreaList(_id);
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperCityVO = new ShopperCityVO
			(
				_id,
				cityNo,
				cityName,
				cityID,
				cityLat,
				cityLng,
				countryID,
				stateID
			);
			
			vo.areaList = _areaList.clone() as ShopperAreaList;
			return vo;
		}
		
		override public function clear():void
		{
			cityNo = '';
			cityName = '';
			cityID = '';
			countryID = '';
			stateID = '';
			cityLat = 0;
			cityLng = 0;
			isActive = false;
			_areaList.clear();
		}
	}

}