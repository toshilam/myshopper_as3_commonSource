package myShopper.common.display 
{
	import flash.display.Stage;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IMaskableDisplayObject;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class MaskedDisplayObject extends ApplicationDisplayObject implements IMaskableDisplayObject, IApplicationDisplayObject
	{
		protected var _mask:ApplicationDisplayObject;
		
		public function MaskedDisplayObject() 
		{
			super();
			_mask = super.addApplicationChild(new ApplicationDisplayObject(), null, false) as ApplicationDisplayObject;
		}
		
		override public function destroyDisplayObject():void 
		{
			super.destroyDisplayObject();
			_mask = null;
		}
		
		override public function initDisplayObject(inSettingSource:Object, inStage:Stage):void 
		{
			super.initDisplayObject(inSettingSource, inStage);
			
			//_mask = new ApplicationDisplayObject();
		}
		
		public function setMask(inX:Number, inY:Number, inWidth:Number, inHeight:Number):void 
		{
			drawMark(inX, inY, inWidth, inHeight);
		}
		
		protected function drawMark(inX:Number, inY:Number, inWidth:Number, inHeight:Number):void
		{
			if (_mask)
			{
				_mask.graphics.clear();
				_mask.graphics.beginFill(0x000000);
				_mask.graphics.drawRect(inX, inY, inWidth, inHeight);
				_mask.graphics.endFill();
				
				mask = _mask;
			}
			else
			{
				Tracer.echo(name + ' : drawMarker : display object is not init!', this, 0xff0000);
			}
		}
	}

}