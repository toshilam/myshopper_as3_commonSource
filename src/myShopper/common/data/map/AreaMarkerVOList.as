package myShopper.common.data.map 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class AreaMarkerVOList extends VOList 
	{
		
		public function AreaMarkerVOList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is AreaMarkerVO))
			{
				Tracer.echo('AreaMarkerVOList : addVO : unknown data type!');
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function getVOByAreaNo(inNo:String):AreaMarkerVO
		{
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var aVO:AreaMarkerVO = _arrVO[i] as AreaMarkerVO;
				if (aVO && aVO.areaNo == inNo)
				{
					return aVO;
				}
			}
			
			return null;
		}
	}

}