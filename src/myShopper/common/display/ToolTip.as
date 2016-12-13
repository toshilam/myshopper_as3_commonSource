package myShopper.common.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * this object to be used by system toolTip object
	 */
	public class ToolTip extends Sprite 
	{
		
		private var _txt:TextField;
		public function get txt():TextField 
		{
			return _txt;
		}
		
		public function ToolTip() 
		{			
			_txt = new TextField();
			_txt.textColor = 0x000000;	
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.multiline = true;
			addChild(_txt);
			mouseChildren = false;
			mouseEnabled = false;
		}
	
		public function get text():String { return _txt.text; }
		
		public function set text(inValue:String):void 
		{
			_txt.htmlText = inValue;
			
			graphics.clear();
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xFFFF99, 1);
			graphics.drawRect(0, 0, _txt.width, _txt.height);			
			graphics.endFill();
		}		
		
		
	}
}