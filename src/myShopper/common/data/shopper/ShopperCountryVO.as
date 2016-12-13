package myShopper.common.data.shopper 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopperCountryVO extends VO
	{
		
		public var countryName:String;
		public var countryID:String;
		
		
		
		protected var _stateList:ShopperStateList;
		public function get stateList():ShopperStateList { return _stateList; }
		public function set stateList(value:ShopperStateList):void 
		{
			_stateList = value;
		}
		
		public function ShopperCountryVO
		(
			inVOID:String,
			inCountryName:String = '',
			inCountryID:String = ''
		) 
		{
			super(inVOID);
			
			countryName = inCountryName;
			countryID = inCountryID;
			
			_stateList = new ShopperStateList(_id);
		}
		
		override public function clone():IVO 
		{
			var vo:ShopperCountryVO = new ShopperCountryVO(_id, countryName);
			vo.stateList = _stateList.clone() as ShopperStateList;
			
			return vo;
		}
		
		override public function clear():void
		{
			countryName = '';
			//categoryNo = '';
			_stateList.clear();
			//_productList = null;
			//numberOfProduct = 0;
		}
		
	}

}