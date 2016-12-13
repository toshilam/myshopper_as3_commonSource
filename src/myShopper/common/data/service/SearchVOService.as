package myShopper.common.data.service 
{
	
	import myShopper.common.data.shopper.ShopperAreaList;
	import myShopper.common.data.shopper.ShopperDistanceList;
	import myShopper.common.data.shopper.ShopperDistanceVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class SearchVOService 
	{
		
		public function SearchVOService() 
		{
			
		}
		
		public static function getDistanceListByXML(inXML:XML, inDistanceList:ShopperDistanceList):ShopperDistanceList
		{
			if (inDistanceList is ShopperDistanceList && inXML && inXML.name() == 'distanceRange')
			{
				var numItem:int = inXML.*.length();
				
				for (var i:int = 0; i < numItem; i++)
				{
					var targetXML:XML = inXML.*[i];
					if (targetXML)
					{
						var dVO:ShopperDistanceVO = new ShopperDistanceVO('', targetXML.@data, targetXML.@label);
						
						inDistanceList.addVO (dVO);
					}
					
				}
				
				return inDistanceList;
			}
			
			return null;
		}
		
		
	}
}