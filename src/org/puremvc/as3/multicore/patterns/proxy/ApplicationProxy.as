package org.puremvc.as3.multicore.patterns.proxy 
{
	import myShopper.common.emun.AssetLibID;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IModuleMain;
	import myShopper.common.resources.SettingManager;
	import myShopper.common.resources.XMLManager;
	import myShopper.common.utils.Tracer;
	import org.puremvc.as3.multicore.interfaces.IApplicationProxy;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * A proxy
	 */
	public class ApplicationProxy extends Proxy implements IApplicationProxy 
	{
		
		public static const NAME:String = "ApplicationProxy";
		
		protected var _host:IModuleMain;
		public function get host():IModuleMain { return _host; }
		
		public function ApplicationProxy(inName:String, inData:Object = null) 
		{
			super(inName, inData);
			if (!(inData is IModuleMain)) 
			{
				Tracer.echo(NAME + ' : invaild data object set : only IModuleMain is excepted : ' + inData, this, 0xff0000);
			}
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			echo('onRegister.');
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			echo('onRemove.');
		}
		
		override public function setData(data:Object):void 
		{
			if (data is IModuleMain) _host = data as IModuleMain;
			else super.setData(data);
		}
		
		/**
		 * send a notification to a targeted mediator
		 * @param	inTargetMediatorName - the target mediator's name
		 * @param	notificationName 
		 * @param	body
		 * @param	type
		 * @return  true if successfully send
		 */
		public function sendNotificationToMediator(inTargetMediatorName:String, notificationName:String, body:Object = null, type:String = null):Boolean
		{
			if (facade.hasMediator(inTargetMediatorName))
			{
				facade.retrieveMediator(inTargetMediatorName).handleNotification(new Notification(notificationName, body, type));
				return true;
			}
			
			echo('sendNotificationToMediator : target mediator is not found : ' + inTargetMediatorName);
			return false;
		}
		
		
		public function initAsset(inAsset:Object = null):void
		{
			
		}
		
		public function getPlatform():String
		{
			return platform;
		}
		
		protected function get prefixURL():String
		{
			return isModuleMain() ? _host.setupVO.prefixURL : null;
		}
		
		protected function get language():String
		{
			return isModuleMain() ? _host.setupVO.language : null;
		}
		
		protected function get country():String
		{
			return isModuleMain() ? settingManager.getAsset(SettingManager.COUNTRY) : null;
		}
		
		protected function get state():String
		{
			return isModuleMain() ? settingManager.getAsset(SettingManager.STATE) : null;
		}
		
		protected function get city():String
		{
			return isModuleMain() ? settingManager.getAsset(SettingManager.CITY) : null;
		}
		
		protected function get platform():String
		{
			return isModuleMain() ? settingManager.getAsset(SettingManager.PLATFORM) : null;
		}
		
		protected function get assetManager():IDataManager
		{
			return isModuleMain() ? _host.assetManager : null;
		}
		
		protected function get xmlManager():IDataManager
		{
			return isModuleMain() ? _host.xmlManager : null;
		}
		
		protected function get settingManager():IDataManager
		{
			return isModuleMain() ? _host.settingManager : null;
		}
		
		protected function get voManager():IDataManager
		{
			return isModuleMain() ? _host.voManager : null;
		}
		
		protected function get serviceManager():IDataManager
		{
			return isModuleMain() ? _host.serviceManager : null;
		}
		
		protected function isModuleMain():Boolean
		{
			return _host is IModuleMain;
		}
		
		protected function echo(inMessage:Object, inTarget:Object = null, inColor:uint = 0xff0000):void
		{
			Tracer.echo
			(
				multitonKey + ' : ' + proxyName + " : " + inMessage, 
				inTarget ? inTarget : this,
				inColor
			);
		}
		
		/**
		 * NOTE : xml formet is supposed to be : (data / string)
		 * @param	inID - the targeted node attribute id
		 * @param	inNodeName - target node name
		 * @param	inAssetLibID - aseet lib id 
		 * @return message if found else null
		 */
		public function getMessage(inID:String, inNodeName:String = 'string', inAssetLibID:String = 'langCommon'):String
		{
			if (!xmlManager) return null;
			
			return (xmlManager as XMLManager).getString(inID, inNodeName, inAssetLibID);
			
			/*var xmlList:XMLList = xmlManager.getData(inNodeName, inAssetLibID);
			if (xmlList && xmlList.length())
			{
				var xml:XML = xmlList.(@id == inID)[0];
				if (xml)
				{
					return xml.toString();
				}
				
				echo('getMessage : target xml node not found!', this, 0xff0000);
				
			}
			else
			{
				echo('getMessage : no data found!', this, 0xff0000);
			}
			
			return '';*/
		}
		
		
		protected var _httpHost:String = null;
		public function get httpHost():String
		{
			if (!xmlManager) return null;
			
			if (!_httpHost)
			{
				var xml:XML = xmlManager.getData('services', AssetLibID.XML_COMMON)[0];
				if (xml)
				{
					var tragetNode:XML = xml.*.(@id == 'http')[0];
					
					if (tragetNode)
					{
						_httpHost = tragetNode.@host.toString();
						return _httpHost;
					}
					
					echo('httpHost : target xml node not found!', this, 0xff0000);
					
				}
				else
				{
					echo('httpHost : no data found!', this, 0xff0000);
				}
				
				return '';
			}
			
			
			return _httpHost;
		}
	}
}