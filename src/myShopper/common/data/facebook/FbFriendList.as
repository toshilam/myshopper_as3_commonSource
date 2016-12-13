package myShopper.common.data.facebook 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FbFriendList extends VOList 
	{
		
		public function FbFriendList(inID:String) 
		{
			super(inID);
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is FbFriendVO))
			{
				Tracer.echo('FbFriendList : addVO : unknwon data type : ' + inVO);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		override public function clone():IVO 
		{
			var fdList:FbFriendList = new FbFriendList(_id);
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:FbFriendVO = _arrVO[i].clone() as FbFriendVO;
				
				fdList.addVO(vo);
			}
			
			return fdList;
		}
	}

}