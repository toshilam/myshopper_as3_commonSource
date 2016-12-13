package myShopper.common.data.service 
{
	import myShopper.amf.shop.data.CategoryVO;
	import myShopper.amf.shop.data.ProductVO;
	import myShopper.amf.shop.data.ShopVO;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.service.ImageVOService;
	import myShopper.common.data.shop.ShopCategoryFormVO;
	import myShopper.common.data.shop.ShopCustomPageVO;
	import myShopper.common.data.shop.ShopInfoList;
	import myShopper.common.data.shop.ShopInfoVO;
	import myShopper.common.data.shop.ShopNewsVO;
	import myShopper.common.data.shop.ShopOrderExtraVO;
	import myShopper.common.data.shop.ShopOrderVO;
	import myShopper.common.data.shop.ShopProductFormVO;
	import myShopper.common.data.shop.ShopProductList;
	import myShopper.common.data.shopper.ShopperAreaList;
	import myShopper.common.data.shopper.ShopperAreaVO;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.shopper.ShopperCityList;
	import myShopper.common.data.shopper.ShopperCityVO;
	import myShopper.common.data.shopper.ShopperCountryList;
	import myShopper.common.data.shopper.ShopperCountryVO;
	import myShopper.common.data.shopper.ShopperStateVO;
	import myShopper.common.data.user.UserShoppingCartProductVO;
	import myShopper.common.data.user.UserShoppingRecordProductVO;
	import myShopper.common.data.VOList;
	import myShopper.common.emun.OrderExtraTypeID;
	import myShopper.common.emun.PageID;
	import myShopper.common.interfaces.IOrderVO;
	import myShopper.common.utils.DateUtil;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopVOService 
	{
		private var _shopInfo:ShopInfoList;
		
		public function ShopVOService(inInfoList:ShopInfoList) 
		{
			_shopInfo = inInfoList;
		}
		
		public function clear():void
		{
			_shopInfo = null;
		}
		
		public static function replaceRestrictedString(inValue:String):String
		{
			return Tools.replaceRestrictedString(inValue);
		}
		
		public static function getShopNoByProductPageID(inURL:String):String
		{
			// shop/{sp-xxxxxx}/shop-products/{catagory}/{productID}
			var arrString:Array = inURL.split('/');
			return arrString && arrString.length ? arrString[1] : '';
		}
		
		public static function getProductPageURL(inhttpHost:String, inShopNo:String, inCategoryName:String, inProductID:String):String
		{
			//http://{httpHost}/#/shop/sp-000020/shop-products/{catagory}/{productID}/
			return inhttpHost + '/#/' + getProductPageID(inShopNo, inCategoryName, inProductID);
		}
		
		public static function getProductPageID(inShopNo:String, inCategoryName:String, inProductID:String = null):String
		{
			// shop/{sp-xxxxxx}/shop-products/{catagory}/{productID}
			//CHANGED : : 12042012 / no need Tools.hyphenToSpace, as space is not allowed when user create category or product
			//var productID:String = inProductID  && inProductID.length ? '/' + Tools.spaceToHyphen(inProductID) : '';
			//return PageID.SHOP + '/' + inShopNo + '/' + PageID.SHOP_PRODUCT + '/' + Tools.spaceToHyphen(inCategoryName) + productID;
			var productID:String = inProductID  && inProductID.length ? '/' + inProductID : '';
			return PageID.SHOP + '/' + inShopNo + '/' + PageID.SHOP_PRODUCT + '/' + inCategoryName + productID;
		}
		
		public static function getShopPage(inShopNo:String):String
		{
			// shop/{sp-xxxxxx}/
			return PageID.SHOP + '/' + inShopNo;
		}
		
		public static function getShopPageURL(inHttpHost:String, inShopNo:String, inLangCode:String = null):String
		{
			// shop/{sp-xxxxxx}/
			var lang:String = inLangCode ? inLangCode + '/' : '';
			return inHttpHost + '/#/' + lang + getShopPage(inShopNo) + '/' + PageID.SHOP_HOME;
		}
		
		public static function getDiscountedPrice(inPrice:Number, inDiscount:int):Number
		{
			return Number(Number(inPrice - inPrice * inDiscount / 100).toFixed(2));
		}
		
		public static function getTaxPrice(inPrice:Number, inTax:Number):Number
		{
			return Number(Number(inPrice + inPrice * inTax / 100).toFixed(2));
		}
		
		/*public static function getProductPriceWithTax(inVO:UserShoppingCartProductVO):Number
		{
			var discountedPrice:Number = getDiscountedPrice(Number(inVO.productPrice), inVO.productDiscount);
			var taxPrice:Number = getTaxPrice(discountedPrice, Number(inVO.productTax));
			return taxPrice;
		}*/
		
		//used by shopMgt and userMgt
		public static function getOrderFinalTotalByOrderVO(inVO:ShopOrderVO):Number
		{
			var extraTotal:Number = getOrderExtraTotalByVO(inVO.extraList);
			var productTotal:Number = getOrderSubTotalByVO(inVO.productList);
			//CHANGED : 24/11/2013
			//var total:Number = Number(inVO.total) + Number(inVO.shippingFee) + extraTotal;
			var total:Number = productTotal + Number(inVO.shippingFee) + extraTotal;
			
			return Number(total.toFixed(2));
		}
		
		//used in shopMgt sale mediator
		public static function getOrderSubTotalByVO(inVO:ShopProductList):Number
		{
			var numItem:int = inVO.length;
			var subTotal:Number = 0;
			
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:UserShoppingCartProductVO = inVO.getVO(i) as UserShoppingCartProductVO;
				if (vo)
				{
					//var discountedPrice:Number = getDiscountedPrice(Number(vo.productPrice), vo.productDiscount) * vo.qty;
					//var taxPrice:Number = getTaxPrice(discountedPrice, Number(vo.productTax));
					//subTotal += taxPrice;
					subTotal += vo.getPriceWithQTY();
				}
			}
			
			return Number(subTotal.toFixed(2));
		}
		
		public static function getOrderExtraTotalByVO(inVOList:VOList):Number
		{
			var numItem:int = inVOList.length;
			var total:Number = 0;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:ShopOrderExtraVO = inVOList.getVO(i) as ShopOrderExtraVO;
				if (vo)
				{
					var amount:Number;
					
					switch(vo.type)
					{
						case OrderExtraTypeID.FEE:
						{
							amount = vo.total;
							break;
						}
						case OrderExtraTypeID.DISCOUNT:
						{
							amount = -(vo.total);
							break;
						}
					}
					
					if (!isNaN(amount))
					{
						total += amount;
					}
				}
			}
			
			return Number(total.toFixed(2));
		}
		
		public static function setShopOrderExtra(inData:Object, inOrderVO:ShopOrderVO):ShopOrderVO 
		{
			if (inData == null /*|| !(inData is Array)*/ || !(inOrderVO is ShopOrderVO) )
			{
				Tracer.echo('ShopService : setShopOrderExtra : unknown data type : ' + inData, ShopVOService, 0xff0000 );
				return null;
			}
			
			var orderNo:String = inData['e_order_no'];
			
			if (orderNo != inOrderVO.orderNo) return null;
			
			//if you result directly return true
			if (!(inData is Array) && orderNo)
			{
				return inOrderVO;
			}
			
			inOrderVO.extraList.clear();
			
			var numItem:int = (inData as Array).length;
			
			for (var i:int = 0; i < numItem; i++)
			{
				var data:Object = inData[i];
				
				var oVO:ShopOrderExtraVO = new ShopOrderExtraVO('');
				oVO.name = data['e_name'];
				oVO.type = data['e_type'];
				oVO.total = data['e_total'];
				
				inOrderVO.extraList.addVO(oVO);
			}
			
			return inOrderVO;
			
		}
		
		public static function addHotShopInfoByVO(inData:ShopInfoVO, inAreaList:ShopperAreaList):ShopperAreaVO
		{
			if (inData)
			{
				var areaVO:ShopperAreaVO = inAreaList.getVOByAreaNo(inData.area) as ShopperAreaVO;
				
				if (areaVO)
				{
					//check whather this shop has already added in list
					if (!areaVO.shopInfo.getVOByUID(inData.uid, inData.shopNo))
					{
						areaVO.shopInfo.addVO(inData);
						
					}
					
					return areaVO;
				}
			}
			
			return null;
		}
		
		
		public function addShopInfo(inData:Object, inCategoryList:ShopperCategoryList):ShopInfoVO 
		{
			if (!inData || inData['s_no'] == null || inData['s_currency'] == undefined) 
			{
				Tracer.echo('ShopService : addShopInfo : data property not found s_no', this, 0xff0000 );
				return null;
			}
			
			var vo:ShopInfoVO = _shopInfo.getVOByID(inData['s_no']) as ShopInfoVO;
			if (!vo)
			{
				//use s_no (will be translated to {sp-XXXXXX} in server side) as vo ID 
				vo = new ShopInfoVO(inData['s_no']);
				vo.uid = inData['s_user_id'];
				vo.name = inData['s_name'];
				vo.phone = inData['s_phone'];
				vo.intro = inData['s_intro'];
				//vo.room = inData['s_room'];
				//vo.house = inData['s_house'];
				//vo.street = inData['s_street'];
				vo.address = inData['s_address'];
				vo.district = inData['s_district'];
				vo.area = inData['s_area_no'];
				vo.lat = Number(inData['s_lat']);
				vo.lng = Number(inData['s_lng']);
				vo.city = inData['s_city'];
				vo.state = inData['s_state'];
				vo.country = inData['s_country'];
				vo.currency = int(inData['s_currency']);
				
				ShopperVOService.setShopperCategoryListByCategoryNoArray(inData['s_product_type'], vo.productTypeList, inCategoryList);
				vo.productType = ShopperVOService.getCategoryStringBySelectedShopperCategory(vo.productTypeList);
				
				_shopInfo.addVO(vo);
				
				Tracer.echo('ShopVOService : setShopInfo : added new shop info : ' + vo, this, 0xff8899);
				
			}
			
			return vo;
		}
		
		public function addShopInfoByShopVO(inData:ShopVO, inCategoryList:ShopperCategoryList):ShopInfoVO 
		{
			if (!(inData is ShopVO) || !inData.shopNo || inData.currency == -1) 
			{
				Tracer.echo('ShopService : addShopInfoByShopVO : data property not found shopNo', this, 0xff0000 );
				return null;
			}
			
			var vo:ShopInfoVO = _shopInfo.getVOByID(inData.shopNo) as ShopInfoVO;
			if (!vo)
			{
				//use s_no (will be translated to {sp-XXXXXX} in server side) as vo ID 
				vo = new ShopInfoVO(inData.shopNo);
				vo.uid = inData.uid;
				vo.name = inData.name;
				vo.phone = inData.phone;
				vo.intro = inData.intro;
				//vo.room = inData.room;
				//vo.house = inData.house;
				//vo.street = inData.street;
				vo.address = inData.address;
				//vo.district = inData.d;
				vo.area = inData.area;
				vo.lat = Number(inData.lat);
				vo.lng = Number(inData.lng);
				vo.state = inData.stateID;
				vo.country = inData.countryID;
				vo.city = inData.cityID;
				vo.currency = inData.currency;
				
				ShopperVOService.setShopperCategoryListByCategoryNoArray(inData.productType, vo.productTypeList, inCategoryList);
				vo.productType = ShopperVOService.getCategoryStringBySelectedShopperCategory(vo.productTypeList);
				
				_shopInfo.addVO(vo);
				
				Tracer.echo('ShopVOService : setShopInfo : added new shop info : ' + vo, this, 0xff8899);
				
			}
			
			return vo;
		}
		
		public function setShopLogo(inData:Object, inShopID:String):ShopInfoVO
		{
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['i_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			//vo.logoFileVO.name = inData['i_name'];
			//vo.logoFileVO.data = inData['i_data'];
			//vo.logoFileVO.path = inData['i_path'];
			
			return ImageVOService.setImageVO(vo.logoFileVO, inData) ? vo : null;
		}
		
		public function setShopBG(inData:Object, inShopID:String):ShopInfoVO
		{
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['i_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			return ImageVOService.setImageVO(vo.bgFileVO, inData) ? vo : null;
		}
		
		public function setShopCustomImage(inData:Object, inShopID:String):ShopInfoVO
		{
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['i_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			var pageNo:String = inData['i_extra'];
			
			if (pageNo)
			{
				var cVO:ShopCustomPageVO = vo.customPageList.getVOByPageNo(pageNo) as ShopCustomPageVO;
				
				if (cVO)
				{
					return ImageVOService.setImageVO(cVO.photoFileVO, inData) ? vo : null;
				}
			}
			
			return null;
		}
		
		public function setShopProductImage(inData:Object, inShopID:String):ShopInfoVO
		{
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['i_user_id'], inShopID) as ShopInfoVO;
			if (!vo) return null;
			
			var categoryVO:ShopCategoryFormVO = vo.productCategoryList.getVOByCategoryNo(inData['i_category_no']) as ShopCategoryFormVO;
			if (!categoryVO) return null;
			
			var index:int = inData['i_index'] != undefined ? int(inData['i_index']) : 0;
			var imageVO:FileImageVO = ShopProductFormVO(categoryVO.productList.getVOByProductNo(inData['i_product_no'])).getPhotoVO(index);
			if (!imageVO) return null;
			
			ImageVOService.setImageVO(imageVO, inData)
			//imageVO.data = inData['i_data'];
			//imageVO.name = inData['i_name'];
			//imageVO.path = inData['i_path'];
			//imageVO.size = inData['i_size'];
			//imageVO.type = inData['i_type'];
			imageVO.userID = inData['i_user_id'];
			
			return vo;
		}
		
		public function setShopAbout(inData:Object, inShopID:String):ShopInfoVO
		{
			if (!inData || !inData['a_user_id']) return null;
			
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['a_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			var aboutTitle:String = inData['a_title'];
			var about:String = inData['a_about'];
			
			//about
			vo.aboutTitle = aboutTitle ? replaceRestrictedString(aboutTitle) : '';
			vo.about = about ? replaceRestrictedString(about) : '';
			
			return vo
		}
		
		public function setShopNews(inData:Object, inShopID:String):ShopInfoVO
		{
			if (!inData || !inData['n_user_id']) return null;
			
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['n_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			//news
			if (inData is Array && (inData as Array).length)
			{
				var arrNews:Array = inData as Array;
				var numItem:int = arrNews.length;
				
				for (var i:int = 0; i < numItem; i++)
				{
					var newsObj:Object = arrNews[i];
					vo.newList.addVO
					(
						new ShopNewsVO
						(
							newsObj['n_no'], 
							replaceRestrictedString(newsObj['n_title']), 
							replaceRestrictedString(newsObj['n_content']), 
							DateUtil.getDateStringByUTCDateString( String(newsObj['n_date_time']) )
						)
					);
				}
			}
			
			
			return vo
		}
		
		//sp-xxxxxx
		public function setShopCustom(inData:Object, inShopID:String):ShopInfoVO
		{
			if (!inData || !inData['c_user_id']) return null;
			
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['c_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			//custom
			if (inData is Array)
			{
				var arrCustom:Array = inData as Array;
				var numItem:int = arrCustom.length;
				
				for (var i:int = 0; i < numItem; i++)
				{
					var data:Object = arrCustom[i];
					
					var no:String = data['c_no'];
					var id:String = data['c_id'];
					var name:String = data['c_name'];
					var title:String = data['c_title'];
					var content:String = data['c_content'];
					
					if (!name || !title || !content) 
					{
						//if no data in this lang, skip
						continue;
					}
					
					var cVO:ShopCustomPageVO = vo.customPageList.getVOByPageNo(no) as ShopCustomPageVO;
					if (!cVO)
					{
						cVO = new ShopCustomPageVO(no, no, id);
						vo.customPageList.addVO( cVO );
					}
					
					cVO.pageName = replaceRestrictedString(name);
					cVO.pageTitle = replaceRestrictedString(title);
					cVO.pageContent = replaceRestrictedString(content);
					
				}
			}
			
			
			return vo
		}
		
		public function setShopCategory(inData:Object, inShopID:String):ShopInfoVO
		{
			if (!inData || !inData['c_user_id']) return null;
			
			var vo:ShopInfoVO = _shopInfo.getVOByUID(inData['c_user_id'], inShopID) as ShopInfoVO;
			if (vo == null) return null;
			
			//category
			if (inData is Array && (inData as Array).length > 0)
			{
				var arrResult:Array = inData as Array;
				
				for (var i:int = 0; i < arrResult.length; i++)
				{
					var categoryInfo:CategoryVO = arrResult[i] as CategoryVO;
					
					if (categoryInfo)
					{
						//if it's private category, no set needed
						if ((categoryInfo.isPrivate)) continue;
						
						//if no product under this category, no set needed
						if (!(categoryInfo.product is Array) || !(categoryInfo.product as Array).length) continue;
						
						// shop/{hksp-xxxxxx}/shop-products/{catagory} //url to be handle by swfAddress proxy?
						//var url:String = PageID.SHOP + '/' + vo.id + '/' + PageID.SHOP_PRODUCT + '/' + Tools.spaceToHyphen(categoryInfo.category);
						//CHANGED : : 12042012 / no need Tools.hyphenToSpace, as space is not allowed when user create category or product
						//var url:String = getProductPageID( vo.id , Tools.spaceToHyphen(categoryInfo.category) );
						var url:String = getProductPageID( vo.id , categoryInfo.category );
						
						var categoryVO:ShopCategoryFormVO;
						
						if (!vo.productCategoryList.hasVO(categoryInfo.no))
						{
							categoryVO = new ShopCategoryFormVO(categoryInfo.no, categoryInfo.category, false, categoryInfo.no, categoryInfo.dateTime, url);
							
							vo.productCategoryList.addVO(categoryVO);
							
						}
						else
						{
							//if data already exist, replace it, as it may be out dated
							categoryVO = vo.productCategoryList.getVOByID(categoryInfo.no) as ShopCategoryFormVO;
							categoryVO.categoryName = categoryInfo.category;
							categoryVO.categoryURL = url;
							categoryVO.createDateTime = categoryInfo.dateTime;
							
						}
						
						//num of product to be count by length of productListVo
						//categoryVO.numberOfProduct = (categoryInfo.product as Array).length;
						
						//if (categoryInfo.product is Array && (categoryInfo.product as Array).length)
						//{
							//prodcut vo from server, and categoryInfo vo which just updated
							setShopProduct(categoryInfo.product as Array, categoryVO);
						//}
						
					}
					else
					{
						Tracer.echo('ShopVOService : setShopCategory : unknown data type : ' + arrResult[i], this, 0xff0000);
						return null;
					}
					
				}
			}
			
			return vo;
		}
		
		//will be call by setShopCategory()
		public function setShopProduct(inData:Array, inCategoryInfo:ShopCategoryFormVO):Boolean
		{
			if (!(inData is Array) || !(inCategoryInfo is ShopCategoryFormVO))
			{
				Tracer.echo('ShopVOService : setShopProduct : unknown data type : ' + inData  + inCategoryInfo, this, 0xff0000);
				return false;
			}
			
			//product
			if (inData is Array && (inData as Array).length > 0)
			{
				var arrResult:Array = inData as Array;
				
				for (var i:int = 0; i < arrResult.length; i++)
				{
					var pVO:ProductVO = arrResult[i] as ProductVO;
					if (pVO)
					{
						// shop/{hksp-xxxxxx}/shop-products/{catagory} //url to be handle by swfAddress proxy?
						//CHANGED : : 12042012 / no need Tools.hyphenToSpace, as space is not allowed when user create category or product
						//var url:String = inCategoryInfo.categoryURL + '/' + Tools.spaceToHyphen(pVO.pid);
						var url:String = inCategoryInfo.categoryURL + '/' + pVO.pid;
						
						if(!inCategoryInfo.productList.hasVO(pVO.no))
						{
							inCategoryInfo.productList.addVO
							(
								new ShopProductFormVO
								(
									pVO.no, 
									pVO.no, 
									pVO.pid, 
									pVO.name, 
									pVO.price, 
									pVO.description,
									pVO.currency,
									pVO.category,
									pVO.dateTime,
									url,
									inCategoryInfo.categoryName,
									pVO.shopperCategoryNo,
									pVO.shopperProductNo,
									pVO.fbID,
									pVO.shopperProductTypeNo,
									pVO.discount,
									pVO.unit,
									pVO.tax
								)
							)
						}
						else
						{
							//if data already exist, replace it, as it may be out dated
							var productVO:ShopProductFormVO = inCategoryInfo.productList.getVOByID(pVO.no) as ShopProductFormVO;
							
							productVO.productCategoryNo = pVO.category;
							productVO.productCurrency = pVO.currency;
							productVO.productDateTime = pVO.dateTime;
							productVO.productDescription = pVO.description;
							productVO.productID = pVO.pid;
							productVO.productName = pVO.name;
							productVO.productNo = pVO.no;
							productVO.productPrice = pVO.price;
							productVO.productURL = url;
							productVO.productCategoryName = inCategoryInfo.categoryName;
							productVO.shopperCategoryNo = pVO.shopperCategoryNo;
							productVO.shopperProductNo = pVO.shopperProductNo;
							productVO.productFBID = pVO.fbID;
							productVO.shopperProductTypeNo = pVO.shopperProductTypeNo;
							productVO.productDiscount = pVO.discount;
							productVO.productUnit = pVO.unit;
							productVO.productTax = pVO.tax;
						}
					}
					else
					{
						Tracer.echo('ShopVOService : setShopProduct : unknown data type : pVO : ' + pVO, this, 0xff0000);
						return false;
					}
					
				}
			}
			
			return true;
		}
		
		//user setShopAreaInfoByShopperAreaList instead of!
		/*public static function setShopAreaInfo(inData:Object):*
		{
			var result:Object = inData;
			
			if (result is Array)
			{
				var numItem:int = (result as Array).length;
				var arrArea:Array = new Array();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					var data:Object = (result as Array)[i];
					if (data && data['a_name'])
					{
						var area:String = data['a_name'];
						
						arrArea.push( { data:area, label:area } );
					}
				}
				
				return arrArea;
			}
			
			return false;
		}*/
		
		public static function getActiveCountryCBArrayByShopperCountry(inData:ShopperCountryList):*
		{
			
			if (inData.length)
			{
				var numItem:int = inData.length;
				var arrData:Array = new Array();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					var vo:ShopperCountryVO = inData.getVO(i) as ShopperCountryVO;
					if (vo)
					{
						var countryName:String = vo.countryName;
						var countryID:String = vo.countryID;
						
						arrData.push( { data:countryID, label:countryName } );
					}
				}
				
				return arrData;
			}
			
			return false;
		}
		
		public static function getStateCBArrayByShopperCountry(inData:ShopperCountryList, inCountryID:String):*
		{
			var countryVO:ShopperCountryVO = inData.getVOByCountryID(inCountryID) as ShopperCountryVO;
			
			if (countryVO)
			{
				var numItem:int = countryVO.stateList.length;
				var arrData:Array = new Array();
				var vo:ShopperStateVO;
				
				var arrOther:Vector.<ShopperStateVO> = new Vector.<ShopperStateVO>();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					vo = countryVO.stateList.getVO(i) as ShopperStateVO;
					if (vo && vo.countryID == inCountryID)
					{
						if (vo.stateLat == 0 || vo.stateLng == 0) //other city should always be pushed to the last
						{
							arrOther.push( vo );
							continue;
						}
						
						arrData.push( { data:vo.stateID, label:vo.stateName } );
					}
				}
				
				while (arrOther.length)
				{
					vo = arrOther.splice(0, 1)[0];
					arrData.push( { data:vo.stateID, label:vo.stateName } );
				}
				
				return arrData;
			}
			
			
			return false;
		}
		
		public static function getCityCBArrayByShopperCountry(inData:ShopperCountryList, inCountryID:String, inStateID:String):*
		{
			var stateVO:ShopperStateVO = inData.getStateVOByID(inCountryID, inStateID);
			
			if (stateVO)
			{
				var numItem2:int = stateVO.cityList.length;
				var arrCity:Array = new Array();
				var cityVO:ShopperCityVO;
				var arrOther:Vector.<ShopperCityVO> = new Vector.<ShopperCityVO>();
				
				for ( var j:int = 0; j < numItem2; j++)
				{
					cityVO = stateVO.cityList.getVO(j) as ShopperCityVO;
					if (cityVO)
					{
						if (cityVO.cityLat == 0 || cityVO.cityLng == 0) //other should always be pushed to the last
						{
							arrOther.push( cityVO );
							continue;
						}
						
						arrCity.push( { data:cityVO.cityID, label:cityVO.cityName } );
					}
				}
				
				while (arrOther.length)
				{
					cityVO = arrOther.splice(0, 1)[0];
					arrCity.push( { data:cityVO.cityID, label:cityVO.cityName } );
				}
				
				return arrCity;
			}
			
			return false;
		}
		
		public static function getAreaCBArrayByShopperCountry(inData:ShopperCountryList, inCountryID:String, inStateID:String, inCityID:String):*
		{
			var cityVO:ShopperCityVO = inData.getCityVOByID(inCountryID, inStateID, inCityID);
			
			if (cityVO)
			{
				var numItem2:int = cityVO.areaList.length;
				var arrArea:Array = new Array();
				var areaVO:ShopperAreaVO;
				var arrOther:Vector.<ShopperAreaVO> = new Vector.<ShopperAreaVO>();
				
				for ( var j:int = 0; j < numItem2; j++)
				{
					areaVO = cityVO.areaList.getVO(j) as ShopperAreaVO;
					if (areaVO)
					{
						if (areaVO.areaLat == 0 || areaVO.areaLng == 0) //other should always be pushed to the last
						{
							arrOther.push( areaVO );
							continue;
						}
						
						arrArea.push( { data:areaVO.areaNo, label:areaVO.areaName } );
					}
				}
				
				while (arrOther.length)
				{
					areaVO = arrOther.splice(0, 1)[0];
					arrArea.push( { data:areaVO.areaNo, label:areaVO.areaName } );
				}
				
				return arrArea;
			}
			
			return false;
		}
	}

}