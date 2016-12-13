package myShopper.common.data.shop 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopNewsVO extends VO 
	{
		//id = n_no
		public var date:String;
		public var title:String;
		public var content:String;
		
		public function ShopNewsVO(inID:String = '', inTitle:String = '', inContent:String = '', inDate:String = '') 
		{
			super(inID);
			date = inDate;
			title = inTitle;
			content = inContent;
		}
		
		override public function clear():void 
		{
			content = title = date = '';
		}
		
		override public function clone():IVO 
		{
			return new ShopNewsVO(id, title, content, date);
		}
	}

}