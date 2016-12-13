package myShopper.common.data.shopper 
{
	import myShopper.common.data.shop.ShopInfoList;
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperAreaVO extends VO implements ISelectableVO
	{
		private var _isSelected:Boolean;
		//No from DB, and will be used as VO ID
		public var areaNo:String;
		public var areaName:String;
		public var areaID:String;
		public var areaLat:Number;
		public var areaLng:Number;
		
		public var countryID:String;
		public var stateID:String;
		public var cityID:String;
		
		//a list of shop which are most popular in this area
		public var shopInfo:ShopInfoList; 
		
		
		public function ShopperAreaVO
		(
			inVOID:String,
			inAreaNo:String = '', 
			inAreaName:String = '',
			inAreaLat:Number = 0,
			inAreaLng:Number = 0,
			inCountryID:String = '',
			inCityID:String = '',
			inAreaID:String = '',
			inStateID:String = ''
		) 
		{
			super(inVOID);
			
			areaNo = inAreaNo;
			areaName = inAreaName;
			areaLat = inAreaLat;
			areaLng = inAreaLng;
			areaID = inAreaID;
			countryID = inCountryID;
			stateID = inStateID;
			cityID = inCityID;
			
			shopInfo = new ShopInfoList(inVOID);
			
			_isSelected =  false;
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperAreaVO = new ShopperAreaVO
			(
				_id,
				areaNo,
				areaName,
				areaLat,
				areaLng,
				countryID,
				cityID,
				areaID,
				stateID
			);
			
			vo.shopInfo = shopInfo.clone() as ShopInfoList;
			
			vo.isSelected = _isSelected;
			return vo;
		}
		
		override public function clear():void
		{
			areaNo = '';
			areaName = '';
			areaLat = 0;
			areaLng = 0;
			areaID = '';
			countryID = '';
			stateID = '';
			cityID = '';
			
			shopInfo.clear();
			
			_isSelected = false;
		}
		
		/* INTERFACE myShopper.common.interfaces.ISelectableVO */
		
		public function get isSelected():Boolean 
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void 
		{
			_isSelected = value;
		}
	}

}