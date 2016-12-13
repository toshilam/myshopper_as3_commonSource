package myShopper.common.utils 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class StringUtil 
	{
		public static function getHTMLTextFont(inValue:String, inData:Object = null):String
		{
			var html:String = '<font';
			
			for (var i:String in inData)
			{
				html += ' ' + i + '="' + inData[i] + '"';
			}
			
			html += '>' + inValue + '</font>';
			
			return html;
		}
		
	}

}