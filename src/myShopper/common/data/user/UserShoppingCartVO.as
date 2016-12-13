package myShopper.common.data.user 
{
	import myShopper.common.data.paypal.PaypalVO;
	import myShopper.common.data.service.ShopVOService;
	import myShopper.common.data.shop.ShopInfoVO;
	import myShopper.common.data.shop.ShopProductFormVO;
	import myShopper.common.data.shop.ShopProductList;
	import myShopper.common.data.VO;
	/**
	 * use shopID {hksp-xxxxxx} as this vo id
	 * shopping cart vo contains a list of product in a shop
	 * @author Toshi
	 */
	public class UserShoppingCartVO extends VO
	{
		//public var shopInfoVO:ShopInfoVO;
		public var shopNo:String; //sp-xxxxxx
		public var shopID:String; //uid
		public var shopName:String;
		public var shopCurrency:int;
		
		public function get numProduct():int 
		{ 
			return _productList ? _productList.length : 0; 
		}
		
		public function get totalPrice():Number 
		{ 
			var total:Number = 0;
			
			if (_productList)
			{
				var numItem:int = numProduct;
				
				for (var i:int = 0; i < numItem; i++)
				{
					var vo:UserShoppingCartProductVO = _productList.getVO(i) as UserShoppingCartProductVO;
					if (vo)
					{
						//total += ShopVOService.getDiscountedPrice(Number(vo.productPrice), vo.productDiscount) * vo.qty;
						total += vo.getPriceWithQTY();
					}
					
				}
				
				
			}
			
			return total;
		}
		
		//_productList id = product id
		protected var _productList:ShopProductList;
		public function get productList():ShopProductList { return _productList; }
		
		protected var _paypalResponse:PaypalVO;
		public function get paypalResponse():PaypalVO 
		{
			return _paypalResponse;
		}
		/**
		 * NOTE: this vo id should always use shopID {sp-xxxxxx} as this vo id, as it will be used for create invoice no
		 * @param	inVOID - shopID {sp-xxxxxx} as this vo id
		 */
		public function UserShoppingCartVO(inVOID:String/*, inShopInfoVO:ShopInfoVO = null*/) 
		{
			super(inVOID);
			//shopInfoVO = inShopInfoVO;
			_productList = new ShopProductList(inVOID);
			_paypalResponse = new PaypalVO(inVOID);
			shopNo = inVOID;
			shopID = shopName = '';
			shopCurrency = -1;
		}
		
		
		override public function clear():void
		{
			//shopInfoVO = null;
			_productList.clear();
		}
		
		
	}

}