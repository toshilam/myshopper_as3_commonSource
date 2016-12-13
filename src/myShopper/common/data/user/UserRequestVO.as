package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserRequestVO extends VO
	{
		//RequestType
		public var type:String;
		//the request maker id (uid)
		public var fromUID:String;
		public var toUID:String;
		public var data:Object;
		
		//userd by response
		private var _isAccept:Boolean;
		
		public function UserRequestVO(inFromUID:String, inToUID:String, inType:String, inData:Object = null) 
		{
			super(inFromUID);
			type = inType;
			data = inData;
			toUID = inToUID;
			fromUID = inFromUID;
		}
		
		override public function clear():void 
		{
			toUID = '';
			fromUID = '';
			type = '';
			data = null;
		}
		
		override public function clone():IVO 
		{
			return new UserRequestVO(fromUID, toUID, type, data);
		}
		
		public function get isAccept():Boolean 
		{
			return _isAccept;
		}
		
		public function set isAccept(value:Boolean):void 
		{
			_isAccept = value;
			dispatchChangeEvent('isAccept', isAccept);
		}
	}

}