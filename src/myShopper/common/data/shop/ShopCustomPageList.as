package myShopper.common.data.shop
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopCustomPageList extends VOList
	{
		
		public function ShopCustomPageList(inID:String) 
		{
			super(inID);
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopCustomPageVO)) 
			{
				Tracer.echo('ShopCustomPageList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function getVOByPageNo(inValue:String):ShopCustomPageVO
		{
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopCustomPageVO = _arrVO[i] as ShopCustomPageVO;
				if (vo && vo.pageNo == inValue)
				{
					return vo;
				}
			}
			
			return null;
		}
		
		public function getVOByPageID(inValue:String):ShopCustomPageVO
		{
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopCustomPageVO = _arrVO[i] as ShopCustomPageVO;
				if (vo && vo.pageID == inValue)
				{
					return vo;
				}
			}
			
			return null;
		}
		
	}

}