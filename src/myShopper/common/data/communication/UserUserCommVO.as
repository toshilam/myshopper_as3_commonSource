package myShopper.common.data.communication 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserUserCommVO extends CommVO 
	{
		public var isRead:Boolean;
		public var dateTime:String;
		public var no:String; //message no
		
		public function UserUserCommVO(inID:String, inType:String, inFromID:String, inData:Object=null, inFromUID:String='', inIsRead:Boolean = false, inDateTime:String = '', inNo:String = '') 
		{
			super(inID, inType, inFromID, inData, inFromUID);
			
			isRead = inIsRead;
			dateTime = inDateTime;
			no = inNo;
		}
		
	}

}