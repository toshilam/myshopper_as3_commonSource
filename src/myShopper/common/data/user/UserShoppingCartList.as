package myShopper.common.data.user 
{
	import myShopper.common.data.shop.ShopInfoVO;
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserShoppingCartList extends VOList
	{
		//vo id = sp-xxxxxx
		public function UserShoppingCartList(inVOID:String) 
		{
			super(inVOID);
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is UserShoppingCartVO))
			{
				Tracer.echo('UserShoppingCartList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		//sp-xxxxxx
		public function getVOByShopNo(inData:String):IVO
		{
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:UserShoppingCartVO = _arrVO[i] as UserShoppingCartVO;
				if (vo)
				{
					if (vo.id == inData)
					{
						return vo;
					}
				}
				
			}
			
			return null;
		}
		
		/*public function getVOByShopInfoVO(inVO:ShopInfoVO):IVO
		{
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:UserShoppingCartVO = _arrVO[i] as UserShoppingCartVO;
				if (vo)
				{
					if (vo.shopInfoVO === inVO)
					{
						return vo;
					}
				}
				
			}
			
			return null;
		}*/
	}

}