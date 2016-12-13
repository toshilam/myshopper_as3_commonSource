package myShopper.common.interfaces 
{
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public interface IUserInfoVO extends IVO
	{
		//private var _email:String;
		//private var _firstName:String;
		//private var _lastName:String;
		//private var _password:String;
		//public var password2:String;
		//private var _ageRange:String;
		//personal info
		//private var _sex:String;
		//private var _day:String;
		//private var _month:String;
		//private var _year:String;
		//private var _phone:String;
		//public var district:String;
		//private var _address:String;
		//private var _country:String;
		//private var _interest:String;
		
		//private var _subscribeNews:String = '1';
		
		function get email():String 
		function set email(value:String):void 
		
		function get firstName():String
		function set firstName(value:String):void 
		
		function get lastName():String 
		function set lastName(value:String):void 
		
		function get password():String 
		function set password(value:String):void 
		
		function get password2():String 
		function set password2(value:String):void 
		
		function get ageRange():String 
		function set ageRange(value:String):void 
		
		function get sex():String 
		function set sex(value:String):void 
		
		function get day():String 
		function set day(value:String):void 
		
		function get month():String 
		function set month(value:String):void 
		
		function get year():String 
		function set year(value:String):void 
		
		function get phone():String 
		function set phone(value:String):void 
		
		function get address():String 
		function set address(value:String):void 
		
		function get country():String 
		function set country(value:String):void 
		
		function get interest():String 
		function set interest(value:String):void 
		
		
		function get subscribeNews():String 
		function set subscribeNews(value:String):void 
		
	}
	
}