package myShopper.common.data.shop
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.VO;
	import myShopper.common.emun.FileType;
	import myShopper.common.interfaces.IShopInfoVO;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopInfoVO extends VO implements IShopInfoVO
	{
		//basic shop info
		public var uid:String = ''; //the shop owner uid
		public var createDate:String = '';
		private var _activated:Boolean = false;
		private var _infoApproved:Boolean = false;
		private var _paypalAccVerified:Boolean = false;
		
		
		private var _shopNo:String = ''; //{sp-xxxxxx}
		private var _name:String = ''; //shop name
		private var _intro:String = '';
		private var _phone:String = '';
		private var _payPalEmail:String = '';
		private var _payPalFirstName:String = '';
		private var _payPalLastName:String = '';
		private var _productType:String = '';
		//private var _room:String = '';
		//private var _house:String = '';
		//private var _street:String = '';
		private var _address:String = '';
		private var _area:String = ''; //area no
		private var _district:String = '';
		private var _city:String = ''; //id
		private var _state:String = ''; //id
		private var _country:String = ''; //id
		private var _currency:int = -1; //0=HKD,1=CNY,2=USD,3=JPY,4=TWD, by default HKD is selected
		private var _tax:Number = 0;
		
		private var _lat:Number = 0;
		private var _lng:Number = 0;
		
		private var _status:String = '';
		
		//shop management info
		private var _aboutTitle:String = '';
		private var _about:String = '';
		
		//public var newsTitle:String = '';
		//public var newsFileVO:FileImageVO = null;
		protected var _newsList:ShopNewsList;
		public function get newList():ShopNewsList { return _newsList; }
		
		protected var _customPageList:ShopCustomPageList;
		public function get customPageList():ShopCustomPageList { return _customPageList; }
		
		private var _logoFileVO:FileImageVO = null;
		private var _bgFileVO:FileImageVO = null;
		
		protected var _productCategoryList:ShopCategoryList;
		public function get productCategoryList():ShopCategoryList { return _productCategoryList; }
		
		protected var _shopOrderList:ShopOrderList;
		public function get shopOrderList():ShopOrderList { return _shopOrderList; }
		
		//moved to ShopMgtShopInfoVO
		//protected var _shopClosedOrderList:ShopOrderList;
		//public function get shopClosedOrderList():ShopOrderList { return _shopClosedOrderList; }
		
		private var _productTypeList:ShopperCategoryList;
		public function get productTypeList():ShopperCategoryList { return _productTypeList; }
		
		
		public function ShopInfoVO
		(
			inVOID:String
		) 
		{
			//id = {sp-XXXXXX}, will be used for vo id, should not be changed, it will be used for retrieve vo
			super(inVOID);
			_shopNo = inVOID;
			//about = inAbout;
			//aboutTitle = inAboutTitle;
			
			//news = inNews;
			//newsTitle = inNewsTitle;
			//newsFileVO = new FileImageVO(_id, null);
			
			_logoFileVO = new FileImageVO(_id, null);
			_bgFileVO = new FileImageVO(_id, null);
			_logoFileVO.path = FileType.PATH_SHOP_LOGO;
			_bgFileVO.path = FileType.PATH_SHOP_BG;
			
			_newsList = new ShopNewsList(_id);
			_customPageList = new ShopCustomPageList(_id);
			
			_productCategoryList = new ShopCategoryList(_id);
			_shopOrderList = new ShopOrderList(_id);
			//_shopClosedOrderList = new ShopOrderList(_id);
			//_chatList = new ChatList(_id);
			_productTypeList = new ShopperCategoryList(_id);
		}
		
		override public function clone():IVO 
		{
			var vo:ShopInfoVO = new ShopInfoVO(_id);
			
			//vo.uid:String = ''; //the shop owner uid
			//vo.createDate:String = '';
			//vo.activated:Boolean = false;
			//vo.infoApproved:Boolean = false;
			//
			//
			//vo.name:String = ''; //shop name
			//vo.intro:String = '';
			//vo.phone:String = '';
			vo.payPalEmail = _payPalEmail;
			vo.payPalFirstName = _payPalFirstName;
			vo.payPalLastName = _payPalLastName;
			//vo.productType:String = '';
			//vo.room:String = '';
			//vo.house:String = '';
			//vo.street:String = '';
			//vo.area:String = '';
			//vo.district:String = '';
			//vo.city:String = '';
			//vo.country:String = '';
			//
			//vo.lat:Number = 0;
			//vo.lng:Number = 0;
			//
			//vo.status:String = '';
			//
			//shop management info
			//vo.aboutTitle:String = '';
			//vo.about:String = '';
			
			
			return vo;
		}
		
		override public function clear():void
		{
			uid = '';
			//room = '';
			//house = '';
			//street = '';
			address = ''
			createDate = '';
			district = '';
			city = '';
			area = '';
			state = '';
			country = '';
			lat = 0;
			lng = 0;
			name = '';
			phone = '';
			productType = '';
			payPalEmail = '';
			payPalFirstName = '';
			payPalLastName = '';
			intro = '';
			
			aboutTitle = '';
			about = '';
			//newsTitle = '';
			//newsFileVO = null;
			
			//_logoFileVO = null;
			//_bgFileVO = null;
			_logoFileVO.clear();
			_bgFileVO.clear();
			
			activated = false;
			_infoApproved = false;
			_paypalAccVerified = false;
			
			_newsList.clear();
			_customPageList.clear();
			_productCategoryList.clear();
			_shopOrderList.clear();
			//_shopClosedOrderList.clear();
			_productTypeList.clear();
			//_chatList.clear();
		}
		
		/* INTERFACE myShopper.common.interfaces.IShopInfoVO */
		
		public function get payPalEmail():String {return _payPalEmail;}
		public function set payPalEmail(value:String):void 
		{
			_payPalEmail = value;
			dispatchChangeEvent('payPalEmail', payPalEmail);
		}
		
		public function get payPalFirstName():String {return _payPalFirstName;}
		public function set payPalFirstName(value:String):void 
		{
			_payPalFirstName = value;
			dispatchChangeEvent('payPalFirstName', payPalFirstName);
		}
		
		public function get payPalLastName():String {return _payPalLastName;}
		public function set payPalLastName(value:String):void 
		{
			_payPalLastName = value;
			dispatchChangeEvent('payPalLastName', payPalLastName);
		}
		
		public function get country():String { return _country; }
		public function set country(value:String):void 
		{
			_country = value;
			dispatchChangeEvent('country', value);
		}
		
		public function get state():String { return _state; }
		public function set state(value:String):void 
		{
			_state = value;
			dispatchChangeEvent('state', value);
		}
		
		
		public function get logoFileVO():FileImageVO
		{
			return _logoFileVO;
		}
		
		public function set logoFileVO(inValue:FileImageVO):void
		{
			_logoFileVO = inValue;
		}
		
		public function get bgFileVO():FileImageVO
		{
			return _bgFileVO;
		}
		
		public function set bgFileVO(inValue:FileImageVO):void
		{
			_bgFileVO = inValue;
		}
		
		public function get name():String { return _name; }
		public function set name(value:String):void 
		{
			_name = value;
			dispatchChangeEvent('name', value);
		}
		
		public function get intro():String { return _intro; }
		public function set intro(value:String):void 
		{
			_intro = value;
			dispatchChangeEvent('intro', value);
		}
		
		public function get productType():String { return _productType; }
		public function set productType(value:String):void 
		{
			_productType = value;
			dispatchChangeEvent('productType', value);
		}
		
		public function get phone():String { return _phone; }
		public function set phone(value:String):void 
		{
			_phone = value;
			dispatchChangeEvent('phone', value);
		}
		
		/*public function get room():String { return _room; }
		public function set room(value:String):void 
		{
			_room = value;
			dispatchChangeEvent('room', value);
		}
		
		public function get house():String { return _house; }
		public function set house(value:String):void 
		{
			_house = value;
			dispatchChangeEvent('house', value);
		}
		
		public function get street():String { return _street; }
		public function set street(value:String):void 
		{
			_street = value;
			dispatchChangeEvent('street', value);
		}*/
		
		public function get address():String { return _address; }
		public function set address(value:String):void 
		{
			_address = value;
			dispatchChangeEvent('address', value);
		}
		
		//area no
		public function get area():String { return _area; }
		public function set area(value:String):void 
		{
			_area = value;
			dispatchChangeEvent('area', value);
		}
		
		public function get district():String { return _district; }
		public function set district(value:String):void 
		{
			_district = value;
			dispatchChangeEvent('district', value);
		}
		
		public function get city():String { return _city; }
		public function set city(value:String):void 
		{
			_city = value;
			dispatchChangeEvent('city', value);
		}
		
		public function get lat():Number { return _lat; }
		public function set lat(value:Number):void 
		{
			_lat = value;
			dispatchChangeEvent('lat', value);
		}
		
		public function get lng():Number { return _lng; }
		public function set lng(value:Number):void 
		{
			_lng = value;
			dispatchChangeEvent('lng', value);
		}
		
		public function get about():String { return _about; }
		public function set about(value:String):void 
		{
			_about = value;
			dispatchChangeEvent('about', value);
		}
		
		public function get aboutTitle():String { return _aboutTitle; }
		public function set aboutTitle(value:String):void 
		{
			_aboutTitle = value;
			dispatchChangeEvent('aboutTitle', value);
		}
		
		public function get status():String { return _status; }
		public function set status(value:String):void 
		{
			_status = value;
			dispatchChangeEvent('status', value);
		}
		
		public function get paypalAccVerified():Boolean {return _paypalAccVerified;}
		public function set paypalAccVerified(value:Boolean):void 
		{
			_paypalAccVerified = value;
			dispatchChangeEvent('paypalAccVerified', value);
		}
		
		public function get infoApproved():Boolean {return _infoApproved;}
		public function set infoApproved(value:Boolean):void 
		{
			_infoApproved = value;
			dispatchChangeEvent('infoApproved', value);
		}
		
		public function get shopNo():String {return _shopNo;}
		public function set shopNo(value:String):void 
		{
			_shopNo = value;
			dispatchChangeEvent('shopNo', value);
		}
		
		public function get activated():Boolean { return _activated; }
		public function set activated(value:Boolean):void 
		{
			_activated = value;
			dispatchChangeEvent('activated', value);
		}
		
		public function get currency():int { return _currency; }
		public function set currency(value:int):void 
		{
			_currency = value;
			dispatchChangeEvent('currency', value);
		}
		
		public function get tax():Number {return _tax;}
		public function set tax(value:Number):void 
		{
			_tax = value;
			dispatchChangeEvent('tax', value);
		}
		
		
		
		
	}

}