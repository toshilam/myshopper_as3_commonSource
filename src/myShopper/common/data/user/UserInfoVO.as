package myShopper.common.data.user 
{
	import myShopper.common.data.communication.CommVOList;
	import myShopper.common.data.communication.UserUserCommVOList;
	import myShopper.common.data.facebook.FbFriendList;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.PrinterVO;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.VO;
	import myShopper.common.emun.FileType;
	import myShopper.common.interfaces.IUserInfoVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class UserInfoVO extends VO implements IUserInfoVO
	{
		//for other user, if its true : means user logged in system (online)
		private var _isLogged:Boolean;
		public function get isLogged():Boolean { return _isLogged; }
		public function set isLogged(value:Boolean):void 
		{
			_isLogged = value; 
			dispatchChangeEvent('isLogged', isLogged);
		}
		
		/*user data that from SQL*/
		//user number that matched with SQL user no
		private var _no:String = '';
		public function get no():String { return _no; }
		public function set no(value:String):void 
		{
			_no = value;
			dispatchChangeEvent('no', no);
		}
		
		private var _uid:String = '';
		public function get uid():String { return _uid; }
		public function set uid(value:String):void 
		{
			_uid = value;
			dispatchChangeEvent('uid', uid);
		}
		
		private var _token:String = '';
		public function get token():String {return _token;}
		public function set token(value:String):void 
		{
			_token = value;
			dispatchChangeEvent('token', token);
		}
		
		private var _lat:Number = 0;
		public function get lat():Number {return _lat;}
		public function set lat(value:Number):void 
		{
			_lat = value;
			dispatchChangeEvent('lat', lat);
		}
		
		private var _lng:Number = 0;
		public function get lng():Number {return _lng;}
		public function set lng(value:Number):void 
		{
			_lng = value;
			dispatchChangeEvent('lng', lng);
		}
		
		//login info
		private var _email:String;
		public function get email():String 	{return _email;}
		public function set email(value:String):void 
		{
			_email = value;
			dispatchChangeEvent('email', lng);
		}
		
		private var _firstName:String;
		public function get firstName():String {return _firstName;}
		public function set firstName(value:String):void 
		{
			_firstName = value;
			dispatchChangeEvent('firstName', firstName);
		}
		
		private var _lastName:String;
		public function get lastName():String {return _lastName;}
		public function set lastName(value:String):void 
		{
			_lastName = value;
			dispatchChangeEvent('lastName', lastName);
		}
		
		private var _password:String;
		public function get password():String {return _password;}
		public function set password(value:String):void 
		{
			_password = value;
			dispatchChangeEvent('password', password);
		}
		
		private var _password2:String;
		public function get password2():String {return _password2;}
		public function set password2(value:String):void 
		{
			_password2 = value;
			dispatchChangeEvent('password2', password2);
		}
		
		private var _ageRange:String;
		public function get ageRange():String {return _ageRange;}
		public function set ageRange(value:String):void 
		{
			_ageRange = value;
			dispatchChangeEvent('ageRange', ageRange);
		}
		
		//personal info
		private var _sex:String;
		public function get sex():String {return _sex;}
		public function set sex(value:String):void 
		{
			_sex = value;
			dispatchChangeEvent('sex', sex);
		}
		
		private var _day:String;
		public function get day():String {return _day;}
		public function set day(value:String):void 
		{
			_day = value;
			dispatchChangeEvent('day', day);
		}
		
		private var _month:String;
		public function get month():String {return _month;}
		public function set month(value:String):void 
		{
			_month = value;
			dispatchChangeEvent('month', month);
		}
		
		
		private var _year:String;
		public function get year():String {return _year;}
		public function set year(value:String):void 
		{
			_year = value;
			dispatchChangeEvent('year', year);
		}
		
		
		private var _phone:String;
		public function get phone():String {return _phone;}
		public function set phone(value:String):void 
		{
			_phone = value;
			dispatchChangeEvent('phone', phone);
		}
		
		
		private var _address:String;
		public function get address():String {return _address;}
		public function set address(value:String):void 
		{
			_address = value;
			dispatchChangeEvent('address', address);
		}
		
		
		private var _country:String;
		public function get country():String {return _country;}
		public function set country(value:String):void 
		{
			_country = value;
			dispatchChangeEvent('country', country);
		}
		
		
		private var _interest:String;
		public function get interest():String {return _interest;}
		public function set interest(value:String):void 
		{
			_interest = value;
			dispatchChangeEvent('interest', interest);
		}
		
		private var _subscribeNews:String; // 0 = not subscribe, 1 = subscribe
		public function get subscribeNews():String {return _subscribeNews;}
		public function set subscribeNews(value:String):void 
		{
			_subscribeNews = value;
			dispatchChangeEvent('subscribeNews', subscribeNews);
		}
		
		private var _activated:String; // 0 = not activated, 1 = activated
		public function get activated():String {return _activated;}
		public function set activated(value:String):void 
		{
			_activated = value;
			dispatchChangeEvent('activated', activated);
		}
		
		
		//current status
		private var _status:String;
		public function get status():String {return _status;}
		public function set status(value:String):void 
		{
			_status = value;
			dispatchChangeEvent('status', status);
		}
		
		//to indicate whather the shop has already register under this user
		private var _isShopExist:Boolean;
		public function get isShopExist():Boolean {return _isShopExist;}
		public function set isShopExist(value:Boolean):void 
		{
			_isShopExist = value; 
			dispatchChangeEvent('isShopExist', isShopExist);
		}
		
		//record list storing paid order info (include received or non received order)
		private var _shoppingRecordList:UserShoppingRecordList;
		public function get shoppingRecordList():UserShoppingRecordList { return _shoppingRecordList; }
		
		private var _shoppingCartList:UserShoppingCartList;
		public function get shoppingCartList():UserShoppingCartList { return _shoppingCartList; }
		
		//user checkout vo for storing shopping info
		private var _checkoutVO:UserCheckOutVO;
		public function get checkoutVO():UserCheckOutVO { return _checkoutVO; }
		
		//user logo image
		private var _logoFileVO:FileImageVO = null;
		public function get logoFileVO():FileImageVO { return _logoFileVO; }
		
		//user bg image
		private var _bgFileVO:FileImageVO = null;
		public function get bgFileVO():FileImageVO { return _bgFileVO; }
		
		//user album list
		private var _albumList:UserAlbumList;
		public function get albumList():UserAlbumList { return _albumList; }
		
		//user friend list (shopper)
		private var _friendList:UserFriendList;
		public function get friendList():UserFriendList { return _friendList; }
		
		//user friend list (facebook)
		private var _fbFriendList:FbFriendList;
		public function get fbFriendList():FbFriendList { return _fbFriendList; }
		
		//any request which is not confirm will be stored in
		private var _requestList:UserRequestList;
		public function get requestList():UserRequestList { return _requestList; }
		
		//comm list contains all chat data between me and this user
		private var _chatList:UserUserCommVOList;
		public function get chatList():UserUserCommVOList { return _chatList; }
		
		private var _interestList:ShopperCategoryList;
		public function get interestList():ShopperCategoryList { return _interestList; }
		
		private var _printerVO:PrinterVO;
		public function get printerVO():PrinterVO { return _printerVO; }
		
		public function UserInfoVO(inVOID:String) 
		{
			super(inVOID);
			
			_shoppingCartList = new UserShoppingCartList(_id);
			_shoppingRecordList = new UserShoppingRecordList(_id);
			_checkoutVO = new UserCheckOutVO(_id);
			
			_logoFileVO = new FileImageVO(_id, null);
			_bgFileVO = new FileImageVO(_id, null);
			_albumList = new UserAlbumList(_id);
			_friendList = new UserFriendList(_id);
			_fbFriendList = new FbFriendList(_id);
			_requestList = new UserRequestList(_id);
			_chatList = new UserUserCommVOList(_id);
			_interestList = new ShopperCategoryList(_id);
			
			_printerVO = new PrinterVO(_id);
			
			clear();
			
			_logoFileVO.path = FileType.PATH_USER_LOGO;
			_bgFileVO.path = FileType.PATH_USER_BG;
		}
		
		override public function clear():void
		{
			isLogged = false;
			
			no = '';
			uid = '';
			token = '';
			
			lat = 0;
			lng = 0;
			
			email = '';
			firstName = '';
			lastName = '';
			password = '';
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
			
			subscribeNews = '0'
			activated = '0';
			
			status = '';
			
			isShopExist = false;
			
			_logoFileVO.clear();
			_bgFileVO.clear();
			//_logoFileVO = null;
			
			_shoppingCartList.clear();
			_shoppingRecordList.clear();
			_checkoutVO.clear();
			//shoppingCartList = null;
			
			_albumList.clear();
			//_albumList = null;
			
			_friendList.clear();
			_fbFriendList.clear();
			_requestList.clear();
			_chatList.clear();
			_interestList.clear();
			
			_printerVO.clear();
		}
		
		
	}

}