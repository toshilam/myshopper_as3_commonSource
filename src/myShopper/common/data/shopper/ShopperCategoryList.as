package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperCategoryList extends VOList
	{
		
		public function ShopperCategoryList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperCategoryVO))
			{
				Tracer.echo('ShopperCategorList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function getVOByCategoryName(inName:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCategoryVO(arrVO[i]).categoryName == inName) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByCategoryNo(inCategoryNo:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCategoryVO(arrVO[i]).categoryNo == inCategoryNo) return arrVO[i];
			}
			
			return null;
		}
		
		public function unselectAllVO():void
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				ShopperCategoryVO(arrVO[i]).isSelected = false;
			}
		}
		
		public function getNumSelected():int
		{
			var numSelected:int = 0;
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperCategoryVO(arrVO[i]).isSelected == true)
				{
					numSelected++;
				}
			}
			
			return numSelected;
		}
		
		override public function clone():IVO 
		{
			var list:ShopperCategoryList = new ShopperCategoryList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperCategoryVO = _arrVO[i].clone() as ShopperCategoryVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}