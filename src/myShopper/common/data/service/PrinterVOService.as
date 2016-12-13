package myShopper.common.data.service 
{
	import myShopper.common.data.PrinterVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class PrinterVOService 
	{
		
		public function PrinterVOService() 
		{
			
		}
		
		
		public static function setPrinterInfo(inData:Object, inPrinterVO:PrinterVO):Boolean
		{
			if (!(inData) || !inPrinterVO) return false;
			
			try
			{
				var printerInfo:Object = inData['printerInfo'];
				if (printerInfo)
				{
					inPrinterVO.selectedPrinterType = int(printerInfo['p_selected_type']);
					inPrinterVO.selectedPrinterID = printerInfo['p_selected_pid'];
				}
			}
			catch (e:Error)
			{
				return false;
			}
			
			return true;
		}
		
		public static function setCloudPrinter(inData:Object, inPrinterVO:PrinterVO):Boolean
		{
			if (!(inData) || !inPrinterVO) return false;
			
			inPrinterVO.isLogged = inData['isLogged'] === true;
			inPrinterVO.cloudPrinters = inData['data'];
			
			return true;
		}
		
		public static function hasCloudPrinter(inVO:PrinterVO):Boolean
		{
			if (!inVO || !inVO.isLogged) return false;
			
			return inVO.cloudPrinters && inVO.cloudPrinters['printers'] is Array;
		}
		
		public static function getNumCloudPrinter(inVO:PrinterVO):int
		{
			if (hasCloudPrinter(inVO))
			{
				return inVO.cloudPrinters['printers'] is Array ? (inVO.cloudPrinters['printers'] as Array).length : 0;
			}
			
			return 0;
		}
		
		public static function getCloudPrinterByIndex(inVO:PrinterVO, inIndex:int):Object
		{
			if (hasCloudPrinter(inVO))
			{
				var arrPrinter:Array = inVO.cloudPrinters['printers'] as Array;
				if (arrPrinter)
				{
					return arrPrinter[inIndex];
				}
			}
			
			return null;
		}
		
		public static function getCloudPrinterNameByIndex(inVO:PrinterVO, inIndex:int):String
		{
			if (hasCloudPrinter(inVO))
			{
				var printer:Object = getCloudPrinterByIndex(inVO, inIndex);
				if (printer && printer['displayName'] is String)
				{
					return printer['displayName'];
				}
			}
			
			return '';
		}
		
		public static function getCloudPrinterIDByIndex(inVO:PrinterVO, inIndex:int):String
		{
			if (hasCloudPrinter(inVO))
			{
				var printer:Object = getCloudPrinterByIndex(inVO, inIndex);
				if (printer && printer['id'] is String)
				{
					return printer['id'];
				}
			}
			
			return '';
		}
		
		
		
	}

}