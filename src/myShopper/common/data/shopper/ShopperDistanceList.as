package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperDistanceList extends VOList
	{
		
		public function ShopperDistanceList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperDistanceVO))
			{
				Tracer.echo('ShopperCategorList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		
		public function unselectAllVO():void
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				ShopperDistanceVO(arrVO[i]).isSelected = false;
			}
		}
		
		override public function clone():IVO 
		{
			var list:ShopperDistanceList = new ShopperDistanceList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperDistanceVO = _arrVO[i].clone() as ShopperDistanceVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}