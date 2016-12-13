package myShopper.common.data.communication 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * comm list contains all the users comm between each user
	 * @author Toshi Lam
	 */
	public class CommList extends VOList 
	{
		
		public function CommList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is CommVOList)) 
			{
				Tracer.echo('ChatList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		/*public function getVOByFMSID(inFMSID:String):IVO
		{
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:CommVOList = _arrVO[i] as CommVOList;
				if (vo && vo.id == inFMSID)
				{
					return vo;
				}
			}
			return null;
		}*/
	}

}