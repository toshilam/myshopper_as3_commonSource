package myShopper.common.data.facebook 
{
	import myShopper.common.data.shop.ShopProductFormVO;
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FbShareProductVO extends VO 
	{
		public var fdList:FbFriendList; 
		public var product:ShopProductFormVO;
		public var message:String;
		
		public function FbShareProductVO(inID:String) 
		{
			super(inID);
			message = '';
			fdList = new FbFriendList(inID);
		}
		
		
		override public function clear():void 
		{
			fdList.clear();
			fdList = null;
			product = null;
			message = null;
		}
	}

}