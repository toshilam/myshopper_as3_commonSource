package myShopper.common.data.shop 
{
	import myShopper.common.data.user.UserInfoVO;
	import myShopper.common.data.VO;
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * id = shopper_order.o_no
	 * @author Toshi Lam
	 */
	public class ShopOrderVO extends VO 
	{
		public var userInfoVO:UserInfoVO;
		
		//USED FOR USER ORDERING ONLINE
		public var payKey:String; //paypal paykey
		public var email:String; //the ordered user email / it can be different from userInfoVO if user change the email in order form while ordering 
		public var phone:String; //the ordered user phone / it can be different from userInfoVO if user change the phone in order form while ordering 
		public var address:String; //ship to
		public var remark:String; //remark from buyer
		
		//USED FOR SHOP SALES
		public var payMethod:String; //TODO : to be created by user
		public var paid:String; //total paid by customer
		
		
		public var orderNo:String; //db no 
		public var invoiceNo:String; //sp-xxxxxx-xxxxx-xxxx
		
		public var total:String; //total product price
		public var finalTotal:String; //total product price + extra + tax + shipping fee + any other
		public var shippingFee:String;
		public var shopCurrency:int; //used in shopMgt only
		public var dateTime:String; 
		public var timestamp:Number; 
		
		// NOT USED for the moment, as current shipping will only be handled by shop
		public var shippingMethod:String; //shipping method / 1 = ship by shopper / 2 = ship by shop / 3 = pos
		
		//public var txtShippingCompany:String; //remark from shop
		//public var txtShippingNo:String; //remark from shop
		public var shippingRemark:String; //remark from shop
		
		
		//contains UserShoppingCartProductVO
		protected var _productList:ShopProductList;
		public function get productList():ShopProductList { return _productList; }
		
		//contains a list of extra fee/discount/product
		protected var _extraList:VOList;
		public function get extraList():VOList { return _extraList; }
		
		private var _isRead:Boolean; //is this order already has been read / it is always read for SHOP SALES
		public function get isRead():Boolean {return _isRead;}
		public function set isRead(value:Boolean):void 
		{
			_isRead = value;
			dispatchChangeEvent('isRead', value);
		}
		
		//order status
		private var _status:String; 
		public function get status():String {return _status;}
		public function set status(value:String):void 
		{
			_status = value;
			dispatchChangeEvent('status', value);
		}
		
		private var _isDelete:Boolean;
		public function get isDelete():Boolean {return _isDelete;}
		public function set isDelete(value:Boolean):void 
		{
			_isDelete = value;
			dispatchChangeEvent('isDelete', value);
		}
		
		
		public function ShopOrderVO(inID:String) 
		{
			super(inID);
			userInfoVO = new UserInfoVO(inID);
			
			_productList = new ShopProductList(inID);
			_extraList = new VOList(inID);
		}
		
		/**
		 * 
		 * @param	inProductNo
		 * @return	-1 if not found, else index of the product vo in ShopProductList
		 */ 
		public function isProductExist(inProductNo:String):int
		{
			var numItem:int = _productList.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopProductFormVO = _productList.getVO(i) as ShopProductFormVO;
				if (vo && vo.productNo == inProductNo)
				{
					return i;
				}
			}
			
			return -1;
		}
		
		override public function clear():void 
		{
			super.clear();
			userInfoVO.clear();
			_productList.clear();
			_extraList.clear();
			
			//userInfoVO = null;
			//_productList = null;
			//_extraList = null;
			shopCurrency = -1;
			payKey = orderNo = invoiceNo = address = remark = shippingRemark = shippingMethod = status = total = shippingFee = dateTime = '';
			payMethod = paid = finalTotal = '';
			isDelete = false;
			//txtShippingCompany = txtShippingNo = '';
		}
		
	}

}