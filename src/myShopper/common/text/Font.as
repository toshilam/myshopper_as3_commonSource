package myShopper.common.text 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import myShopper.common.Config;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.emun.FontID;
	import myShopper.common.emun.SWFClassID;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class Font 
	{
		
		public static function getDefaultFontByLang(inLangCode:String):String
		{
			if(ApplicationDisplayObject.platform == Config.PF_CODE_MOBILE)
			{
				return SWFClassID.ARIAL_UNICODE;
			}
			
			switch(inLangCode)
			{
				case Config.LANG_CODE_JP:
				case Config.LANG_CODE_CHS:
				case Config.LANG_CODE_EN:
				case Config.LANG_CODE_CHT: return getFontByLangCode(inLangCode);
			}
			
			return SWFClassID.SANS;
		}
		
		private static function getFontByLangCode(inLangCode:String):String 
		{
			if(ApplicationDisplayObject.platform == Config.PF_CODE_MOBILE)
			{
				return SWFClassID.ARIAL_UNICODE;
			}
			
			if 		(inLangCode == Config.LANG_CODE_CHT)	return SWFClassID.DFH_W7;
			else if (inLangCode == Config.LANG_CODE_CHS)	return SWFClassID.DFP_W7;
			else if (inLangCode == Config.LANG_CODE_EN)		return SWFClassID.GILL_SANS;
			else if (inLangCode == Config.LANG_CODE_JP)		return SWFClassID.MS_PGOTHIC;
			
			return SWFClassID.SANS;
		}
		
		public static function getTextFormat(inObject:Object):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			for (var i:String in inObject)
			{
				try
				{
					tf[i] = inObject[i];
				}
				catch (e:Error)
				{
					Tracer.echo('Font : getTextFormat : no such property can be set : ' + i);
				}
				
			}
			
			if(ApplicationDisplayObject.platform == Config.PF_CODE_MOBILE)
			{
				tf.font = getFontByLangCode(null);
			}
			
			return tf;
		}
		
		public static function setTextField(inTextField:TextField, inEmbed:Boolean = false, inData:TextFormat = null, inLanguage:String = Config.LANG_CODE_EN):TextField
		{
			inEmbed = ApplicationDisplayObject.isMobile() ? true : inEmbed;
			
			
			inTextField.embedFonts = inEmbed;
			if (!inData)
			{
				inTextField.defaultTextFormat = Font.getTextFormat( {
																		size:18, 
																		letterSpacing:2, 
																		font:inEmbed ? Font.getDefaultFontByLang(inLanguage) : SWFClassID.SANS 
																	} );
			}
			else
			{
				inData.font = inEmbed ? Font.getDefaultFontByLang(inLanguage) : SWFClassID.SANS;
				inTextField.defaultTextFormat = inData;
			}
			
			
			return inTextField;
		}
		
		public function Font() 
		{
			
		}
		
	}

}