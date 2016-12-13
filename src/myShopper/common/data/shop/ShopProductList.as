package myShopper.common.data.shop
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopProductList extends VOList
	{
		
		public function ShopProductList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopProductFormVO))
			{
				Tracer.echo('ShopProductList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function getVOByProductID(inID:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				if (ShopProductFormVO(arrVO[i]).productID == inID) return arrVO[i];
			}
			return null;
		}
		
		public function getVOByProductNo(inProductNo:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				if (ShopProductFormVO(arrVO[i]).productNo == inProductNo) return arrVO[i];
			}
			return null;
		}
	}

}