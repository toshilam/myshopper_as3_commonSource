package myShopper.common.utils 
{
	import flash.display.Stage;
	import myShopper.common.Config;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.display.ToolTip;
	import myShopper.common.text.Font;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ToolTip extends Object 
	{
		private static var instance:ToolTip;
		private static var _stage:Stage;
		
		//the object which is current on stage
		private static var _onStageObject:myShopper.common.display.ToolTip
		public static function get onStageObject():myShopper.common.display.ToolTip 
		{
			return _onStageObject;
		}
		
		
		public function ToolTip(pvt:PrivateClass, inStage:Stage) 
		{
			_stage = inStage;
		}
		
		public static function getInstance(inStage:Stage):ToolTip
		{
			if (ToolTip.instance == null) 
			{
				ToolTip.instance = new ToolTip(new PrivateClass(), inStage);
			}
			
			return ToolTip.instance;
		}
		
		public static function show(inValue:String):void
		{
			if (!_stage) return;
			
			close();
			
			_onStageObject = new myShopper.common.display.ToolTip();
			
			if (ApplicationDisplayObject.isMobile())
			{
				Font.setTextField(_onStageObject.txt, true, Font.getTextFormat( { size:12 } ));
				_onStageObject.scaleX = _onStageObject.scaleY = Tools.getScalingFactorByDPI();
			}
			
			_onStageObject.text = inValue;
			_onStageObject.x = _stage.mouseX;
			_onStageObject.y = _stage.mouseY - _onStageObject.height;
			
			if (_onStageObject.y < 0)
			{
				_onStageObject.y = 0;
			}
			
			if (_onStageObject.x + _onStageObject.width > _stage.stageWidth)
			{
				_onStageObject.x = _stage.stageWidth - _onStageObject.width
			}
			
			_stage.addChild(_onStageObject);
		}
		
		public static function close():void
		{
			if (!_stage) return;
			
			if (_onStageObject && _stage.contains(_onStageObject))
			{
				_stage.removeChild(_onStageObject);
			}
			
			_onStageObject = null;
		}
		
		
		
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}