package myShopper.common.data 
{
	import myShopper.common.emun.PrinterType;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi
	 */
	public class PrinterVO extends VO 
	{
		
		/**
		 * refer to PrinterType, 1=system, 2=cloud
		 */
		private var _selectedPrinterType:int;
		public function get selectedPrinterType():int {return _selectedPrinterType;}
		public function set selectedPrinterType(value:int):void 
		{
			if (value != PrinterType.SYSTEM && value != PrinterType.CLOUD)
			{
				value = PrinterType.SYSTEM;
			}
			
			_selectedPrinterType = value;
		}
		
		/**
		 * google clouded printer id
		 */
		public var selectedPrinterID:String;
		
		/**
		 * data object from google cloud print
		 */
		public var cloudPrinters:Object;
		
		/**
		 * has user logged with their google account and granded permission
		 */
		public var isLogged:Boolean;
		
		public function PrinterVO(inID:String) 
		{
			super(inID);
			
			clear();
		}
		
		override public function clear():void 
		{
			isLogged = false;
			cloudPrinters = null;
			selectedPrinterType = PrinterType.SYSTEM;
			selectedPrinterID = '';
		}
		
		override public function clone():IVO 
		{
			var pVO:PrinterVO = new PrinterVO(id);
			pVO.selectedPrinterType = selectedPrinterType;
			pVO.selectedPrinterID = selectedPrinterID;
			
			return pVO;
		}
		
		
	}

}