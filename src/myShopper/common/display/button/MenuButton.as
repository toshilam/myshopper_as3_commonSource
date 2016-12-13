package myShopper.common.display.button 
{
	import flash.geom.Point;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.display.Menu;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	
	/**
	 * A button contains a menu which has a list of sub display object
	 * @author Toshi Lam
	 */
	public class MenuButton extends Button 
	{
		public static const LAYOUT_TL:int = 0; //top left
		public static const LAYOUT_TR:int = 1; //top right
		public static const LAYOUT_BL:int = 2; //bottom left
		public static const LAYOUT_BR:int = 3; //bottom right
		public static const LAYOUT_BM:int = 4; //bottom middle
		public static const LAYOUT_TM:int = 5; //top middle
		public static const LAYOUT_CENTER:int = 5; //center
		
		protected var _menu:Menu;
		public function get menu():Menu { return _menu; }
		
		public function get parentButton():IApplicationDisplayObject { return this; }
		
		public var menuLayoutType:int;
		public var menuMargin:Point;
		
		public function MenuButton() 
		{
			super();
			menuLayoutType = 0;
			menuMargin = new Point();
			_menu = super.addApplicationChild(new Menu(), null, false) as Menu;
			
		}
		
		/**
		 * add sub display object in this menu object
		 * @param	inArrItem - a list of sub display to be added
		 * @param	inParentObject - set parent object for these sub display object
		 * @param	inMenuPos - a list of sub display to be added
		 */
		public function addMenuItem(inArrItem:Vector.<IApplicationDisplayObject>, inParentObject:ApplicationDisplayObject = null):void
		{
			if (inArrItem && inArrItem.length && _menu)
			{
				_menu.removeAllButton();
				var numItem:int = inArrItem.length;
				for (var i:int = 0; i < numItem; i++)
				{
					var d:IApplicationDisplayObject = inArrItem[i];
					_menu.addApplicationChild(d, null, false);
					
					if (inParentObject && d is ApplicationDisplayObject)
					{
						(d as ApplicationDisplayObject).parentObject = inParentObject;
					}
				}
				
				setMenuLayout(menuLayoutType, menuMargin);
			}
		}
		
		public function setMenuLayout(inType:int, inMargin:Point = null):void
		{
			if (_menu && inType >= LAYOUT_TL && inType <= LAYOUT_TM)
			{
				if (inMargin) menuMargin = inMargin;
				
				switch(inType)
				{
					case LAYOUT_BL:
					{
						_menu.x = 0 + menuMargin.x;
						_menu.y = height - menu.height - menuMargin.y;
						break;
					}
					case LAYOUT_BM:
					{
						_menu.x = width - _menu.width >> 1;
						_menu.y = height - menu.height - menuMargin.y;
						break;
					}
					case LAYOUT_BR:
					{
						_menu.x = width - _menu.width - menuMargin.x;
						_menu.y = height - menu.height - menuMargin.y;
						break;
					}
					case LAYOUT_TL:
					{
						_menu.y = 0 + menuMargin.x;
						_menu.x = 0 + menuMargin.y;
						break;
					}
					case LAYOUT_TM:
					{
						_menu.x = width - _menu.width >> 1;
						_menu.y = 0 + menuMargin.y;
						break;
					}
					case LAYOUT_TR:
					{
						_menu.x = width - _menu.width - menuMargin.x;
						_menu.y = 0 + menuMargin.y;
						break;
					}
					case LAYOUT_CENTER:
					{
						_menu.x = width - _menu.width >> 1;
						_menu.y = height - menu.height >> 1;
						break;
					}
				}
				
			}
			
		}
		
	}

}