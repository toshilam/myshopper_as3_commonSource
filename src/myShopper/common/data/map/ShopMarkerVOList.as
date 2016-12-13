package myShopper.common.data.map 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopMarkerVOList extends VOList 
	{
		
		public function ShopMarkerVOList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopMarkerVO))
			{
				Tracer.echo('ShopMarkerVOList : addVO : unknown data type!');
				return 0;
			}
			
			var newVO:ShopMarkerVO = inVO as ShopMarkerVO;
			
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopMarkerVO = _arrVO[i] as ShopMarkerVO;
				if (vo.uid == newVO.uid)
				{
					Tracer.echo('ShopMarkerVOList : addVO : vo exist! same id of vo found!');
					return 0;
				}
			}
			
			return super.addVO(inVO);
		}
		
	}

}