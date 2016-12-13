package myShopper.common.data.communication 
{
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserUserCommVOList extends CommVOList 
	{
		//public var userName:String;
		//public var userID:String;
		//public var imageURL:String;
		private var _numUnRead:int;
		
		//to define whather we have already download chatting history from server
		public var hasDataDownloaded:Boolean;
		
		public function UserUserCommVOList(inID:String/*, inUserName:String = '', inUserID:String = '', inImageURL:String = ''*/) 
		{
			super(inID);
			//userName = inUserName;
			//imageURL = inImageURL;
			//userID = inUserID;
			
			hasDataDownloaded = false;
		}
		
		override public function clear():void 
		{
			super.clear();
			//userID = imageURL = userName = '';
			hasDataDownloaded = false;
			_numUnRead = 0;
		}
		
		public function clearVO():void
		{
			super.clear();
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is UserUserCommVO))
			{
				Tracer.echo('UserUserCommVOList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function get numUnRead():int 
		{
			return _numUnRead;
		}
		
		public function set numUnRead(value:int):void 
		{
			_numUnRead = value;
			dispatchChangeEvent('numUnRead', numUnRead);
		}
		
	}

}