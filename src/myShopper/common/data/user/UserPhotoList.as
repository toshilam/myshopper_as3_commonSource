package myShopper.common.data.user
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserPhotoList extends VOList
	{
		
		public function UserPhotoList(inID:String) 
		{
			super(inID);
			
		}
		
		public function getVOByPhotoID(inID:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				if (UserPhotoFormVO(arrVO[i]).photoID == inID) return arrVO[i];
			}
			return null;
		}
		
		public function getVOByPhotoNo(inPhotoNo:String):IVO
		{
			for (var i:int = 0; i < arrVO.length; i++)
			{
				if (UserPhotoFormVO(arrVO[i]).photoNo == inPhotoNo) return arrVO[i];
			}
			return null;
		}
	}

}