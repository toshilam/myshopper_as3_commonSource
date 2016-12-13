package myShopper.common.display 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import myShopper.common.interfaces.IScrollable;
	import myShopper.common.utils.Tracer;
	
	/**
	 * 
	 * @author Toshi Lam
	 */
	public class TextFieldWrapper extends ApplicationDisplayObject implements IScrollable 
	{
		protected var _textField:TextField;
		protected var _initWH:Point;
		protected var _textFieldMask:MaskedDisplayObject;
		
		public function TextFieldWrapper(inTextField:TextField) 
		{
			super();
			_textField = inTextField;
			_initWH = new Point(_textField.width, _textField.height);
			
			_textFieldMask = new MaskedDisplayObject();
			_textFieldMask.setMask(0, 0, _textField.width, _textField.height);
			
			super.addApplicationChild(_textFieldMask, null, false);
			mouseChildren = mouseEnabled = false;
			
			if (_textField.autoSize == TextFieldAutoSize.NONE)
			{
				_textField.autoSize = TextFieldAutoSize.LEFT;
			}
			
			//fix text field width
			_textField.wordWrap = true;
			//text can not be shown if font is not embeded for dynamic text field
			_textField.mask = _textFieldMask;
			
			//x = _textFieldMask.x = _textField.x;
			//y = _textFieldMask.y = _textField.y;
		}
		
		
		public function get content():InteractiveObject 
		{
			return _textField;
		}
		
		override public function get mask():DisplayObject 
		{
			return _textFieldMask;
		}
		
		override public function set mask(value:DisplayObject):void 
		{
			Tracer.echo(name + ' : TextFieldWrapper : mask : calling disable function! set mask');
			//super.mask = value;
		}
		
	}

}