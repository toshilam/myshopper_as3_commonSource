package myShopper.common.data.shop 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopOrderList extends VOList 
	{
		//public var timeStamp:String; //last requested order data time from server / it used for getNewOrder
		
		public function ShopOrderList(inID:String) 
		{
			super(inID);
			//timeStamp = '';
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopOrderVO))
			{
				Tracer.echo('ShopOrderList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function get numUnReadOrder():int
		{
			var numUnRead:int = 0;
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopOrderVO = arrVO[i] as ShopOrderVO;
				if (vo)
				{
					if (!vo.isRead)
					{
						numUnRead++;
					}
				}
			}
			
			return numUnRead;
		}
	}

}