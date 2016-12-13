package myShopper.common.data.shop
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopCategoryList extends VOList
	{
		
		public function ShopCategoryList(inID:String) 
		{
			super(inID);
			
		}
		
		public function getVOByCategoryName(inName:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopCategoryFormVO(arrVO[i]).categoryName == inName) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByCategoryNo(inCategoryNo:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopCategoryFormVO(arrVO[i]).categoryNo == inCategoryNo) return arrVO[i];
			}
			
			return null;
		}
	}

}