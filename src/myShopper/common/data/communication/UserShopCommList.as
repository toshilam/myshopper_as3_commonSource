package myShopper.common.data.communication 
{
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShopCommList extends CommList 
	{
		//this value set by dataProxy
		private var _numUnRead:int = 0;
		
		public function UserShopCommList(inID:String) 
		{
			super(inID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is UserShopCommVOList)) 
			{
				Tracer.echo('UserShopCommVOList : addVO : unknown data type : ' + inVO, this, 0xff0000);
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
	}

}