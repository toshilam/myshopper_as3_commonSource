package myShopper.common.data.user 
{
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IUserInfoVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserRegisterFormVO extends VO implements IUserInfoVO
	{
		//login info
		private var _email:String;
		private var _firstName:String;
		private var _lastName:String;
		private var _password:String;
		private var _password2:String;
		private var _ageRange:String;
		//personal info
		private var _sex:String;
		private var _day:String;
		private var _month:String;
		private var _year:String;
		private var _phone:String;
		//public var district:String;
		private var _address:String;
		private var _country:String;
		
		private var _interest:String; //interested product
		public var interestList:ShopperCategoryList;
		
		private var _subscribeNews:String = '1'; // 0 = not subscribe, 1 = subscribe
		
		
		public function UserRegisterFormVO
		(
			inVOID:String,
			inEmail:String = '', 
			inFirstName:String = '',
			inLastName:String = '',
			inPassword:String = '',
			inPassword2:String = '',
			inAgeRange:String = '',
			
			inSex:String = '',
			inDay:String = '',
			inMonth:String = '',
			inYear:String = '',
			inPhone:String = '',
			//inDistrict:String = '',
			inAddress:String = '',
			inCountry:String = '',
			inInterest:String = '',
			
			inSubscribeNews:String = '1'
		)
		{
			super(inVOID);
			
			email = inEmail;
			firstName = inFirstName;
			lastName = inLastName;
			password = inPassword;
			password2 = inPassword2;
			ageRange = inAgeRange;
			
			sex = inSex;
			day = inDay;
			month = inMonth;
			year = inYear;
			phone = inPhone;
			//district = inDistrict;
			address = inAddress;
			country = inCountry;
			interest = inInterest;
		}
		
		override public function clear():void
		{
			email = '';
			firstName = '';
			lastName = '';
			password = '';
			password2 = '';
			ageRange = '';
			
			sex = '';
			day = '';
			month = '';
			year = '';
			phone = '';
			//district = '';
			address = '';
			country = '';
			interest = '';
			
			if (interestList) interestList.clear();
		}
		
		public function get email():String {return _email;}
		public function set email(value:String):void 
		{
			_email = value;
		}
		
		public function get firstName():String {return _firstName;}
		public function set firstName(value:String):void 
		{
			_firstName = value;
		}
		
		public function get lastName():String 
		{
			return _lastName;
		}
		
		public function set lastName(value:String):void 
		{
			_lastName = value;
		}
		
		public function get password():String 
		{
			return _password;
		}
		
		public function set password(value:String):void 
		{
			_password = value;
		}
		
		public function get ageRange():String 
		{
			return _ageRange;
		}
		
		public function set ageRange(value:String):void 
		{
			_ageRange = value;
		}
		
		public function get sex():String 
		{
			return _sex;
		}
		
		public function set sex(value:String):void 
		{
			_sex = value;
		}
		
		public function get day():String 
		{
			return _day;
		}
		
		public function set day(value:String):void 
		{
			_day = value;
		}
		
		public function get month():String 
		{
			return _month;
		}
		
		public function set month(value:String):void 
		{
			_month = value;
		}
		
		public function get year():String 
		{
			return _year;
		}
		
		public function set year(value:String):void 
		{
			_year = value;
		}
		
		public function get phone():String 
		{
			return _phone;
		}
		
		public function set phone(value:String):void 
		{
			_phone = value;
		}
		
		public function get address():String 
		{
			return _address;
		}
		
		public function set address(value:String):void 
		{
			_address = value;
		}
		
		public function get country():String 
		{
			return _country;
		}
		
		public function set country(value:String):void 
		{
			_country = value;
		}
		
		public function get interest():String 
		{
			return _interest;
		}
		
		public function set interest(value:String):void 
		{
			_interest = value;
		}
		
		public function get subscribeNews():String 
		{
			return _subscribeNews;
		}
		
		public function set subscribeNews(value:String):void 
		{
			_subscribeNews = value;
		}
		
		public function get password2():String 
		{
			return _password2;
		}
		
		public function set password2(value:String):void 
		{
			_password2 = value;
		}
		
	}

}