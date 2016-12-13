package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperAreaList extends VOList
	{
		//define whather all the active city and area data are downloaded
		private var _isDataDownloaded:Boolean;
		public function get isDataDownloaded():Boolean { return _isDataDownloaded; }
		public function set isDataDownloaded(value:Boolean):void 
		{
			_isDataDownloaded = value;
			dispatchChangeEvent('isDataDownloaded', value);
		}
		
		public function ShopperAreaList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperAreaVO))
			{
				Tracer.echo('ShopperCategorList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function getVOByAreaID(inID:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperAreaVO(arrVO[i]).areaID == inID) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByAreaName(inName:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperAreaVO(arrVO[i]).areaName == inName) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByAreaNo(inNo:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperAreaVO(arrVO[i]).areaNo == inNo) return arrVO[i];
			}
			
			return null;
		}
		
		public function unselectAllVO():void
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				ShopperAreaVO(arrVO[i]).isSelected = false;
			}
		}
		
		override public function clone():IVO 
		{
			var list:ShopperAreaList = new ShopperAreaList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperAreaVO = _arrVO[i].clone() as ShopperAreaVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}