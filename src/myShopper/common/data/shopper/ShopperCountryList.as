package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperCountryList extends VOList
	{
		//define whather all the active city and area data are downloaded
		private var _isDataDownloaded:Boolean;
		public function get isDataDownloaded():Boolean { return _isDataDownloaded; }
		public function set isDataDownloaded(value:Boolean):void 
		{
			_isDataDownloaded = value;
			dispatchChangeEvent('isDataDownloaded', value);
		}
		
		public function ShopperCountryList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperCountryVO))
			{
				Tracer.echo('ShopperCategorList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		/*public function getVOByCountryName(inName:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCountryVO(arrVO[i]).countryName == inName) return arrVO[i];
			}
			
			return null;
		}*/
		
		public function getVOByCountryID(inValue:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCountryVO(arrVO[i]).countryID == inValue) return arrVO[i];
			}
			
			return null;
		}
		
		public function getStateVOByID(inCountryID:String, inStateID:String):ShopperStateVO
		{
			var countryVO:ShopperCountryVO = getVOByCountryID(inCountryID) as ShopperCountryVO;
			if (countryVO)
			{
				return countryVO.stateList.getVOByStateID(inStateID) as ShopperStateVO;
				
			}
			
			return null;
		}
		
		public function getCityVOByID(inCountryID:String, inStateID:String, inCityID:String):ShopperCityVO
		{
			var stateVO:ShopperStateVO = getStateVOByID(inCountryID, inStateID) as ShopperStateVO;
			if (stateVO)
			{
				return stateVO.cityList.getVOByCityID(inCityID) as ShopperCityVO;
				
			}
			
			return null;
		}
		
		public function getAreaVOByName(inCountryID:String, inStateID:String, inCityID:String, inAreaName:String):ShopperAreaVO
		{
			var cityVO:ShopperCityVO = getCityVOByID(inCountryID, inStateID, inCityID);
			
			if (cityVO)
			{
				return cityVO.areaList.getVOByAreaName(inAreaName) as ShopperAreaVO;
			}
			
			return null;
		}
		
		/**
		 * a list of array contains active city which to be show in main menu
		 * may change in the future, category by country instead of city
		 * @return
		 */
		/*public function getActiveCityArray():Vector.<ShopperCityVO>
		{
			var arrActiveCity:Vector.<ShopperCityVO> = new Vector.<ShopperCityVO>();
			var numItem:int = _arrVO.length;
			
			for (var i:int = 0; i < numItem; i++)
			{
				var countryVO:ShopperCountryVO = _arrVO[i] as ShopperCountryVO;
				if (countryVO)
				{
					var numItem2:int = countryVO.cityList.length;
					for (var j:int = 0; j < numItem2; j++)
					{
						var cityVO:ShopperCityVO = countryVO.cityList.getVO(j) as ShopperCityVO;
						
						if (cityVO && cityVO.isActive)
						{
							arrActiveCity.push(cityVO);
						}
					}
				}
			}
			
			return arrActiveCity;
		}*/
		
		override public function clone():IVO 
		{
			var list:ShopperCountryList = new ShopperCountryList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperCountryVO = _arrVO[i].clone() as ShopperCountryVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
		
		
	}

}