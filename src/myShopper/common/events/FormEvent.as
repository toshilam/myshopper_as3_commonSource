package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IButton;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class FormEvent extends ApplicationEvent 
	{
		public static const CLOSED:String = 'closed';
		public static const USER_LOGIN:String = 'userLogin';
		public static const USER_REGISTER:String = 'userRegister';
		//public static const USER_FORGOT_PASSWORD:String = 'userForgotPassword';
		public static const USER_QUESTION_SHOP:String = 'userQuestionShop';
		public static const USER_SEND_P_FRIEND:String = 'userSendPFriend';
		public static const USER_ADD_FRIEND:String = 'userAddFriend';
		public static const USER_SHOP_TOGETHER:String = 'userShopTogether';
		
		public static const SHOP_REGISTER:String = 'shopRegister';
		
		public static const SEARCH_SHOP:String = 'searchShop';
		
		public static const SHOPPER_CONTACT_US:String = 'shopperContactUs';
		
		public static const FB_SHARE_P_FRIEND:String = 'FbSharePFriend';
		public static const FB_SHARE_S_FRIEND:String = 'FbShareSFriend';
		public static const FB_CHECKIN:String = 'FbCheckin';
		
		public static const GET_AREA:String = 'getArea';
		
		
		public function FormEvent(type:String, inDisplayObjectButton:IApplicationDisplayObject= null, inData:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			
			super(type, (inDisplayObjectButton as DisplayObject), inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ApplicationEvent(type, _targetDisplayObject, _data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FormEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}