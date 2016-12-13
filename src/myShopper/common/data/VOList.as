package myShopper.common.data 
{
	import flash.events.EventDispatcher;
	import myShopper.common.events.VOEvent;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	[Event(name = "voAdded", type = "myShopper.common.events.VOEvent")] 
	[Event(name = "voRemoved", type = "myShopper.common.events.VOEvent")] 
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class VOList extends VO implements IVO
	{
		protected var _arrVO:Vector.<IVO>;
		public function get arrVO():Vector.<IVO> 
		{
			return _arrVO;
		}
		
		protected var _lastAddedVOIndex:uint;
		public function get lastAddedVOIndex():uint { return _lastAddedVOIndex; }
		
		//protected var _length:uint;
		public function get length():uint { return arrVO.length; }
		
		
		
		
		public function VOList(inID:String) 
		{
			
			super(inID);
			_arrVO = new Vector.<IVO>();
			
		}
		
		override public function clear():void 
		{
			/*var totalVO:int = arrVO.length;
			for (var i:uint = 0; i < totalVO; i++)
			{
				arrVO.splice(i,1);
			}*/
			_lastAddedVOIndex = /*_length =*/ arrVO.length = 0;
			
			
		}
		
		override public function clone():IVO 
		{
			var nVOList:VOList = new VOList(_id);
			for (var i:int = 0; i < _arrVO.length; i++)
			{
				var vo:IVO = _arrVO[i];
				if (vo)
				{
					nVOList.addVO( vo.clone() );
				}
			}
			
			return nVOList;
		}
		
		public function addVO(inVO:IVO):uint
		{
			if (!inVO)
			{
				Tracer.echo(this + ' : VOList : addVO : unknown data type : ' + inVO);
				return 0;
			}
			
			_lastAddedVOIndex = arrVO.push(inVO) - 1;
			dispatchEvent(new VOEvent(VOEvent.VO_ADDED, null, inVO));
			return length;
		}
		
		public function removeVO(inVO:IVO):IVO
		{
			var voIndex:int = arrVO.indexOf(inVO);
			
			if (voIndex != -1)
			{
				var vo:IVO = arrVO.splice(voIndex, 1)[0] as IVO;
				dispatchEvent(new VOEvent(VOEvent.VO_REMOVED, null, vo));
				return vo;
			}
			
			/*for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (arrVO[i] === inVO) 
				{
					var vo:IVO = arrVO.splice(i, 1)[0] as IVO;
					dispatchEvent(new VOEvent(VOEvent.VO_REMOVED, null, vo));
					return vo;
				}
			}*/
			
			return null;
		}
		
		public function removeVOByID(inVOID:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (arrVO[i].id == inVOID) 
				{
					var vo:IVO = arrVO.splice(i, 1)[0] as IVO;
					dispatchEvent(new VOEvent(VOEvent.VO_REMOVED, null, vo));
					return vo;
				}
			}
			
			return null;
		}
		
		public function removeAllVO():void
		{
			while (_arrVO.length)
			{
				removeVO(arrVO[0]);
			}
		}
		
		public function getVO(inVOIndex:uint):IVO
		{
			if (inVOIndex >= arrVO.length) return null;
			return arrVO[inVOIndex];
		}
		
		public function getVOByID(inVOID:String):IVO
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (arrVO[i].id == inVOID) return arrVO[i];
			}
			
			return null;
		}
		
		public function hasVO(inVOID:String):Boolean
		{
			for (var i:uint = 0; i < arrVO.length; i++)
			{
				if (arrVO[i].id == inVOID) return true;
			}
			
			return false;
		}
		
	}

}