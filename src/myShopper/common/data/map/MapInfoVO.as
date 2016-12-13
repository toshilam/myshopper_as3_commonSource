package myShopper.common.data.map 
{
	import myShopper.common.data.user.UserInfoVO;
	import myShopper.common.data.VO;
	import myShopper.common.data.VOList;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class MapInfoVO extends VO
	{
		private var _districtList:VOList;
		public function get districtList():VOList { return _districtList }
		
		private var _areaList:AreaMarkerVOList;
		public function get areaList():AreaMarkerVOList { return _areaList }
		
		private var _shopList:ShopMarkerVOList;
		public function get shopList():ShopMarkerVOList { return _shopList }
		
		private var _userList:VOList;
		public function get userList():VOList { return _userList }
		
		private var _myUser:IVO; //MyUserMarkerVO
		public function get myUser():IVO { return _myUser }
		public function set myUser(value:IVO):void 
		{
			_myUser = value;
		}
		
		public function MapInfoVO(inVOID:String) 
		{
			super(inVOID);
			_areaList = new AreaMarkerVOList(_id);
			_districtList = new VOList(_id);
			_shopList = new ShopMarkerVOList(_id);
			_userList = new VOList(_id);
			
			_myUser = new VO(_id);
		}
		
		
	}

}