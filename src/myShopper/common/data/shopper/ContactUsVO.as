package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ContactUsVO extends VO
	{
		public var name:String;
		public var mail:String;
		public var subject:String;
		public var message:String;
		
		public function ContactUsVO(inVOID:String) 
		{
			super(inVOID);
			clear();
		}
		
		override public function clear():void
		{
			name = '';
			mail = '';
			subject = '';
			message = '';
			
		}
	}

}