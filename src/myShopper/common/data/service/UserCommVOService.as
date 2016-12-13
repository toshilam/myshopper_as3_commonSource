package myShopper.common.data.service 
{
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.data.communication.CommVO;
	import myShopper.common.data.communication.CommVOList;
	import myShopper.common.data.communication.UserUserCommVO;
	import myShopper.common.data.communication.UserUserCommVOList;
	import myShopper.common.data.user.UserInfoVO;
	import myShopper.common.utils.DateUtil;
	import myShopper.common.utils.Tracer;
	
	/**
	 * a centralize vo service that all the remote proxies should get the data object from this service class
	 * in case of change (add/modify/delete) any of base data object properties on both server/client side
	 * @author Toshi Lam
	 */
	public class UserCommVOService 
	{
		//protected var _commInfo:CommList;
		
		public function UserCommVOService(/*inVO:CommList*/) 
		{
			/*if (!(inVO is CommList))
			{
				throw(new UninitializedError('CommVOService : unknown data type : ' + inVO));
			}
			
			
			_commInfo = inVO;*/
		}
		
		public static function getProxyMediatorID(inProxyMediatorPrefix:String, inToUID:String):String
		{
			return inProxyMediatorPrefix + inToUID;
		}
		
		public static function getUserChatMessageFromUID(inData:Object):String
		{
			return inData ? inData['u_fromUID'] : null; 
		}
		
		public static function getUserChatMessageFromName(inData:Object):String
		{
			return inData ? inData['u_fromName'] : null; 
		}
		
		public static function getUserChatMessage(inData:Object):String
		{
			return inData ? inData['u_message'] : null; 
		}
		
		public static function isVaildChatDataObj(inData:Object):Boolean
		{
			return inData['u_fromUID'] != undefined /*&& inData['u_toUID'] != undefined*/
		}
		
		public static function setCommInfo(inData:Object, inCommVOList:UserUserCommVOList):Boolean
		{
			var resultVO:ResultVO = inData as ResultVO;
			
			if (resultVO)
			{
				var data:Object = resultVO.result;
				var fromUID:String = getUserChatMessageFromUID(data);
				
				if (fromUID)
				{
					
					var commVOList:UserUserCommVOList = inCommVOList;
					//in user to user chat case, there is no fromID exist, user fromUID instead of, that will  be used for retreve vo
					commVOList.addVO( new UserUserCommVO('', resultVO.service, fromUID, getUserChatMessage(data), fromUID ) );
					
					return true;
				}
				
				Tracer.echo('UserCommVOService : setCommInfo : unable to retrieve vale fromID : ' + data, UserCommVOService, 0xff0000);
				return false;
			}
			
			Tracer.echo('CommVOService : setCommInfo : unknown data type : ' + inData, UserCommVOService, 0xff0000);
			return false;
		}
		
		public static function setAMFUserUserMessageByUID(inData:Object, inTargetUserInfo:UserInfoVO):Boolean
		{
			if (!inTargetUserInfo || !inData is Array) return false;
			
			for (var key:String in inData)
			{
				var uid:String = key;
				var arrData:Array = inData[key];
				var commVOList:UserUserCommVOList = inTargetUserInfo.chatList;
				
				if (commVOList && arrData)
				{
					commVOList.clearVO(); //clear previous stored data, but not uid, url...
					
					var numItem:int = arrData.length;
					for (var i:int = 0; i < numItem; i++)
					{
						var data:Object = arrData[i];
						
						//is myself, set empty string for fromUID 
						var fromUID:String = data['q_from_user_id'];
						if (fromUID != inTargetUserInfo.uid)
						{
							fromUID = '';
						}
						
						commVOList.addVO( new UserUserCommVO('', '', '', data['q_message'], fromUID, data['q_is_read'] == '1', DateUtil.getDateStringByUTCDateString( String(data['q_date_time']) ), data['q_no'] ) );
						
					}
					
					//define use chat history has dl from amf
					commVOList.hasDataDownloaded = true;
					
					//assume all message have been read once message data is downloaded
					commVOList.numUnRead = 0;
					
					return true;
				}
				
				
			}
			
			return false;
		}
	}

}