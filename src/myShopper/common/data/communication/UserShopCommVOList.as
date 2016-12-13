package myShopper.common.data.communication 
{
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShopCommVOList extends CommVOList 
	{
		public var userName:String;
		public var userID:String;
		public var imageURL:String;
		private var _numUnRead:int;
		
		public function UserShopCommVOList(inID:String, inUserName:String = '', inUserID:String = '', inImageURL:String = '') 
		{
			super(inID);
			userName = inUserName;
			imageURL = inImageURL;
			userID = inUserID;
		}
		
		override public function clear():void 
		{
			super.clear();
			userID = imageURL = userName = '';
		}
		
		public function clearVO():void
		{
			super.clear();
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is UserShopCommVO))
			{
				Tracer.echo('ShopOrderList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
		
		public function get numUnRead():int 
		{
			return _numUnRead;
		}
		
		public function set numUnRead(value:int):void 
		{
			_numUnRead = value;
			dispatchChangeEvent('numUnRead', numUnRead);
		}
		
		/*public function get numUnRead():int
		{
			var numUnRead:int = 0;
			var numItem:int = _arrVO.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var vo:UserShopCommVO = arrVO[i] as UserShopCommVO;
				if (vo)
				{
					if (!vo.isRead)
					{
						numUnRead++;
					}
				}
			}
			
			return numUnRead;
		}*/
	}

}