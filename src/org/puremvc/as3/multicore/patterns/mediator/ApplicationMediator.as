package org.puremvc.as3.multicore.patterns.mediator 
{
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import myShopper.common.Config;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.display.Image;
	import myShopper.common.emun.AMFServicesErrorID;
	import myShopper.common.emun.AssetLibID;
	import myShopper.common.emun.FileType;
	import myShopper.common.emun.MessageID;
	import myShopper.common.emun.SWFClassID;
	import myShopper.common.events.FileEvent;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IModuleMain;
	import myShopper.common.resources.SettingManager;
	import myShopper.common.resources.SoundManager;
	import myShopper.common.resources.XMLManager;
	import myShopper.common.text.Font;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	import org.puremvc.as3.multicore.interfaces.IApplicationMediator;
	/**
	 * ...
	 * @author Macentro
	 */
	public class ApplicationMediator extends Mediator implements IApplicationMediator
	{
		protected var _mainStage:Stage;
		public function get mainStage():Stage 
		{ 
			if (!_mainStage) _mainStage = ApplicationDisplayObject(container.view).stage;
			return _mainStage; 
		}
		
		public function ApplicationMediator(inMediatorName:String = null, inViewComponent:IModuleMain = null) 
		{
			super(inMediatorName, inViewComponent);
		}
		
		override public function onRegister():void 
		{
			super.onRegister();
			echo('onRegister.', this, 0xff0000);
		}
		
		override public function onRemove():void 
		{
			super.onRemove();
			echo('onRemove.', this, 0xff0000);
		}
		
		protected function get container():IModuleMain
		{
			return viewComponent as IModuleMain;
		}
		
		protected function get country():String
		{
			return settingManager.getAsset(SettingManager.COUNTRY);
		}
		
		protected function get city():String
		{
			return settingManager.getAsset(SettingManager.CITY);
		}
		
		protected function get platform():String
		{
			return settingManager.getAsset(SettingManager.PLATFORM);
		}
		
		protected function get assetManager():IDataManager
		{
			return container.assetManager;
		}
		
		protected function get xmlManager():IDataManager
		{
			return container.xmlManager;
		}
		
		protected function get settingManager():IDataManager
		{
			return container.settingManager;
		}
		
		protected function get voManager():IDataManager
		{
			return container.voManager;
		}
		
		protected function get serviceManager():IDataManager
		{
			return container.serviceManager;
		}
		
		protected function get soundManager():IDataManager
		{
			return container.soundManager;
		}
		
		protected function get language():String
		{
			return container.setupVO.language;
		}
		
		protected function get prefixURL():String
		{
			return container.setupVO.prefixURL;
		}
		
		protected function echo(inMessage:Object, inTarget:Object = null, inColor:uint = 0xff0000):void
		{
			Tracer.echo
			(
				multitonKey + ' : ' + mediatorName + " : " + inMessage, 
				inTarget ? inTarget : this,
				inColor
			);
		}
		
		protected function playSound(inDataIDs:Array, inAssetID:String, inVolLevel:Number = -1, inStartTime:Number = 0, inLoop:int = 0):void
		{
			(soundManager as SoundManager).playSound(inDataIDs, inAssetID,  inVolLevel, inStartTime, inLoop );
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
		
		public function getMessageByErrorCode(inErrorCode:String, inNodeName:String = 'string', inAssetLibID:String = 'langCommon'):String
		{
			var id:String;
			
			switch(inErrorCode)
			{
				case AMFServicesErrorID.MISS_DATA: 		id = MessageID.FORM_MISSING_DATA; 		break;
				case AMFServicesErrorID.CALL_FAIL: 		id = MessageID.ERROR_GET_DATA; 			break;
				case AMFServicesErrorID.CREATE_DATA: 	id = MessageID.ERROR_GET_DATA; 			break;
				case AMFServicesErrorID.INVALID_DATA: 	id = MessageID.FORM_MISSING_INFO; 		break;
				case AMFServicesErrorID.DUPLICATE_DATA: id = MessageID.ERROR_DUPLICATED_DATA; 	break;
				default: 
				{
					echo('getMessageByErrorCode : no matched error found : ' + inErrorCode);
					return '';
				}
			}
			
			return getMessage(id, inNodeName, inAssetLibID);
		}
		
		private var _arrLoadingImage:Dictionary = new Dictionary();
		/**
		 * 
		 * @param	inImage - image loader object
		 * @param	inURL - url
		 * @param	inImageType - type of image to be replace with, it will be used when defined image not found
		 * @param	inAutoSet - to handle loading error if set to true
		 * @param	inForceLoad - 
		 * @return
		 */
		public function loadURLImage(inImage:Image, inURL:String, inImageType:String, inAutoSet:Boolean = true, inForceLoad:Boolean = false):Boolean
		{
			if (!inForceLoad && inImage.isLoaded) 
			{
				echo('image already loaded : ' + inURL);
				return false;
			}
			
			if (inAutoSet)
			{
				//user image object as key / type as value;
				_arrLoadingImage[inImage] = inImageType;
				inImage.addEventListener(FileEvent.IO_ERROR, imageHandler, false, 0, true);
				inImage.addEventListener(FileEvent.COMPLETE, imageHandler, false, 0, true);
			}
			
			try
			{
				inImage.load( inURL );
			}
			catch (e:Error)
			{
				delete _arrLoadingImage[inImage];
				inImage.removeEventListener(FileEvent.IO_ERROR, imageHandler);
				inImage.removeEventListener(FileEvent.COMPLETE, imageHandler);
				Tracer.echo(mediatorName + ' : loadURLImage : ' + e.message, this, 0xff0000);
			}
			
			return true;
		}
		
		protected function imageHandler(e:FileEvent):void 
		{
			var image:Image = e.loader as Image;
			if (image)
			{
				image.removeEventListener(FileEvent.IO_ERROR, imageHandler);
				image.removeEventListener(FileEvent.COMPLETE, imageHandler);
				
				
				var replaceImageType:String = _arrLoadingImage[image];
				delete _arrLoadingImage[image];
				
				if (e.type == FileEvent.IO_ERROR)
				{
					var classID:String = getClassIDByImageType(replaceImageType);
					if (classID)
					{
						image.setInfo
						(
							new FileImageVO
							(
								'', 
								(assetManager.getData(classID, AssetLibID.AST_COMMON) as ApplicationDisplayObject).cloneAsByte()
							)
						);
					}
				}
				
			}
			
			function getClassIDByImageType(inImageType:String):String
			{
				switch(inImageType)
				{
					case FileType.PATH_USER_LOGO:		return SWFClassID.NO_IMAGE_50;
					case FileType.PATH_SHOP_LOGO:		return SWFClassID.NO_IMAGE_50;
					case FileType.PATH_IMAGE_SIZE_100:	return SWFClassID.NO_IMAGE_100;
					
				}
				
				return null;
			}
		}
		
		public function startListener():void 
		{
			
		}
		
		public function stopListener():void 
		{
			
		}
		
		//TODO : to be improved
		public function setTextField(inTextField:TextField, inEmbed:Boolean = false, inData:TextFormat = null):TextField
		{
			/*inEmbed = platform == Config.PF_CODE_MOBILE ? true : inEmbed;
			
			
			inTextField.embedFonts = inEmbed;
			if (!inData)
			{
				inTextField.defaultTextFormat = Font.getTextFormat( {
																		size:18, 
																		letterSpacing:2, 
																		font:inEmbed ? Font.getDefaultFontByLang(language) : SWFClassID.SANS 
																	} );
			}
			else
			{
				inData.font = inEmbed ? Font.getDefaultFontByLang(language) : SWFClassID.SANS;
				inTextField.defaultTextFormat = inData;
			}
			
			
			return inTextField;*/
			return Font.setTextField(inTextField, inEmbed, inData, language);
		}
	}

}