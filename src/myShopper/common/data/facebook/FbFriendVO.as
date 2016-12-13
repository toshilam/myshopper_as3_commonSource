package myShopper.common.data.facebook 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.ISelectableVO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FbFriendVO extends VO implements ISelectableVO
	{
		//to be used for identifing is this fb user is selcted for some suppuse
		private var _isSelected:Boolean;
		
		public var name:String;
		
		public function FbFriendVO(inID:String) 
		{
			//fb id will be used as this vo id
			super(inID);
			name = '';
			isSelected = false;
		}
		
		override public function clear():void 
		{
			isSelected = false;
			name = '';
			_id = '';
		}
		
		override public function clone():IVO 
		{
			var vo:FbFriendVO = new FbFriendVO(_id);
			vo.name = name;
			vo.isSelected = isSelected;
			
			return vo;
		}
		
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