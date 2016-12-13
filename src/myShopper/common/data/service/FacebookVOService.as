package myShopper.common.data.service 
{
	import myShopper.common.data.facebook.FbFriendList;
	import myShopper.common.data.facebook.FbFriendVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FacebookVOService 
	{
		protected var _fbFdList:FbFriendList;
		
		public function FacebookVOService(inVO:FbFriendList) 
		{
			if (!(inVO is FbFriendList))
			{
				throw(new UninitializedError('UserVOService : unknown data type : ' + inVO));
			}
			
			
			_fbFdList = inVO;
		}
		
		
		public function setFbFriendList(inData:Object):Boolean
		{
			if (!(inData is Array) || !_fbFdList) return false;
			
			var arrFd:Array = inData as Array;
			var numItem:int = arrFd.length;
			
			_fbFdList.clear();
			
			for (var i:int = 0; i < numItem; i++)
			{
				var fdData:Object = arrFd[i];
				var fbVO:FbFriendVO = new FbFriendVO(fdData['id']);
				fbVO.name = fdData['name'];
				
				_fbFdList.addVO(fbVO);
			}
			
			return true;
		}
		
		
		
	}

}