package myShopper.common.data.shop 
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IShopInfoVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopRegisterFormVO extends VO implements IShopInfoVO
	{
		//shop info
		private var _name:String; //shop name
		private var _intro:String;
		
		private var _phone:String;
		private var _payPalEmail:String;
		private var _payPalFirstName:String;
		private var _payPalLastName:String;
		
		//private var _room:String;
		//private var _house:String;
		//private var _street:String;
		private var _address:String;
		
		private var _area:String;
		private var _city:String;
		private var _state:String;
		//private var _district:String;
		private var _country:String;
		
		private var _lat:Number = 0;
		private var _lng:Number = 0;
		
		private var _logoFileVO:FileImageVO = null;
		
		private var _productType:String;
		private var _productTypeList:ShopperCategoryList;
		
		public function ShopRegisterFormVO
		(
			inVOID:String
			/*inName:String = '', 
			inProduct:String = '',
			inPhone:String = '',
			inAddress:String = '',
			inDistrict:String = '',
			inArea:String = ''*/
		) 
		{
			super(inVOID);
			_logoFileVO = new FileImageVO(_id, null);
			_productTypeList = new ShopperCategoryList(_id);
			
			clear();
		}
		
		override public function clear():void
		{
			name = '';
			intro = '';
			productType = '';
			payPalEmail = '';
			payPalFirstName = '';
			payPalLastName = '';
			phone = '';
			//room = '';
			//house = '';
			//street = '';
			address = '';
			//district = '';
			area = '';
			city = '';
			
			lat = 0;
			lng = 0;
			
			_logoFileVO.clear();
			if(productTypeList) productTypeList.clear();
		}
		
		public function get payPalEmail():String 
		{
			return _payPalEmail;
		}
		
		public function set payPalEmail(value:String):void 
		{
			_payPalEmail = value;
		}
		
		
		public function get logoFileVO():FileImageVO
		{
			return _logoFileVO;
		}
		
		public function set logoFileVO(inValue:FileImageVO):void
		{
			_logoFileVO = inValue;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get intro():String { return _intro; }
		
		public function set intro(value:String):void 
		{
			_intro = value;
		}
		
		public function get productType():String { return _productType; }
		
		public function set productType(value:String):void 
		{
			_productType = value;
		}
		
		public function get phone():String { return _phone; }
		
		public function set phone(value:String):void 
		{
			_phone = value;
		}
		
		/*public function get room():String { return _room; }
		
		public function set room(value:String):void 
		{
			_room = value;
		}
		
		public function get house():String { return _house; }
		
		public function set house(value:String):void 
		{
			_house = value;
		}
		
		public function get street():String { return _street; }
		
		public function set street(value:String):void 
		{
			_street = value;
		}*/
		
		public function get address():String { return _address; }
		
		public function set address(value:String):void 
		{
			_address = value;
		}
		
		public function get area():String { return _area; }
		
		public function set area(value:String):void 
		{
			_area = value;
		}
		
		/*public function get district():String { return _district; }
		
		public function set district(value:String):void 
		{
			_district = value;
		}*/
		
		public function get city():String { return _city; }
		public function set city(value:String):void 
		{
			_city = value;
		}
		
		public function get state():String { return _state; }
		public function set state(value:String):void 
		{
			_state = value;
		}
		
		public function get country():String { return _country; }
		public function set country(value:String):void 
		{
			_country = value;
		}
		
		public function get lat():Number { return _lat; }
		
		public function set lat(value:Number):void 
		{
			_lat = value;
		}
		
		public function get lng():Number { return _lng; }
		
		public function set lng(value:Number):void 
		{
			_lng = value;
		}
		
		public function get payPalFirstName():String 
		{
			return _payPalFirstName;
		}
		
		public function set payPalFirstName(value:String):void 
		{
			_payPalFirstName = value;
		}
		
		public function get payPalLastName():String 
		{
			return _payPalLastName;
		}
		
		public function set payPalLastName(value:String):void 
		{
			_payPalLastName = value;
		}
		
		public function get productTypeList():ShopperCategoryList 
		{
			return _productTypeList;
		}
		
		public function set productTypeList(value:ShopperCategoryList):void 
		{
			_productTypeList = value;
		}
		
	}

}