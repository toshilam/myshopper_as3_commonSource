package myShopper.common.utils 
{
	import com.adobe.crypto.MD5;
	import com.adobe.images.JPGEncoder;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import myShopper.common.Config;
	/**
	 * ...
	 * @author Toshi
	 */
	public class Tools
	{
		
		public function Tools() 
		{
			
		}
		
		public static function isPlatformCode(inValue:String):Boolean
		{
			switch(inValue)
			{
				case Config.PF_CODE_WEB:
				case Config.PF_CODE_QQ:		
				case Config.PF_CODE_FB:		
				case Config.PF_CODE_MOBILE:	return true;
			}
			
			return false;
		}
		
		public static function is3rdPlatform(inValue:String):Boolean
		{
			switch(inValue)
			{
				case Config.PF_CODE_QQ:		
				case Config.PF_CODE_FB:		return true;
			}
			
			return false;
		}
		
		public static function isLangCode(inLangCode:String):Boolean
		{
			switch(inLangCode)
			{
				case Config.LANG_CODE_CHS:
				case Config.LANG_CODE_JP:
				case Config.LANG_CODE_EN:
				case Config.LANG_CODE_CHT: return true;
			}
			
			return false;
		}
		
		public static function isCurrencyCode(inCode:String):Boolean
		{
			switch(inCode)
			{
				case Config.CURRENCY_CODE_HKD:
				case Config.CURRENCY_CODE_JPY:
				case Config.CURRENCY_CODE_TWD:
				case Config.CURRENCY_CODE_SGD:
				case Config.CURRENCY_CODE_THB:
				case Config.CURRENCY_CODE_PHP:
				case Config.CURRENCY_CODE_USD:		return true;
			}
			
			return false;
		}
		
		public static function getCurrencyCodeByNo(inCurrencyNo:int):String
		{
			switch(inCurrencyNo)
			{
				case Config.CURRENCY_NO_HKD:	return Config.CURRENCY_CODE_HKD;
				case Config.CURRENCY_NO_JPY:	return Config.CURRENCY_CODE_JPY;
				case Config.CURRENCY_NO_TWD:	return Config.CURRENCY_CODE_TWD;
				case Config.CURRENCY_NO_USD:	return Config.CURRENCY_CODE_USD;
				case Config.CURRENCY_NO_SGD:	return Config.CURRENCY_CODE_SGD;
				case Config.CURRENCY_NO_THB:	return Config.CURRENCY_CODE_THB;
				case Config.CURRENCY_NO_PHP:	return Config.CURRENCY_CODE_PHP;
			}
			
			return '';
		}
		
		public static function getAppDPI():Number
		{
			return Config.DEFAULT_APP_DPI;
		}
		
		private static var _deviceDPI:Number = 0;
		public static function getDeviceDPI():Number
		{
			if (!_deviceDPI)
			{
				var serverString:String = unescape(Capabilities.serverString); 
				var reportedDpi:Number = Number(serverString.split("&DP=", 2)[1]);
				_deviceDPI = reportedDpi ? reportedDpi : 0;
			}
			
			return _deviceDPI;
		}
		
		public static function getScalingFactorByDPI(inDPI:Number = Config.DEFAULT_APP_DPI):Number
		{
			/*if (inDPI <= Config.DEFAULT_APP_DPI)
			{
				return 1;
			}*/
			
			var curDensity:Number = getDeviceDPI(); 
			var curAppDPI:Number = inDPI;// getAppDPI(); 
			var currentScalingFactor:Number = curDensity / curAppDPI;
			
			return currentScalingFactor < 1 ? 1 : Number( currentScalingFactor.toFixed(2) );
		}
		
		/*public static function setScalingFactor(inObject:DisplayObject):void
		{
			//TODO to be improved
			inObject.scaleX = inObject.scaleY = 2;
		}*/
		
		private static var _isIPad:int = -2;
		public static function isIPad():Boolean 
		{
			if (_isIPad == -2)
			{
				_isIPad = Capabilities.os.toLowerCase().indexOf('ipad');
			}
			return _isIPad != -1;
		}
		
		public static function encodePassword(inPassword:String):String
		{
			var md5PW:String = MD5.hash(inPassword);
			var md5Mask:String = MD5.hash(md5PW);
			
			//do not use getRandomString, as it may easily guess by someone
			var v1:String = md5Mask.substr(0, md5Mask.length / 2);
			var v2:String = md5Mask.substr(md5Mask.length / 2, md5Mask.length - 1);
			var maskedPW:String = v1 + md5PW + v2;
			//trace('encode : ', maskedPW);
			//trace('decode : ', maskedPW.substr(16, 32));
			return maskedPW;
		}
		
		public static function getRandomString(inLength:int):String
		{
			var string:String = '0123456789abcef';
			var value:String = '';
			for (var i:int = 0; i < inLength; i++)
			{
				value +=  string.substr( Math.floor(Math.random() * string.length), 1 );
			}
			
			return value;
		}
		
		public static function getByteByDisplayObject(inDisplayObject:DisplayObject, inW:Number, inH:Number, inQuality:uint = 85):ByteArray
		{
			var bmpData:BitmapData = new BitmapData(inW, inH);
			bmpData.draw(inDisplayObject);
			
			var ba:ByteArray = new JPGEncoder(inQuality).encode(bmpData);
			ba.position = 0;
			return ba;
		}
		
		public static function formatString(inString:String, inArrString:Array):String
		{
			if (!inString) return '';
			var regExp:RegExp = /{(\d)}/i;
			for(var i:int =0; i < inArrString.length; i++)
			{
				inString = inString.replace(regExp, inArrString[i]);
			}
			return inString;
		}
		
		
		public static function lineBreakToBR(inString:String):String
		{
			if (!inString) return '';
			var regExp:RegExp = /\r|\n/g;
			return inString.replace(regExp, '<br />');
		}
		
		public static function BRToLineBreak(inString:String):String
		{
			if (!inString) return '';
			var regExp:RegExp = /<br\s?\/>/g;
			return inString.replace(regExp, '\n');
		}
		
		public static function spaceToHyphen(inString:String):String
		{
			if (!inString) return '';
			var regExp:RegExp = /\s/g;
			return inString.replace(regExp, '-');
		}
		
		public static function hyphenToSpace(inString:String):String
		{
			if (!inString) return '';
			var regExp:RegExp = /-/g;
			return inString.replace(regExp, " ");
		}
		
		public static function replaceSpareSpace(inString:String):String
		{
			if (!inString) return '';
			inString = Tools.trimSpace(inString);
			return Tools.singleSpace(inString);
		}
		
		public static function trimSpace(inString:String):String
		{
			if (!inString) return '';
			var trim:RegExp = /^\s+|\s+$/g;
			return inString.replace(trim, "");
		}
		
		public static function singleSpace(inString:String):String
		{
			if (!inString) return '';
			var single:RegExp = /\s{2,}/g;
			return inString.replace(single, " ");
		}
		
		public static function replaceSpace(inString:String):String
		{
			if (!inString) return '';
			var single:RegExp = /\s/g;
			return inString.replace(single, "");
		}
		
		public static function replaceEmail(inString:String, inReplaceString:String = ''):String
		{
			if (!inString) return '';
			var reg:RegExp = /[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/ig;
			return inString.replace(reg, inReplaceString);
		}
		
		public static function replaceURL(inString:String, inReplaceString:String = ''):String
		{
			if (!inString) return '';
			var reg:RegExp = /[a-zA-Z0-9\-\.]+\.(co|com|org|net|mil|edu|hk|my|sg|th|cn|tw|jp)/ig;
			return inString.replace(reg, inReplaceString);
		}
		
		/**
		 * replace the spare \ sign right after % from DB
		 * @param	inString
		 * @return
		 */
		public static function dbPercentSignToSign(inString:String):String
		{
			if (!inString) return '';
			var regExp:RegExp = /\\%/g;
			return inString.replace(regExp, "%");
		}
		
		public static function replaceRestrictedString(inValue:String):String
		{
			return replaceEmail(replaceURL(dbPercentSignToSign(inValue)));
		}
		
		public static function rawURIToObj(inValue:String, inPointer:String = '&'):Object
		{
			var data:Object = { };
			var rawURI:String = inValue;
			var arrParams:Array = rawURI.split(inPointer);
			var numItem:int = arrParams.length;
			if (numItem)
			{
				for (var i:int = 0; i < numItem; i++)
				{
					var pairValue:String = arrParams[i];
					if (pairValue && pairValue.length && pairValue.indexOf('=') != -1)
					{
						var arrValue:Array = pairValue.split('=');
						if (arrValue && arrValue.length == 2)
						{
							data[arrValue[0]] = arrValue[1];
						}
					}
					
				}
			}
			
			return data;
		}
		
		
	}

}