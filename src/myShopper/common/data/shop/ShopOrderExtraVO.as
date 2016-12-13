package myShopper.common.data.shop 
{
	
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * extra fee/discount for eacho order
	 * @author Toshi Lam
	 */
	public class ShopOrderExtraVO extends VO 
	{
		public var name:String;
		public var type:String; //1 = fee / 2 discount / 3 other
		public var total:Number;
		
		public function ShopOrderExtraVO(inID:String, inName:String = '', inType:String = '-1', inTotal:Number = 0) 
		{
			super(inID);
			name = inName;
			type = inType;
			total = inTotal;
		}
		
		
		override public function clear():void 
		{
			super.clear();
			
		}
		
		
	}

}