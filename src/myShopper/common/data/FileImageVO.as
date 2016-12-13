package myShopper.common.data 
{
	import flash.utils.ByteArray;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class FileImageVO extends VO
	{
		//type of image (e.g. jpg, png, gif)
		public var type:String;
		//image data
		private var _data:ByteArray;
		public function get data():ByteArray 
		{
			return _data;
		}
		
		public function set data(value:ByteArray):void 
		{
			_data = value;
			dispatchChangeEvent('data', data);
		}
		
		//name of image
		public var name:String;
		//image size in byte
		public var size:String;
		//which part of this image to be use
		public var path:String;
		//user ID == shop ID
		public var userID:String;
		//photo url, formet : userID/photoPath/XX.img
		public var url:String;
		//can be assign anything, for the BG case, it will be used for image postion type
		public var extra:Object;
		//index for an object has more than one image
		public var index:int;
		
		
		public function FileImageVO(inVOID:String, inData:ByteArray = null, inName:String = '', inType:String = '', inSize:String = '', inPath:String = '', inUserID:String = '', inURL:String = '', inExtra:Object = null, inIndex:int = 0) 
		{
			super(inVOID);
			
			type = inType;
			data = inData;
			name = inName;
			size = inSize;
			path = inPath;
			userID = inUserID;
			url = inURL;
			extra = inExtra;
			index = inIndex;
		}
		
		override public function clone():IVO 
		{
			return new FileImageVO(_id, data, name, type, size, path, userID, url, extra, index);
		}
		
		
		override public function clear():void
		{
			type = '';
			data = null;
			name = '';
			size = '';
			path = '';
			url = '';
			extra = null;
			index = 0;
		}
		
		
	}

}