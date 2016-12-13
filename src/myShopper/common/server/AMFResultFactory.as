package myShopper.common.server 
{
	import myShopper.amf.common.data.ResultVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class AMFResultFactory 
	{
		
		public static function convert(inData:Object):ResultVO
		{
			if (inData) 
			{
				var service:String = String(inData.service);
				var code:String = String(inData.code);
				var result:Object = inData.result ? Object(inData.result) : Object(inData.data);
				var uniqueID:String = String(inData.uniqueID);
				
				if (service && code && result && uniqueID)
				{
					return new ResultVO('', service, code, result, uniqueID);
				}
			}
			
			
			Tracer.echo('AMFResultFactory : convert : unknown data type : ' + inData, AMFResultFactory, 0xff0000);
			return null;
		}
		
	}

}