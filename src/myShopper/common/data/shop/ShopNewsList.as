package myShopper.common.data.shop 
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopNewsList extends VOList 
	{
		
		public function ShopNewsList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopNewsVO))
			{
				Tracer.echo('ShopNewsList : addVO : unknown data type : ' + inVO);
				return 0;
			}
			
			return super.addVO(inVO);
		}
	}

}