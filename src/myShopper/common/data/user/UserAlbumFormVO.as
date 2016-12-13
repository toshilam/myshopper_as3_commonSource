package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserAlbumFormVO extends VO
	{
		//album info
		public var albumName:String;
		public var isPrivate:Boolean;
		public var createDateTime:String;
		public var albumNo:String;
		//albumURL = URL + albumName with no space
		public var albumURL:String;
		public var numberOfPhoto:uint;
		
		protected var _photoList:UserPhotoList;
		public function get photoList():UserPhotoList { return _photoList; }
		
		public function UserAlbumFormVO
		(
			inVOID:String,
			inAlbumName:String = '', 
			inIsPrivate:Boolean = false,
			inAlbumNo:String = '',
			inCreateDateTime:String = '',
			inAlbumURL:String = '',
			inNumberOfPhoto:uint = 0
		) 
		{
			super(inVOID);
			
			albumName = inAlbumName;
			isPrivate = inIsPrivate;
			createDateTime = inCreateDateTime;
			albumNo = inAlbumNo;
			albumURL = inAlbumURL;
			numberOfPhoto = inNumberOfPhoto;
			
			_photoList = new UserPhotoList(inVOID);
		}
		
		override public function clear():void
		{
			albumName = '';
			isPrivate = false;
			createDateTime = '';
			albumNo = '';
			albumURL = '';
			numberOfPhoto = 0;
		}
		
	}

}