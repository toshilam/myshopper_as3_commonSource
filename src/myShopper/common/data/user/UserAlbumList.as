package myShopper.common.data.user
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserAlbumList extends VOList
	{
		
		public function UserAlbumList(inID:String) 
		{
			super(inID);
			
		}
		
		public function getVOByAlbumName(inName:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (UserAlbumFormVO(arrVO[i]).albumName == inName) return arrVO[i];
			}
			
			return null;
		}
		
		public function getVOByAlbumNo(inCategoryNo:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (UserAlbumFormVO(arrVO[i]).albumNo == inCategoryNo) return arrVO[i];
			}
			
			return null;
		}
	}

}