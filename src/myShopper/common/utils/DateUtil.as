package myShopper.common.utils 
{
	import com.chewtinfoil.utils.DateUtils;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class DateUtil 
	{
		public static function getDateObj(inStart:int = 1, inEnd:int = 31):Array
		{
			var arr:Array = new Array();
			for (var i:int = inStart; i <= inEnd; i++)
			{
				arr.push({label:i.toString(), data:i.toString()});
			}
			
			return arr;
		}
		
		public static function dateToString(d:Date, inHasTime:Boolean = false):String
		{
			var day:String = (d.getDate() < 10 ? "0" : "") + d.getDate().toString();
			var month:String = (d.getMonth() < 9 ? "0" : "") + (d.getMonth() + 1).toString();
			var year:String = d.getFullYear().toString();
			var time:String = '';
			
			if (inHasTime)
			{
				var hour:String = d.getHours().toString();
				var min:String = d.getMinutes().toString();
				var sec:String = d.getSeconds().toString();
				
				hour = hour.length == 1 ? '0' + hour : hour;
				min = min.length == 1 ? '0' + min : min;
				sec = sec.length == 1 ? '0' + sec : sec;
				time = ' ' + hour + ':' + min + ':' + sec;
			}
			return year + '-' + month + '-' + day + time;
		}
		
		public static function stringToDate(d:String):Date
		{
			var arrDateTime:Array = d.split(' ');
			
			if (arrDateTime.length == 2)
			{
				var arrDate:Array = String(arrDateTime[0]).split('-');
				var arrTime:Array = String(arrDateTime[1]).split(':');
				
				return new Date(int(arrDate[0]), int(arrDate[1]) - 1, int(arrDate[2]), int(arrTime[0]), int(arrTime[1]), int(arrTime[2]));
			}
			
			return new Date();
		}
		
		public static function getDateStringByUTCDateString(inValue:String):String
		{
			return dateToString( DateUtils.getDateFromUTC( stringToDate( inValue ).getTime() ), true );
		}
	}

}