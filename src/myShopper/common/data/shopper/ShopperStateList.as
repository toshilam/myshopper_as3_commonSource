package myShopper.common.data.shopper
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperStateList extends VOList
	{
		
		public function ShopperStateList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopperStateVO))
			{
				Tracer.echo('ShopperCategorList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		
		public function getVOByStateID(inValue:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperStateVO(arrVO[i]).stateID == inValue) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByStateNo(inNo:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (ShopperStateVO(arrVO[i]).stateNo == inNo) return arrVO[i];
			}
			
			return null;
		}
		
		override public function clone():IVO 
		{
			var list:ShopperStateList = new ShopperStateList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:ShopperStateVO = _arrVO[i].clone() as ShopperStateVO;
				
				if (vo)
				{
					list.addVO(vo);
				}
			}
			
			return list;
		}
	}

}