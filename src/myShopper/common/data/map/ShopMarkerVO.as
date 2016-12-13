package myShopper.common.data.map 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopMarkerVO extends AreaMarkerVO
	{
		//user id = owner id
		public var uid:String = '';
		public var no:String = '';
		public var phone:String = '';
		public var productType:String = '';
		public var intro:String = '';
		//public var room:String = '';
		//public var house:String = '';
		//public var street:String = '';
		public var address:String = '';
		//public var areaNo:String = '';
		public var createDate:String = '';
		
		public function ShopMarkerVO
		(
			inVOID:String, 
			inName:String = '', 
			inID:String = '', 
			inLat:Number = 0, 
			inLng:Number = 0, 
			inIcon:DisplayObject = null, 
			inMarkerType:String = '', 
			inVisibleLevel:int = -1
		) 
		{
			super(inVOID, inName, inID, inLat, inLng, inIcon, inMarkerType, inVisibleLevel);
			
		}
		
		override public function clear():void 
		{
			super.clear();
			no = phone = productType = intro = address = /*room = house = street =*/ /*areaNo =*/ createDate = '';
			
		}
	}

}