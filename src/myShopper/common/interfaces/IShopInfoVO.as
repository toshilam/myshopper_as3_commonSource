package myShopper.common.interfaces 
{
	import myShopper.common.data.FileImageVO;
	
	/**
	 * for ShopRegisterFormVO + ShopInfoFormVO
	 * @author Toshi
	 */
	public interface IShopInfoVO extends IVO
	{ 
		function get name():String;
		function set name(inValue:String):void;
		function get intro():String;
		function set intro(inValue:String):void;
		function get productType():String;
		function set productType(inValue:String):void;
		function get phone():String;
		function set phone(inValue:String):void;
		
		//function get room():String;
		//function set room(inValue:String):void;
		//function get house():String;
		//function set house(inValue:String):void;
		//function get street():String;
		//function set street(inValue:String):void;
		
		function get address():String;
		function set address(inValue:String):void;
		
		function get payPalEmail():String;
		function set payPalEmail(inValue:String):void;
		function get payPalFirstName():String;
		function set payPalFirstName(inValue:String):void;
		function get payPalLastName():String;
		function set payPalLastName(inValue:String):void;
		function get area():String;
		function set area(inValue:String):void;
		function get city():String;
		function set city(inValue:String):void;
		//function get district():String;
		//function set district(inValue:String):void;
		function get state():String;
		function set state(inValue:String):void;
		function get country():String;
		function set country(inValue:String):void;
		
		function get lat():Number;
		function set lat(inValue:Number):void;
		function get lng():Number;
		function set lng(inValue:Number):void;
		
		function get logoFileVO():FileImageVO;
		function set logoFileVO(inValue:FileImageVO):void;
	}
	
}