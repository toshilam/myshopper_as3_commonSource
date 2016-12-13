package myShopper.common.data.service 
{
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.data.communication.CommList;
	import myShopper.common.data.communication.CommVO;
	import myShopper.common.data.communication.CommVOList;
	import myShopper.common.data.communication.UserShopCommList;
	import myShopper.common.data.communication.UserShopCommVO;
	import myShopper.common.data.communication.UserShopCommVOList;
	import myShopper.common.data.user.UserInfoList;
	import myShopper.common.data.user.UserInfoVO;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.DateUtil;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	
	/**
	 * a centralize vo service that all the remote proxies should get the data object from this service class
	 * in case of change (add/modify/delete) any of base data object properties on both server/client side
	 * @author Toshi Lam
	 */
	public class CommVOService 
	{
		protected var _commInfo:CommList;
		
		public function CommVOService(inVO:CommList) 
		{
			if (!(inVO is CommList))
			{
				throw(new UninitializedError('CommVOService : unknown data type : ' + inVO));
			}
			
			
			_commInfo = inVO;
		}
		
		public static function isVaildChatDataObj(inData:Object):Boolean
		{
			return inData['isShop'] != undefined && inData['fromUID'] != undefined
		}
		
		public static function isChatDataObjByShop(inData:Object):Boolean
		{
			return inData['isShop'] === true;
		}
		
		public static function getShopToUserDataObj(inToUID:String, inData:Object):Object
		{
			return { isShop:true, toUID:inToUID, data:inData };
		}
		
		public static function getUserToShopDataObj(inToUID:String, inData:Object):Object
		{
			return { isShop:false, toUID:inToUID, data:inData }
		}
		
		/*public static function getFromIDByFMSDataObj(inData:Object):String
		{
			if (inData)
			{
				return inData['fromID'];
			}
			
			Tracer.echo('CommVOService : getFromIDByFMSDataObj : unable to retrieve fromID from FMS data object', CommVOService, 0xff0000);
			return '';
		}*/
		
		public static function getFromUIDByFMSDataObj(inData:Object):String
		{
			if (inData)
			{
				return inData['fromUID'];
			}
			
			Tracer.echo('CommVOService : getFromUIDByFMSDataObj : unable to retrieve fromUID from FMS data object', CommVOService, 0xff0000);
			return '';
		}
		
		public static function getDataByFMSDataObj(inData:Object):String
		{
			if (inData)
			{
				return inData['data'];
			}
			
			Tracer.echo('CommVOService : getDataByFMSDataObj : unable to retrieve data from FMS data object', CommVOService, 0xff0000);
			return '';
		}
		
		public function clear():void
		{
			_commInfo = null;
		}
		
		/**
		 * to retrieve target comm vo list by fms id
		 * @param	inFMSID - the traget user fms id
		 * @param	inIsAutoCreate - default true : auto create comm vo list if the target user comm vo list is not created, else return null
		 * @return  target comm vo list
		 */
		public function getCommVOListByUID(inUID:String, inIsAutoCreate:Boolean = true):CommVOList
		{
			var commVOList:CommVOList = _commInfo.getVOByID(inUID) as CommVOList;
			
			if (!commVOList && inIsAutoCreate)
			{
				commVOList = new CommVOList(inUID);
				_commInfo.addVO(commVOList);
			}
			
			return commVOList;
		}
		
		public function setCommInfo(inData:Object):IVO
		{
			var resultVO:ResultVO = inData as ResultVO;
			
			if (resultVO)
			{
				var data:Object = resultVO.result;
				var fromUID:String = getFromUIDByFMSDataObj(data);
				//var fromFMSID:String = getFromIDByFMSDataObj(data);
				
				//if (fromFMSID)
				//{
					
					var commVOList:CommVOList = getCommVOListByUID(fromUID, true);
					
					commVOList.addVO( new CommVO('', resultVO.service, fromUID, getDataByFMSDataObj(data), fromUID ) );
					
					return commVOList;
				//}
				
				Tracer.echo('CommVOService : setCommInfo : unable to retrieve vale fromID : ' + data, this, 0xff0000);
				return null;
			}
			
			Tracer.echo('CommVOService : setCommInfo : unknown data type : ' + inData, this, 0xff0000);
			return null;
		}
		
		//the total user shop message that are not read yet
		public function setAMFUserShopNumReadMessage(inData:Object):Boolean
		{
			if (!(_commInfo is UserShopCommList) || (!inData && !inData['q_num_unread'])) return false;
			
			UserShopCommList(_commInfo).numUnRead = inData['q_num_unread'];
			return true;
		}
		
		//number of unread message from a user
		public function setAMFUserShopUserNumReadMessage(inData:Object, inFromUID:String):Boolean
		{
			if (!(_commInfo is UserShopCommList) || (!inData && !inData['q_num_unread'])) return false;
			
			var commVOList:UserShopCommVOList = _commInfo.getVOByID(inFromUID) as UserShopCommVOList;
			if (commVOList)
			{
				commVOList.numUnRead = inData['q_num_unread'];
				return true;
			}
			
			return false;
		}
		
		public function setAMFUserShopMessageUserList(inData:Object):Boolean
		{
			if (!(_commInfo is UserShopCommList) || !inData is Array) return false;
			
			var totalUnRead:int = 0;
			
			for (var key:String in inData)
			{
				var uid:String = key;
				var userData:Object = inData[key];
				
				
				var commVOList:UserShopCommVOList = _commInfo.getVOByID(uid) as UserShopCommVOList;
				var userName:String = userData && userData['u_name'] ? userData['u_name'] : '';
				var numUnRead:int = userData && userData['q_num_unread'] ? userData['q_num_unread'] : 0;
				if (!commVOList)
				{
					
					//var userID:String = userData && userData['u_id'] ? userData['u_id'] : '';
					
					commVOList = new UserShopCommVOList(uid, userName, uid);
					
					
					_commInfo.addVO(commVOList);
				}
				
				commVOList.numUnRead = numUnRead;
				
				totalUnRead += numUnRead;
			}
			
			UserShopCommList(_commInfo).numUnRead = totalUnRead;
			
			return true;
		}
		
		public function setAMFUserShopMessageByUID(inData:Object):Boolean
		{
			if (!(_commInfo is UserShopCommList) || !inData is Array) return false;
			
			for (var key:String in inData)
			{
				var uid:String = key;
				var arrData:Array = inData[key];
				
				var commVOList:UserShopCommVOList = _commInfo.getVOByID(uid) as UserShopCommVOList;
				
				if (commVOList)
				{
					commVOList.clearVO(); //clear previous stored data, but not uid, url...
					
					var numItem:int = arrData.length;
					for (var i:int = 0; i < numItem; i++)
					{
						var data:Object = arrData[i];
						
						commVOList.addVO
						( 
							new UserShopCommVO
							(
								data['q_no'], 
								'', 
								'', 
								Tools.replaceRestrictedString(data['q_message']), 
								data['q_from_user_id'], 
								data['q_is_read'] == '1', 
								data['q_is_shop'] == '1', 
								DateUtil.getDateStringByUTCDateString( String(data['q_date_time']) ), 
								data['q_no'] 
							)
						);
						
					}
					
					return true;
				}
				
				
			}
			
			return false;
		}
		
		public function setAMFUserShopMessage(inData:Object):Boolean
		{
			if (!inData is Array) return false;
			
			for (var key:String in inData)
			{
				var uid:String = key;
				var arrData:Array = inData[key];
				
				
				
				if (arrData && arrData.length)
				{
					var userData:Object = arrData['q_user_info']
					var commVOList:UserShopCommVOList = _commInfo.getVOByID(uid) as UserShopCommVOList;
					
					if (!commVOList)
					{
						var userName:String = userData && userData['u_first_name'] ? userData['u_first_name'] : '';
						var userID:String = userData && userData['u_id'] ? userData['u_id'] : '';
						
						commVOList = new UserShopCommVOList(uid, userName, userID);
						
						_commInfo.addVO(commVOList);
					}
					
					var numItem:int = arrData.length;
					for (var i:int = 0; i < numItem; i++)
					{
						var data:Object = arrData[i];
						
						commVOList.addVO( new UserShopCommVO(data['q_no'], '', '', data['q_message'], data['q_from_user_id'], data['q_is_read'] == '1', data['q_is_shop'] == '1', DateUtil.getDateStringByUTCDateString( String(data['q_date_time']) ), data['q_no'] ) );
						
					}
					
				}
				
			}
			
			return true;
		}
		
	}

}