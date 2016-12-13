package myShopper.common.data.user 
{
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserCommentShopVO extends VO 
	{
		public var rate:String; // -1 = bad, 0 = ok, 1 = good
		public var message:String;
		
		
		public function UserCommentShopVO(inID:String, inRating:String = '0', inMessage:String = '') 
		{
			super(inID);
			
			rate = inRating;
			message = inMessage;
		}
		
		override public function clear():void 
		{
			super.clear();
			rate = message= '';
		}
		
		/*override public function clone():IVO 
		{
			return UserCheckOutVO(_id, email, phone, address, note, product);
		}*/
	}

}