package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperCityList extends VOList
	{
		//define whather all the active city and area data are downloaded
		private var _isDataDownloaded:Boolean;
		public function get isDataDownloaded():Boolean { return _isDataDownloaded; }
		public function set isDataDownloaded(value:Boolean):void 
		{
			_isDataDownloaded = value;
			dispatchChangeEvent('isDataDownloaded', value);
		}
		
		public function ShopperCityList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperCityVO))
			{
				Tracer.echo('ShopperCategorList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		/*public function getVOByCityName(inName:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCityVO(arrVO[i]).cityName == inName) return arrVO[i];
			}
			
			return null;
		}*/
		
		public function getVOByCityID(inValue:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCityVO(arrVO[i]).cityID == inValue) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByCityNo(inNo:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCityVO(arrVO[i]).cityNo == inNo) return arrVO[i];
			}
			
			return null;
		}
		
		override public function clone():IVO 
		{
			var list:ShopperCityList = new ShopperCityList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperCityVO = _arrVO[i].clone() as ShopperCityVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}