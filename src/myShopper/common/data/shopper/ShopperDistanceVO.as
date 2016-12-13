package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperDistanceVO extends VO implements ISelectableVO
	{
		private var _isSelected:Boolean;
		//No from DB, and will be used as VO ID
		public var distance:Number;
		public var distanceName:String;
		
		
		
		public function ShopperDistanceVO
		(
			inVOID:String, 
			inDistance:Number = -1,
			inDistanceName:String = ''
		) 
		{
			super(inVOID);
			
			distance = inDistance
			distanceName = inDistanceName;
			
			_isSelected =  false;
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperDistanceVO = new ShopperDistanceVO
			(
				_id,
				distance,
				distanceName
			);
			
			vo.isSelected = _isSelected;
			return vo;
		}
		
		override public function clear():void
		{
			distance = -1
			distanceName = '';
			_isSelected = false;
		}
		
		/* INTERFACE myShopper.common.interfaces.ISelectableVO */
		
		public function get isSelected():Boolean 
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void 
		{
			_isSelected = value;
		}
	}

}