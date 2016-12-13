package myShopper.common.data.user 
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserPhotoFormVO extends VO
	{
		//login info
		//No from DB, and will be used as VO ID
		public var photoNo:String;
		//ID will be defined by user, and use it for URL
		public var photoID:String;
		
		//public var photoName:String;
		public var photoDescription:String;
		public var photoAlbumNo:String;
		public var photoDateTime:String;
		public var photoURL:String;
		public var photoAlbumName:String;
		
		public var photoFileVO:FileImageVO = null;
		
		public function UserPhotoFormVO
		(
			inVOID:String,
			inPhotoNo:String = '', 
			inPhotoID:String = '', 
			//inPhotoName:String = '', 
			inPhotoDescription:String = '', 
			inPhotoAlbumNo:String = '',
			inPhotoDateTime:String = '',
			inPhotoURL:String = '',
			inPhotoAlbumName:String = ''
		) 
		{
			super(inVOID);
			
			photoNo = inPhotoNo;
			photoID = inPhotoID;
			//photoName = inPhotoName;
			photoDescription = inPhotoDescription;
			photoAlbumNo = inPhotoAlbumNo;
			photoDateTime = inPhotoDateTime;
			photoURL = inPhotoURL;
			photoAlbumName = inPhotoAlbumName;
			
			photoFileVO = new FileImageVO(_id);
		}
		
		override public function clone():IVO 
		{
			var vo:UserPhotoFormVO = new UserPhotoFormVO
			(
				_id,
				photoNo,
				photoID,
				//photoName,
				photoDescription,
				photoAlbumNo,
				photoDateTime,
				photoURL,
				photoAlbumName
			);
			
			vo.photoFileVO = photoFileVO.clone() as FileImageVO;
			return vo;
		}
		
		override public function clear():void
		{
			photoNo = '';
			photoID = '';
			//photoName = '';
			photoDescription = '';
			photoAlbumNo = '';
			photoAlbumName = '';
			photoDateTime = '';
			photoURL = '';
			
			photoFileVO.clear();
		}
	}

}