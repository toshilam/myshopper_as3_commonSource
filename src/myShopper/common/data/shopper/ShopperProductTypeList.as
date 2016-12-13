package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperProductTypeList extends VOList
	{
		
		public function ShopperProductTypeList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperProductTypeVO))
			{
				Tracer.echo('ShopperProductTypeList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		
		public function getVOByProductTypeNo(inProductTypeNo:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				if (ShopperProductTypeVO(arrVO[i]).productTypeNo == inProductTypeNo) return arrVO[i];
			}
			
			return null;
		}
		
		override public function clone():IVO 
		{
			var list:ShopperProductTypeList = new ShopperProductTypeList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperProductTypeVO = _arrVO[i].clone() as ShopperProductTypeVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}