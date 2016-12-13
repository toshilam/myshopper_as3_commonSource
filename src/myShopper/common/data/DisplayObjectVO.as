package myShopper.common.data 
{
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IVO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class DisplayObjectVO extends VO 
	{
		public var data:Object;
		public var settingXML:XML;
		public var displayObject:IApplicationDisplayObject;
		
		public function DisplayObjectVO(inID:String, inDisplayObject:IApplicationDisplayObject, inSettingXML:XML, inData:Object = null) 
		{
			super(inID);
			data = inData;
			settingXML = inSettingXML;
			displayObject = inDisplayObject;
			
		}
		
		override public function clear():void 
		{
			data = null;
			settingXML = null;
			displayObject = null;
		}
		
		override public function clone():IVO 
		{
			return new DisplayObjectVO(_id, displayObject, settingXML, data);
		}
	}

}