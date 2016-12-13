package myShopper.common.data.communication 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * comm vo list contains a user comm info
	 * id for this VOList would be the target user id (toID)
	 * @author Toshi Lam
	 */
	public class CommVOList extends VOList 
	{
		
		public function CommVOList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is CommVO)) 
			{
				Tracer.echo('ChatList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function getLastVOFromRequester():CommVO
		{
			var numItem:int = _arrVO.length;
			//from search from last
			for (var i:int = numItem - 1; i >= 0; i--)
			{
				var vo:CommVO = _arrVO[i] as CommVO;
				if (vo && vo.fromUID)
				{
					return vo;
				}
			}
			
			return null;
		}
	}

}