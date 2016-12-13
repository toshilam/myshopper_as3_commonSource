package myShopper.common.data.shop 
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.service.ShopVOService;
	import myShopper.common.data.VO;
	import myShopper.common.data.VOList;
	import myShopper.common.emun.FileType;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopProductFormVO extends VO
	{
		public static const NUM_PHOTO:int = 3;
		//login info
		//No from DB, and will be used as VO ID
		public var productNo:String;
		//ID will be defined by user, and use it for URL
		public var productID:String;
		private var _productFBID:String; //fb id if product has shared by shop, else null
		
		private var _productName:String;
		private var _productDescription:String;
		public var productPrice:String;
		public var productCurrency:String;
		public var productCategoryNo:String;
		public var productDateTime:String;
		public var productURL:String;
		public var productUnit:String;
		
		//add 20/05/2011 for shopProductDisplayObject 
		public var productCategoryName:String;
		
		//add 07082012
		public var productDiscount:int; //discount percentage
		
		//add 08122013 a list of product stock vo
		public var productStock:ShopProductStockList;
		
		//add 12042014
		public var productTax:String; //tax percentage
		
		//public var photoFileVO:FileImageVO = null;
		public var photoList:VOList = null;
		
		public var shopperCategoryNo:String;
		public var shopperProductNo:String;
		public var shopperProductTypeNo:String;
		
		public function ShopProductFormVO
		(
			inVOID:String,
			inProductNo:String = '', 
			inProductID:String = '', 
			inProductName:String = '', 
			inProductPrice:String = '', 
			inProductDescription:String = '', 
			inProductCurrency:String = '', 
			inProductCategoryNo:String = '',
			inProductDateTime:String = '',
			inProductURL:String = '',
			inProductCategoryName:String = '',
			inShopperCategoryNo:String = '',
			inShopperProductNo:String = '',
			inProductFBID:String = '',
			inShopperProductTypeNo:String = '',
			inDiscount:int = 0,
			inProductUnit:String = '',
			inProductTax:String = ''
		) 
		{
			super(inVOID);
			
			productNo = inProductNo;
			productID = inProductID;
			productFBID = inProductFBID;
			productName = inProductName;
			productPrice = inProductPrice;
			productDescription = inProductDescription;
			productCurrency = inProductCurrency;
			productCategoryNo = inProductCategoryNo;
			productDateTime = inProductDateTime;
			productURL = inProductURL;
			productCategoryName = inProductCategoryName;
			productUnit = inProductUnit;
			
			shopperCategoryNo = inShopperCategoryNo;
			shopperProductNo = inShopperProductNo;
			shopperProductTypeNo = inShopperProductTypeNo;
			
			productDiscount = inDiscount;
			productStock = new ShopProductStockList(inVOID);
			productTax = inProductTax;
			
			//allowed 3 photo in each product
			photoList = new VOList(inVOID);
			for (var i:int = 0; i < NUM_PHOTO; i++)
			{
				var photoFileVO:FileImageVO = new FileImageVO(i.toString());
				photoFileVO.path = FileType.PATH_SHOP_PRODUCT;
				photoFileVO.index = i;
				photoList.addVO(photoFileVO);
			}
		}
		
		public function getPhotoVO(inIndex:int = 0):FileImageVO
		{
			return photoList.getVO(inIndex) as FileImageVO;
		}
		
		
		override public function clone():IVO 
		{
			var vo:ShopProductFormVO = new ShopProductFormVO
			(
				_id,
				productNo,
				productName,
				productName,
				productPrice,
				productDescription,
				productCurrency,
				productCategoryNo,
				productDateTime,
				productURL,
				productCategoryName,
				shopperCategoryNo,
				shopperProductNo,
				productFBID,
				shopperProductTypeNo,
				productDiscount,
				productUnit,
				productTax
			);
			
			//vo.photoFileVO = photoFileVO.clone() as FileImageVO;
			vo.photoList = photoList.clone() as VOList;
			vo.productStock = productStock.clone() as ShopProductStockList;
			return vo;
		}
		
		override public function clear():void
		{
			productNo = '';
			productID = '';
			productFBID = '';
			productName = '';
			productPrice = '';
			productDescription = '';
			productCurrency = '';
			productCategoryNo = '';
			productCategoryName = '';
			productDateTime = '';
			productURL = '';
			productUnit = '';
			
			//photoFileVO.clear();
			photoList.clear();
			
			shopperCategoryNo = '';
			shopperProductNo = '';
			shopperProductTypeNo = '';
			
			productDiscount = 0;
			productTax = '';
			productStock.clear();
		}
		
		public function get productFBID():String 
		{
			return _productFBID;
		}
		
		public function set productFBID(value:String):void 
		{
			_productFBID = value;
			dispatchChangeEvent('productFBID', value);
		}
		
		public function get productName():String 
		{
			return _productName;
		}
		
		public function set productName(value:String):void 
		{
			_productName = value;
			dispatchChangeEvent('productName', value);
		}
		
		public function get productDescription():String 
		{
			return _productDescription;
		}
		
		public function set productDescription(value:String):void 
		{
			_productDescription = value;
			dispatchChangeEvent('productDescription', value);
		}
		
		
		/**
		 * To calculate the actual price of this product.
		 * @param	inWithDiscount - calculate with discount
		 * @param	inWithTax - calculate with tax
		 * @return	calculated price
		 */
		public function getPrice(inWithDiscount:Boolean = true, inWithTax:Boolean = true):Number
		{
			var price:Number = Number(productPrice);
			
			if (inWithDiscount)
			{
				price = ShopVOService.getDiscountedPrice(price, productDiscount);
			}
			
			if (inWithTax)
			{
				price = ShopVOService.getTaxPrice(price, Number(productTax));
			}
			
			return price;
		}
	}

}