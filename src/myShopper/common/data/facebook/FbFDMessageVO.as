package myShopper.common.data.facebook 
{
	import myShopper.common.data.shop.ShopProductFormVO;
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FbFDMessageVO extends VO 
	{
		public var fdVO:FbFriendVO; 
		public var message:String;
		
		public function FbFDMessageVO(inID:String) 
		{
			super(inID);
			message = '';
		}
		
		
		override public function clear():void 
		{
			fdVO = null;
			message = null;
		}
	}

}