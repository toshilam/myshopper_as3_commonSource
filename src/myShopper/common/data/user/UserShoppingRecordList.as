package myShopper.common.data.user 
{
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShoppingRecordList extends UserShoppingCartList 
	{
		//id = order no
		public function UserShoppingRecordList(inVOID:String) 
		{
			super(inVOID);
			
		}
		
		override public function addVO(inVO:IVO):uint 
		{
			if (!(inVO is UserShoppingRecordVO))
			{
				Tracer.echo('UserShoppingRecordList : addVO : unknown data type : ' + inVO, this, 0xff0000);
				return 0;
			}
			
			return super.addVO(inVO);
		}
	}

}