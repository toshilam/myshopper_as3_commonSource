package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperStateVO extends VO
	{
		
		//No from DB, and will be used as VO ID
		public var stateNo:String;
		public var stateName:String;
		public var stateID:String;
		public var stateLat:Number;
		public var stateLng:Number;
		
		public var countryID:String;
		
		
		protected var _cityList:ShopperCityList;
		public function get cityList():ShopperCityList { return _cityList; }
		public function set cityList(value:ShopperCityList):void 
		{
			_cityList = value;
		}
		
		public function ShopperStateVO
		(
			inVOID:String,
			inStateNo:String = '', 
			inStateName:String = '',
			inStateID:String = '',
			inStateLat:Number = 0,
			inStateLng:Number = 0,
			inCountryID:String = ''
		) 
		{
			super(inVOID);
			
			stateNo = inStateNo;
			stateName = inStateName;
			stateID = inStateID;
			stateLat = inStateLat;
			stateLng = inStateLng;
			
			countryID = inCountryID;
			
			_cityList = new ShopperCityList(_id);
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperStateVO = new ShopperStateVO
			(
				_id,
				stateNo,
				stateName,
				stateID,
				stateLat,
				stateLng,
				countryID
			);
			
			vo.cityList = _cityList.clone() as ShopperCityList;
			return vo;
		}
		
		override public function clear():void
		{
			stateNo = '';
			stateName = '';
			stateID = '';
			stateID = '';
			stateLat = 0;
			stateLng = 0;
			_cityList.clear();
		}
	}

}