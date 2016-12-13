package myShopper.common.data 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Toshi
	 */
	public class AlerterVO extends VO
	{
		public var type:String;
		//can be input by user, (e.g. MessagerYesNoAlerter input will be 'yes' or 'no')
		public var input:String;
		//anything can be assigned, normally assign the target object which will be informed once user made tge confirmation.
		//public var targetObject:Object;
		
		public var data:Object;
		public var title:String;
		public var message:String;
		
		//used for AlerterType.DISPLAY_OBJECT
		public var settingXML:XML;
		public var autoShow:Boolean;
		
		public function AlerterVO(inVOID:String, inType:String = '', inInput:String = '', inData:Object = null, inTitle:String = '', inMessage:String = '', inSettingXML:XML = null, inAutoShow:Boolean = true) 
		{
			super(inVOID);
			
			type = inType;
			input = inInput;
			//targetObject = inTargetObject;
			data = inData;
			title = inTitle;
			message = inMessage;
			
			settingXML = inSettingXML;
			autoShow = inAutoShow;
		}
		
		override public function clear():void
		{
			type = '';
			input = '';
			//targetObject = null;
			data = null;
			title = '';
			message = '';
			
			settingXML = null;
		}
	}

}