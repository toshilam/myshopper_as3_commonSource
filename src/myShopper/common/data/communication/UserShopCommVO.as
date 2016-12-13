package myShopper.common.data.communication 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShopCommVO extends CommVO 
	{
		public var isRead:Boolean;
		public var dateTime:String;
		public var isShop:Boolean;
		public var no:String; //message no
		
		public function UserShopCommVO(inID:String, inType:String, inFromID:String, inData:Object=null, inFromUID:String='', inIsRead:Boolean = false, inIsShop:Boolean = false, inDateTime:String = '', inNo:String = '') 
		{
			super(inID, inType, inFromID, inData, inFromUID);
			
			isRead = inIsRead;
			dateTime = inDateTime;
			isShop = inIsShop;
			no = inNo;
		}
		
	}

}