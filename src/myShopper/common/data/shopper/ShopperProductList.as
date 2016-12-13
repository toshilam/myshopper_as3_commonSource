package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperProductList extends VOList
	{
		
		public function ShopperProductList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperProductVO))
			{
				Tracer.echo('ShopProductList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		
		public function getVOByProductNo(inProductNo:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				if (ShopperProductVO(arrVO[i]).productNo == inProductNo) return arrVO[i];
			}
			
			return null;
		}
		
		override public function clone():IVO 
		{
			var list:ShopperProductList = new ShopperProductList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperProductVO = _arrVO[i].clone() as ShopperProductVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}