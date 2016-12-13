package myShopper.common.display.button 
{
	import myShopper.common.display.Image;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ImageButton extends Button 
	{
		protected var _logo:Image
		public function get logo():Image { return _logo; }
		
		public function ImageButton() 
		{
			super();
			
			_logo = super.addApplicationChild(new Image(), null, false) as Image;
			//_logo.addEventListener(FileEvent.COMPLETE, fileEventHandler, false, 0, true);
			//_logo.x = 10;
			//_logo.y = IMG_Y;
			//_logo.setMask(0, 0, IMG_W, IMG_H);
			//_logo.autoSize = true;
		}
		
	}

}