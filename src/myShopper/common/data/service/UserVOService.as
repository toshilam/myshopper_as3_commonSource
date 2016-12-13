package myShopper.common.data.service 
{
	import flash.utils.ByteArray;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.shop.ShopInfoList;
	import myShopper.common.data.shop.ShopInfoVO;
	import myShopper.common.data.shop.ShopOrderVO;
	import myShopper.common.data.shop.ShopProductFormVO;
	import myShopper.common.data.shop.ShopProductList;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.shopper.ShopperCategoryVO;
	import myShopper.common.data.user.UserAddFriendRequestVO;
	import myShopper.common.data.user.UserFriendInfoVO;
	import myShopper.common.data.user.UserInfoList;
	import myShopper.common.data.user.UserInfoVO;
	import myShopper.common.data.user.UserRequestVO;
	import myShopper.common.data.user.UserShoppingCartList;
	import myShopper.common.data.user.UserShoppingCartProductVO;
	import myShopper.common.data.user.UserShoppingCartVO;
	import myShopper.common.data.user.UserShoppingRecordVO;
	import myShopper.common.data.user.UserShopTogetherList;
	import myShopper.common.data.user.UserShopTogetherRequestVO;
	import myShopper.common.emun.FileType;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.DateUtil;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserVOService 
	{
		protected var _userInfo:UserInfoList;
		
		public function UserVOService(inVO:UserInfoList) 
		{
			if (!(inVO is UserInfoList))
			{
				throw(new UninitializedError('UserVOService : unknown data type : ' + inVO));
			}
			
			
			_userInfo = inVO;
		}
		
		public static function isUserLogoImage(inData:Object):Boolean
		{
			return inData && inData['i_path'] == FileType.PATH_USER_LOGO;
		}
		
		public static function isUserBGImage(inData:Object):Boolean
		{
			return inData && inData['i_path'] == FileType.PATH_USER_BG;
		}
		
		/**
		 * // TODO : improve perforence add shop info shopInfoList, so that no need to re-download again if other module need the related info??
		 * @param	inData - data get from server
		 * @param	inUserVO - my user info vo
		 * @param	inShopVOList - list of shop vo 
		 */
		public static function setUserOrder(inData:Object, inUserVO:UserInfoVO/*, inShopVOList:ShopInfoList*/):Boolean 
		{
			if (inData == null || !(inData is Array) || !(inUserVO is UserInfoVO) /*|| !(inShopVOList is ShopInfoList)*/) 
			{
				Tracer.echo('UserVOService : setUserOrder : unknown data type : ' + inData, UserVOService, 0xff0000 );
				return false;
			}
			
			//clear all previous added data
			inUserVO.shoppingRecordList.clear();
			
			
			var numItem:int = (inData as Array).length;
			
			for (var i:int = 0; i < numItem; i++)
			{
				var data:Object = inData[i];
				var orderNo:String = data['o_no'];
				var uShoppingRecordVO:UserShoppingRecordVO = new UserShoppingRecordVO(orderNo/*, new ShopInfoVO(orderNo)*/);
				var oVO:ShopOrderVO = uShoppingRecordVO.shopOrderVO;
				
				uShoppingRecordVO.shopName = data['s_name'];
				uShoppingRecordVO.shopID = data['o_shop_id'];
				uShoppingRecordVO.shopCurrency = data['o_currency'];
				//get image URL
				/*var imageData:Object = data['s_image'];
				if (imageData && imageData['i_data'] is ByteArray)
				{
					var imageByte:ByteArray = imageData['i_data'];
					if (imageByte.bytesAvailable)
					{
						uShoppingRecordVO.shopInfoVO.logoFileVO.data = imageByte;
						uShoppingRecordVO.shopInfoVO.logoFileVO.name = imageData['i_name'];
						uShoppingRecordVO.shopInfoVO.logoFileVO.name = imageData['i_path'];
					}
					
				}*/
				
				
				oVO.address = data['o_address']; //ship to
				oVO.dateTime = DateUtil.getDateStringByUTCDateString( String(data['o_date_time']) );
				oVO.orderNo = orderNo;
				oVO.invoiceNo = data['o_invoice_no'];
				oVO.remark = Tools.replaceURL(Tools.replaceEmail(data['o_remark']));
				oVO.status = data['o_status'];
				oVO.total = data['o_total'];
				oVO.payKey = data['o_pay_key'];
				oVO.email = data['o_email'];
				oVO.phone = data['o_phone'];
				oVO.shopCurrency = uShoppingRecordVO.shopCurrency; //used in shopMgt only, for user side retreve from shopRecordVO
				oVO.shippingFee = data['o_shipping_fee'];
				oVO.shippingRemark = Tools.replaceURL(Tools.replaceEmail(data['o_shipping_remark']));
				oVO.isRead = data['o_read'] == '1'; //used in shopMgt only
				//oVO.userInfoVO.uid = data['o_user_id'];
				
				inUserVO.shoppingRecordList.addVO(uShoppingRecordVO);
			}
			
			return true;
		}
		
		public static function setUserOrderProduct(inData:Object, inShoppingRecordVO:UserShoppingRecordVO):Boolean 
		{
			if (inData == null || !(inData is Array) || !(inShoppingRecordVO is UserShoppingRecordVO) )
			{
				Tracer.echo('ShopService : setShopOrderProduct : unknown data type : ' + inData, UserVOService, 0xff0000 );
				return false;
			}
			
			//CHANGED 1304201
			//inShoppingRecordVO.productList.clear();
			
			inShoppingRecordVO.shopOrderVO.productList.clear();
			
			var numItem:int = (inData as Array).length;
			
			for (var i:int = 0; i < numItem; i++)
			{
				var data:Object = inData[i];
				
				var oVO:UserShoppingCartProductVO = new UserShoppingCartProductVO('');
				oVO.productNo = data['o_product_no'];
				oVO.productCategoryNo = data['o_category_no'];
				oVO.productPrice = data['o_price'];
				oVO.productDiscount = data['o_discount'];
				oVO.productTax = data['o_tax'];
				oVO.qty = data['o_qty'];
				oVO.productCategoryName = data['c_category'];
				//oVO.productName = data['p_name']; //use product id instead, avoid translation issue
				oVO.productName = data['p_id'];
				
				var imageData:Object = data['i_image'];
				if (imageData)
				{
					oVO.getPhotoVO().data = imageData['i_data'];
					oVO.getPhotoVO().name = imageData['i_name'];
					oVO.getPhotoVO().path = imageData['i_path'];
				}
			
				
				
				inShoppingRecordVO.shopOrderVO.productList.addVO(oVO);
			}
			
			return true;
			
		}
		
		//TODO : to use http load photo?
		/*public static function setUserOrderShopLogoURL(inHostURL:String, inUserVO:UserInfoVO):Boolean
		{
			var numItem:int = inUserVO.shoppingRecordList.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var uShoppingRecordVO:UserShoppingRecordVO = inUserVO.shoppingRecordList.getVO(i) as UserShoppingRecordVO;
				if (uShoppingRecordVO)
				{
					uShoppingRecordVO.shopInfoVO.logoFileVO.url = inHostURL + '/' + uShoppingRecordVO.shopInfoVO.uid + '/' +FileType.PATH_SHOP_LOGO + '.img';
				}
				
				
			}
			
			return true;
		}*/
		
		public static function getCheckOutProductListObj(inProductList:ShopProductList, inWithDetail:Boolean = false):Array
		{
			var numItem:int = inProductList.length;
			var arrProduct:Array = new Array();
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:UserShoppingCartProductVO = inProductList.getVO(i) as UserShoppingCartProductVO;
				if (vo)
				{
					var data:Object = { o_category_no:vo.productCategoryNo, o_product_no:vo.productNo, o_price:vo.productPrice, o_qty:vo.qty.toString(), o_discount:vo.productDiscount.toString(), o_tax:vo.productTax };
					
					if (inWithDetail)
					{
						data.o_p_name = vo.productName;
						data.o_sum_p_price = vo.getPrice();
						data.o_sum_price_qty = vo.getPriceWithQTY();
					}
					
					arrProduct.push( data );
				}
			}
			
			return arrProduct;
		}
		
		//get vo to Shopping cart list, it will be used by userMgt module
		//this should only be used once user is logged in
		public static function setCart(inData:Object, inMyUserInfo:UserInfoVO):Boolean
		{
			var arrData:Array = inData as Array;
			if (!arrData) return false;
			
			
			var numItem:int = arrData.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var data:Object = arrData[i];
				
				//sp-xxxxxx
				var shopNo:String = data['c_shop_no'];
				var shopID:String = data['s_user_id'];
				var shopName:String = data['s_name'];
				var shopCurrency:String = String(data['s_currency']); //cast as string first, check whather it contains value, avoid null value to 0
				
				var cartVO:UserShoppingCartVO = inMyUserInfo.shoppingCartList.getVOByShopNo(shopNo) as UserShoppingCartVO;
				
				//create a new cart vo if shopping cart vo is not created for this shop
				if (!cartVO)
				{
					cartVO = new UserShoppingCartVO(shopNo);
					cartVO.shopID = shopID;
					cartVO.shopName = shopName;
					cartVO.shopCurrency = shopCurrency != null ? int(shopCurrency) : -1;
					
					inMyUserInfo.shoppingCartList.addVO(cartVO);
				}
				
				var productNo:String = data['c_product_no'];
				var productID:String = data['p_id'];
				//var productName:String = data['p_name']; //use ID instead, avoid multi lang problem
				//var productDescription:String = data['p_description']; //use ID instead, avoid multi lang problem
				var productName:String = productID;
				var productDescription:String = '';
				var productPrice:String = data['p_price'];
				var productTax:String = data['p_tax'];
				var productCurrency:String = shopCurrency;
				var catagoryNo:String = data['c_category_no'];
				var catagoryName:String = data['c_category'];
				var productDiscount:int = data['p_discount'];
				var productURL:String = ShopVOService.getProductPageID(shopNo, catagoryName, productID);
				
				var cartProductVO:UserShoppingCartProductVO = cartVO.productList.getVOByProductNo(productNo) as UserShoppingCartProductVO;
				
				if (!cartProductVO)
				{
					cartProductVO = createShoppingCartProdyctVO(productID, productNo, productID, productName, productPrice, productDescription, productCurrency, catagoryNo, '', productURL, catagoryName, shopNo, productDiscount, productTax);//define which shop belong to, used for deleting product later on
					
					cartVO.productList.addVO(cartProductVO)
				}
			} 
			
			return true;
		}
		
		//get vo to Shopping cart list, it will be used by shop module
		public static function getCartVOByProductVO(inVO:ShopProductFormVO, inShopNo:String):UserShoppingCartProductVO
		{
			var p:ShopProductFormVO = inVO as ShopProductFormVO;
			
			var vo:UserShoppingCartProductVO = createShoppingCartProdyctVO(p.id, p.productNo, p.productID, p.productName, p.productPrice, p.productDescription, p.productCurrency, p.productCategoryNo, p.productDateTime, p.productURL, p.productCategoryName, inShopNo, p.productDiscount, p.productTax);
			
			ImageVOService.setImageVOByVO(vo.getPhotoVO(), p.getPhotoVO().clone() as FileImageVO);
			return vo;
		}
		
		private static function createShoppingCartProdyctVO(id:String, productNo:String, productID:String, productName:String, productPrice:String, productDescription:String, productCurrency:String, catagoryNo:String, dataTime:String, productURL:String, catagoryName:String, inShopNo:String, inDiscount:int, inTax:String):UserShoppingCartProductVO
		{
			var vo:UserShoppingCartProductVO = new UserShoppingCartProductVO(id, productNo, productID, productName, productPrice, productDescription, productCurrency, catagoryNo, dataTime, productURL, catagoryName, inDiscount, inTax);
			vo.shopNo = inShopNo;
			
			return vo;
		}
		
		public static function setShopTogetherRequest(inData:Object, inMyUserInfo:UserInfoVO):UserShopTogetherRequestVO
		{
			var fromUID:String = inData['u_fromUID'];
			var fromName:String = inData['u_fromName'];
			var message:String = inData['u_message'];
			var groupID:String = inData['groupID'];
			if (fromUID && groupID)
			{
				//if req from this user is already exist, do nothing
				if (!inMyUserInfo.requestList.getShopTogetherRequestVOByUID(fromUID))
				{
					var vo:UserShopTogetherRequestVO = new UserShopTogetherRequestVO(fromUID, inMyUserInfo.uid, message, fromName, inMyUserInfo.firstName, groupID );
					inMyUserInfo.requestList.addVO( vo );
					
					return vo;
				}
				
			}
			
			return null;
		}
		
		public static function setShopTogetherJoin(inData:Object, inUserInfoList:UserInfoList, inShopTogetherList:UserShopTogetherList):Boolean
		{
			var groupID:String = inData['groupID'];
			var hostUID:String = inData['hostUID'];
			var arrUsersInfo:Array = inData['usersInfo'];
			
			if (groupID && hostUID && arrUsersInfo)
			{
				//once a user accept to shop together, set host id
				inShopTogetherList.groupID = groupID;
				inShopTogetherList.hostUID = hostUID;
				
				var numItem:int = arrUsersInfo.length;
				for (var i:int = 0; i < numItem; i++)
				{
					var userData:Object = arrUsersInfo[i];
					var uid:String = userData['u_id'];
					
					if (uid)
					{
						//fd data should have already dl by userMgt
						//can be failed if uid == my uid
						var userInfo:UserInfoVO = inUserInfoList.getVOByUID(uid) as UserInfoVO;
						if (userInfo)
						{
							//can be failed if user already in list
							inShopTogetherList.addVO(userInfo);
						}
						else
						{
							Tracer.echo('UserVOService : setShopTogetherJoin : unable to retrieve user info vo');
						}
					}
					else
					{
						Tracer.echo('UserVOService : setShopTogetherJoin : unable to retrieve user id');
						return false;
					}
				}
				
				return true;
			}
			
			return false;
			
		}
		
		public static function setShopTogetherLeave(inData:Object, inUserInfoList:UserInfoList, inShopTogetherList:UserShopTogetherList, inMyUserInfo:UserInfoVO):Boolean
		{
			var groupID:String = inData['groupID'];
			var userObj:Object = inData['userInfo'];
			
			if (groupID && userObj)
			{
				//check is the group id matched with the current shopTogether one
				if (!inShopTogetherList.groupID == groupID)
				{
					Tracer.echo('UserVOService : setShopTogetherLeave : group id does not matched with the current one');
					return false;
				}
				
				var uid:String = userObj['u_id'];
				
				if (uid)
				{
					//remove all data if the leave user is host user or myself
					if (inShopTogetherList.hostUID == uid || inMyUserInfo.uid == uid)
					{
						inShopTogetherList.removeAllVO();
						//not to use clear, as it wont dispatch any change event
						inShopTogetherList.hostUID = '';
						inShopTogetherList.groupID = '';
					}
					else
					{
						//fd data should have already dl by userMgt
						var userInfo:UserInfoVO = inUserInfoList.getVOByUID(uid) as UserInfoVO;
						if (userInfo)
						{
							inShopTogetherList.removeVO(userInfo);
						}
						else
						{
							Tracer.echo('UserVOService : setShopTogetherLeave : unable to retrieve user info vo');
						}
					}
						
				}
				else
				{
					Tracer.echo('UserVOService : setShopTogetherLeave : unable to retrieve user id');
					return false;
					
				}
				
				return true;
			}
			
			return false;
			
		}
		
		public static function setShopTogetherGroup(inData:Object, inShopTogetherList:UserShopTogetherList):Boolean
		{
			//data can be null if fail creating group
			var groupID:String = inData['groupID'];
			inShopTogetherList.groupID = groupID ? groupID : '';
			
			return (groupID is String) && String(groupID).length > 0;
		}
		
		public static function setAddFriendRequest(inData:Object, inMyUserInfo:UserInfoVO):UserAddFriendRequestVO
		{
			var fromUID:String = inData['u_fromUID'];
			var fromName:String = inData['u_fromName'];
			var message:String = inData['u_message'];
			if (fromUID && fromUID.length)
			{
				//if req from this user is already exist, do nothing
				if (!inMyUserInfo.requestList.getAddFriendRequestVOByUID(fromUID))
				{
					var vo:UserAddFriendRequestVO = new UserAddFriendRequestVO(fromUID, inMyUserInfo.uid, message, fromName, inMyUserInfo.firstName );
					inMyUserInfo.requestList.addVO( vo );
					
					return vo;
				}
				
			}
			
			return null;
		}
		
		public static function removeAddFriendRequestByUID(inUID:String, inMyUserInfo:UserInfoVO):UserAddFriendRequestVO
		{
			return inMyUserInfo.requestList.removeAddFriendRequestVOByUID(inUID) as UserAddFriendRequestVO;
		}
		
		public static function removeShopTogetherRequestByUID(inUID:String, inMyUserInfo:UserInfoVO):UserShopTogetherRequestVO
		{
			return inMyUserInfo.requestList.removeShopTogetherRequestVOByUID(inUID) as UserShopTogetherRequestVO;
		}
		
		public static function setAddFriendResponse(inData:Object, inMyUserInfo:UserInfoVO):UserAddFriendRequestVO
		{
			var fromUID:String = inData['u_fromUID'];
			var fromName:String = inData['u_fromName'];
			var isAccept:Boolean = inData['u_isAccept'];
			
			if (fromUID && fromUID.length)
			{
				var vo:UserAddFriendRequestVO = new UserAddFriendRequestVO(fromUID, inMyUserInfo.uid, '', fromName, inMyUserInfo.firstName );
				//inMyUserInfo.requestList.addVO( vo );
				vo.isAccept = isAccept === true;
				
				//add fd into list
				if (vo.isAccept)
				{
					setMyFriend(vo, inMyUserInfo);
				}
				return vo;
			}
			
			return null;
		}
		
		public static function setShopTogetherResponse(inData:Object, inMyUserInfo:UserInfoVO):UserShopTogetherRequestVO
		{
			var fromUID:String = inData['u_fromUID'];
			var fromName:String = inData['u_fromName'];
			var isAccept:Boolean = inData['u_isAccept'];
			var groupID:String = inData['groupID'];
			
			if (fromUID && groupID)
			{
				var vo:UserShopTogetherRequestVO = new UserShopTogetherRequestVO(fromUID, inMyUserInfo.uid, '', fromName, inMyUserInfo.firstName, groupID);
				//inMyUserInfo.requestList.addVO( vo );
				vo.isAccept = isAccept === true;
				
				//add fd into list
				/*if (vo.isAccept)
				{
					setMyFriend(vo, inMyUserInfo);
				}*/
				return vo;
			}
			
			return null;
		}
		
		public static function setMyUserInfo(inData:Object, inVO:IVO, inCategoryList:ShopperCategoryList):Boolean
		{
			var result:Object = inData;
			var _vo:UserInfoVO = inVO as UserInfoVO;
			
			if (_vo && result != false && result['u_id'] != null)
			{
				_vo.isLogged = true;
				
				_vo.firstName = result['u_first_name'];
				_vo.lastName = result['u_last_name'];
				_vo.no = result['u_no'];
				_vo.uid = result['u_id'];
				_vo.token = result['u_token'];
				_vo.activated = result['u_activated'];
				_vo.ageRange = result['u_age_range'];
				_vo.country = result['u_country'];
				//_vo.district = result['u_district'];
				_vo.address = result['u_address'];
				_vo.email = result['u_email'];
				_vo.lat = result['u_lat'] ? result['u_lat'] : 0;
				_vo.lng = result['u_lng'] ? result['u_lng'] : 0;
				_vo.password = result['u_password'] ? result['u_password'] : '';
				_vo.phone = result['u_phone'];
				_vo.sex = result['u_sex'];
				_vo.subscribeNews = result['u_subscribe_news'];
				_vo.status = result['u_status'];
				//_vo.interest = result['u_interest'];
				
				var arrBirthday:Array = String(result['u_birthday']).split('-');
				_vo.year = arrBirthday[0];
				_vo.month = arrBirthday[1];
				_vo.day = arrBirthday[2];
				
				_vo.isShopExist = result['isShopExist'] === true;
				
				ShopperVOService.setShopperCategoryListByCategoryNoArray(result['u_interest'], _vo.interestList, inCategoryList);
				_vo.interest = ShopperVOService.getCategoryStringBySelectedShopperCategory(_vo.interestList);
				
				return true;
			}
			
			return false;
		}
		
		public static function setMyFriendList(inData:Object, inMyUserInfo:UserInfoVO):Boolean
		{
			if (!(inData is Array) || !inMyUserInfo) return false;
			
			var arrFd:Array = inData as Array;
			var numItem:int = arrFd.length;
			
			inMyUserInfo.friendList.clear();
			
			for (var i:int = 0; i < numItem; i++)
			{
				var fdData:Object = arrFd[i];
				
				setMyFriend(fdData, inMyUserInfo);
				
			}
			
			return true;
		}
		
		public static function setMyFriend(inData:Object, inMyUserInfo:UserInfoVO):Boolean
		{
			var fdID:String;
			//var fdNO:String;
			var fdFirstName:String;
			
			
			if (inData is UserAddFriendRequestVO)
			{
				var req:UserAddFriendRequestVO = inData as UserAddFriendRequestVO;
				fdID = req.fromUID;
				fdFirstName = req.fromName
				//fdFirstName = inData['u_first_name'];
			}
			else
			{
				fdID = inData['u_id'];
				//fdNO = inData['u_no'];
				fdFirstName = inData['u_first_name'];
			}
			
			if ( fdID && !inMyUserInfo.friendList.getVOByUID(fdID) )
			{
				var fdVO:UserFriendInfoVO = new UserFriendInfoVO(fdID);
				
				fdVO.uid = fdID ? fdID : '';
				fdVO.firstName = fdFirstName ? fdFirstName : '';
				//fdVO.lastName = fdData['u_last_name'];
				//fdVO.no = fdNO ? fdNO : '';
				
				inMyUserInfo.friendList.addVO( fdVO );
				
				return true;
			}
			
			Tracer.echo('UserVOService : setMyFriend : unable to add fd vo');
			return false;
			
		}
		
		public function setUserInfoByFdVO(inFdVO:UserFriendInfoVO, inAutoCreate:Boolean = true):UserInfoVO
		{
			var userInfo:UserInfoVO = _userInfo.getVOByUID(inFdVO.uid) as UserInfoVO;
			
			if (!userInfo && inAutoCreate)
			{
				userInfo = new UserInfoVO(inFdVO.uid);
				
				_userInfo.addVO( userInfo );
			}
			
			userInfo.uid = inFdVO.uid;
			userInfo.firstName = inFdVO.firstName;
			
			return userInfo;
		}
		
		//To be used by shopMgt/appForm
		public function setUserInfo(inData:Object, inCategoryList:ShopperCategoryList):IVO
		{
			if (inData['u_id'])
			{
				var _vo:UserInfoVO = _userInfo.getVOByUID(inData['u_id']) as UserInfoVO;
				
				if (_vo)
				{
					//CHANGED : 10062012 : to be handle by each proxy
					//avoid mis-set user online status
					//_vo.isLogged = true;
					
					_vo.firstName = inData['u_first_name'];
					_vo.lastName = inData['u_last_name'];
					_vo.no = inData['u_no'];
					_vo.uid = inData['u_id'];
					_vo.token = inData['u_token'];
					_vo.activated = inData['u_activated'];
					_vo.ageRange = inData['u_age_range'];
					_vo.country = inData['u_country'];
					_vo.address = inData['u_address'];
					_vo.email = inData['u_email'];
					//_vo.interest = inData['u_interest'];
					_vo.lat = inData['u_lat'];
					_vo.lng = inData['u_lng'];
					_vo.password = inData['u_password'];
					_vo.phone = inData['u_phone'];
					_vo.sex = inData['u_sex'];
					_vo.subscribeNews = inData['u_subscribe_news'];
					
					var arrBirthday:Array = String(inData['u_birthday']).split('-');;
					_vo.day = arrBirthday[0];
					_vo.month = arrBirthday[1];
					_vo.year = arrBirthday[2];
					
					_vo.isShopExist = inData['isShopExist'] === true;
					
					ShopperVOService.setShopperCategoryListByCategoryNoArray(inData['u_interest'], _vo.interestList, inCategoryList);
					_vo.interest = ShopperVOService.getCategoryStringBySelectedShopperCategory(_vo.interestList);
				
					return _vo;
				}
				
				Tracer.echo('UserVOService : setUserInfo : no matched vo found : ' + inData['u_id'], this, 0xff0000);
				return null;
			}
			
			Tracer.echo('UserVOService : setUserInfo : unknown data type : ' + inData, this, 0xff0000);
			return null;
		}
		
		
		//to be handled by shoperVOService
		/*public static function setUserInterestList(inData:Array, inUserInfo:UserInfoVO, inCategoryList:ShopperCategoryList):Boolean
		{
			if (!(inData is Array)) return false;
			
			var numItem:int = inData.length;
			
			for (var i:int = 0; i < numItem; i++)
			{
				var categoryNo:String = String(inData[i]);
				var cVO:ShopperCategoryVO = inCategoryList.getVOByCategoryNo(categoryNo) as ShopperCategoryVO;
				
				if (cVO)
				{
					cVO = cVO.clone() as ShopperCategoryVO;
					
					cVO.isSelected = true;
					inUserInfo.interest += cVO.categoryName + ' ; ';
					inUserInfo.interestList.addVO( cVO );
				}
				else
				{
					Tracer.echo('UserVOService : setUserInterestList : no matched category no found in list');
					return false;
				}
			}
			
			return true;
		}*/
		
		
	}

}