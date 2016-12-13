package myShopper.common.data.shop
{
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopInfoList extends VOList
	{
		
		public function ShopInfoList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is ShopInfoVO)) 
			{
				Tracer.echo('ShopInfoList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		/**
		 * 
		 * @param	inUID - user owner id
		 * @param	inSID - shop id sp-xxxxxx
		 * @return
		 */
		public function getVOByUID(inUID:String, inSID:String):IVO
		{
			if (inUID && inSID)
			{
				var numItem:int = arrVO.length;
				for (var i:uint = 0; i < numItem; i++)
				{
					var vo:ShopInfoVO = arrVO[i] as ShopInfoVO;
					if (vo.uid == inUID && vo.shopNo == inSID) return arrVO[i];
				}
			}
			
			
			return null;
		}
		
		/**
		 * 
		 * @param	inSID - shop id sp-xxxxxx
		 * @return
		 */
		/*public function getVOBySID(inSID:String):IVO
		{
			if (inSID)
			{
				var numItem:int = arrVO.length;
				for (var i:uint = 0; i < numItem; i++)
				{
					var vo:ShopInfoVO = arrVO[i] as ShopInfoVO;
					if (vo.shopNo == inSID) return arrVO[i];
				}
			}
			
			
			return null;
		}*/
		
	}

}