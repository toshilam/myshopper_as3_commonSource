package myShopper.common.data.shop
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopProductStockList extends VOList
	{
		protected var _numStock:int; //product stock - sold product
		public function get numStock():int { return _numStock; }
		public function set numStock(value:int):void 
		{
			_numStock = value;
			dispatchChangeEvent('numStock', _numStock);
		}
		
		public function ShopProductStockList(inID:String) 
		{
			super(inID);
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopProductStockVO))
			{
				Tracer.echo('ShopProductList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		override public function clone():IVO 
		{
			var nList:ShopProductStockList = new ShopProductStockList(id);
			var numItem:int = length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopProductStockVO = getVO(i) as ShopProductStockVO;
				if (vo)
				{
					nList.addVO( vo.clone() );
				}
			}
			
			return nList;
		}
		
		
		
	}

}