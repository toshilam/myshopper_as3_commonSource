package myShopper.common.display 
{
	import caurina.transitions.Tweener;
	import com.adobe.images.JPGEncoder;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import myShopper.common.Config;
	import myShopper.common.emun.SWFClassID;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IDisplayObjectList;
	import myShopper.common.resources.SettingManager;
	import myShopper.common.text.Font;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	import myShopper.common.utils.TweenerEffect;
	import myShopper.common.utils.XMLAttributesConvertor;
	
	/// @eventType	myShopper.common.events.ApplicationEvent.PAGE_CLOSED
	[Event(name = "pageClosed", type = "myShopper.common.events.ApplicationEvent")]
	
	/// @eventType	myShopper.common.events.ApplicationEvent.PAGE_SHOW
	[Event(name = "pageShow", type = "myShopper.common.events.ApplicationEvent")]
	
	[Event(name = "ChildAdded", type = "myShopper.common.events.ApplicationEvent")]
	
	[Event(name = "Childremoved", type = "myShopper.common.events.ApplicationEvent")]
	
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationDisplayObject extends MovieClip implements IApplicationDisplayObject
	{
		public static var assetManager:IDataManager;
		public static var settingManager:IDataManager;
		
		public static function get platform():String
		{
			return settingManager && settingManager.hasAsset(SettingManager.PLATFORM) ? settingManager.getAsset(SettingManager.PLATFORM) : Config.PF_CODE_WEB;
		}
		
		public static function isMobile():Boolean
		{
			return platform == Config.PF_CODE_MOBILE;
		}
		
		//indicate whather this object has tooltip
		protected var _tooltip:String;
		
		
		protected var _id:String;
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		/**
		 * the main stage object, it will be assigned when initDisplayObject
		 */
		protected var _appStage:Stage;
		
		protected var _XMLSetting:XML;
		/**
		 * the setting of the display object itself, (x, y, width, height...), 
		 * some of the display object may not have such setting, as they will be defined indivially .
		 */
		public function get XMLSetting():XML { return _XMLSetting; } 
		
		protected var _subDisplayObjectList:IDisplayObjectList;
		/**
		 * a sub display objects list, containing all the display object which is under this object
		 */
		public function get subDisplayObjectList():IDisplayObjectList { return _subDisplayObjectList; }
		
		protected var _isClosed:Boolean = false;
		/**
		 * [read only] indicate whather the display object is out of stage (cannot be seen on stage)
		 */
		public function get isClosed():Boolean { return _isClosed; }
		
		public function get hasToolTip():Boolean 
		{
			return _tooltip && _tooltip.length;
		}
		
		public function get tooltip():String 
		{
			return _tooltip;
		}
		
		public function set tooltip(value:String):void 
		{
			_tooltip = value;
			
			if (hasToolTip)
			{
				//no check needed, to avoid added listener by child object
				//if (!hasEventListener(MouseEvent.MOUSE_OVER))
				//{
					addEventListener(MouseEvent.MOUSE_OVER, tooltipHandler, false, 0, true);
					addEventListener(MouseEvent.MOUSE_OUT, tooltipHandler, false, 0, true);
				//}
				
			}
			else
			{
				//if (hasEventListener(MouseEvent.MOUSE_OVER))
				//{
					removeEventListener(MouseEvent.MOUSE_OVER, tooltipHandler);
					removeEventListener(MouseEvent.MOUSE_OUT, tooltipHandler);
				//}
			}
		}
		
		private function tooltipHandler(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.MOUSE_OVER)
			{
				if (hasToolTip)
				{
					myShopper.common.utils.ToolTip.show(_tooltip);
				}
			}
			else
			{
				myShopper.common.utils.ToolTip.close();
			}
		}
		
		
		
		
		protected function setIsClosed(inValue:Boolean):void 
		{ 
			//if (_isClosed == inValue) return;
			
			_isClosed = inValue;
			var type:String = (_isClosed) ? ApplicationEvent.PAGE_CLOSED : ApplicationEvent.PAGE_SHOW;
			//Tracer.echo(name + ' : setIsClosed : dispatching event : ' + type, this, 0xff0000);
			dispatchEvent(new ApplicationEvent(type, this));
		}
		
		/**
		 * to specify what the parent object is
		 * once it is set, the property 'parent' will be return this object
		 */
		protected var _parentObject:DisplayObjectContainer;
		public function get parentObject():DisplayObjectContainer { return _parentObject; }
		public function set parentObject(value:DisplayObjectContainer):void 
		{
			_parentObject = value;
		}
		
		override public function get parent():DisplayObjectContainer 
		{
			return _parentObject ? _parentObject : super.parent;
		}
		
		protected var _dpiScale:Number;
		public function get dpiScale():Number {return _dpiScale;}
		public function set dpiScale(inDPI:Number):void 
		{
			scaleX = scaleY = Tools.getScalingFactorByDPI(Number(inDPI));
			_dpiScale = scaleX;
		}
		
		
		
		public function ApplicationDisplayObject() 
		{
			//super();
			_subDisplayObjectList = new DisplayObjectList();
			
			//TODO : handle tab, using Form and listen tab event manually??
			//added 23/03/2014
			tabChildren = tabEnabled = false;
			
			/////////////////////////MOBILE/////////////////////////////
			if (ApplicationDisplayObject.isMobile())
			{
				/*var numItem:int = numChildren;
				for (var i:int = 0; i < numItem; i++)
				{
					var targetItem:TextField = getChildAt(i) as TextField;
					if (targetItem)
					{
						targetItem.embedFonts = true;
						targetItem.defaultTextFormat = Font.getTextFormat( {
																				size:targetItem.defaultTextFormat.size,
																				font:SWFClassID.ARIAL_UNICODE 
																			} );
					}
				}*/
			}
			////////////////////////MOBILE END///////////////////////////
		}
		
		/**
		 * init the display object (positioning, resizing...)
		 * @param	inSettingSource - the setting of the display object itself, (x, y, width, height...)
		 * @param	inStage - main stage will be used for resizing, positioning...
		 */
		public function initDisplayObject(inSettingSource:Object, inStage:Stage):void
		{
			_XMLSetting = (inSettingSource is XML) ? XML(inSettingSource) : null;
			_appStage = inStage;
			initDisplayObjectPosition(inStage);
			//Tracer.echo(this.name + ' : initDisplayObject ', this, 0x335577);
			
			
			
		}
		
		/**
		 * to remove all the veriables, listeners which were added initDisplayObject
		 * this function will be called through removeApplicationChild 
		 * (this function should not be called directly)
		 */
		public function destroyDisplayObject(/*pvt:PrivateClass*/):void
		{
			//Tracer.echo(this.name + ' : destroyDisplayObject ', this, 0x335577);
			
			if (_subDisplayObjectList && _subDisplayObjectList.length)
			{
				/*var totalSubDisplayObject:int = _subDisplayObjectList.length;
				for (var i:int = 0; i < totalSubDisplayObject; i++)
				{
					removeApplicationChild( _subDisplayObjectList.getDisplayObjectByIndex(i) );
				}*/
				
				while (_subDisplayObjectList.length)
				{
					removeApplicationChild( _subDisplayObjectList.getDisplayObjectByIndex(0), false);
				}
				
				_subDisplayObjectList.clear();
				//keep displayobjectlist, as may reuse the object again
				//_subDisplayObjectList = null;
				//_XMLSetting = null;
			}
			
		}
		
		/**
		 * to add sub display object into this display ojbject
		 * @param	inApplicationDisplayObject - the display object to be added
		 * @param	inSettingSource - the setting source (normally is XML) is used to adjust the display object
		 * @param	inStage - main stage will be used for resizing, positioning... (NOTE : this will not be used)
		 * @param	autoShowPage - display object will be show into stage with tweening effect if true, else show in stage without tweening
		 * @return the added sub display object
		 */
		public function addApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, /*inStage:Stage,*/ autoShowPage:Boolean = true):IApplicationDisplayObject
		{
			if (!inApplicationDisplayObject) 
			{
				Tracer.echo(name + ' : addApplicationChild : null object!', this, 0xff0000);
				return null;
			}
			var o:IApplicationDisplayObject = super.addChild(DisplayObject(inApplicationDisplayObject)) as IApplicationDisplayObject;
			initApplicationChild(o, inSettingSource, DisplayObject(o).stage, autoShowPage); 
			
			return o;
		}
		
		/**
		 * to add sub display object into this display ojbject
		 * @param	inApplicationDisplayObject - the display object to be added
		 * @param	inSettingSource - the setting source (normally is XML) is used to adjust the display object
		 * @param	inStage - main stage will be used for resizing, positioning... (NOTE : this will not be used)
		 * @param	inIndex - which level to be added into
		 * @param	autoShowPage - display object will be show into stage with tweening effect if true, else show in stage without tweening
		 * @return the added sub display object
		 */
		public function addApplicationChildAt(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, /*inStage:Stage,*/ inIndex:uint = 0, autoShowPage:Boolean = true):IApplicationDisplayObject
		{
			if (!inApplicationDisplayObject) 
			{
				Tracer.echo(name + ' : addApplicationChild : null object!', this, 0xff0000);
				return null;
			}
			var o:IApplicationDisplayObject = super.addChildAt(DisplayObject(inApplicationDisplayObject), inIndex) as IApplicationDisplayObject;
			initApplicationChild(o, inSettingSource, DisplayObject(o).stage, autoShowPage); 
			
			return o;
		}
		
		protected function initApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, inSettingSource:Object, inStage:Stage, autoShowPage:Boolean = true):void
		{
			inApplicationDisplayObject.initDisplayObject(inSettingSource, inStage);
			_subDisplayObjectList.addDisplayObject(inApplicationDisplayObject);
			dispatchEvent(new ApplicationEvent(ApplicationEvent.CHILD_ADDED, inApplicationDisplayObject as DisplayObject));
			
			if (autoShowPage) 
			{
				inApplicationDisplayObject.showPage();
			}
			/*else
			{
				setIsClosed(false);
			}*/
			
		}
		
		/**
		 * to remove the display object from stage + remove from subDisplayObject List
		 * 1. close the display object (to make the display object invisible first) by calling closePage()
		 * 2. removeChild
		 * @param	inApplicationDisplayObject - the display object to be removed
		 * @param	autoClosePage - call closePage() before removeChild if true, else call removeChild directly
		 */
		public function removeApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject, autoClosePage:Boolean = true):void
		{
			if ( !hasApplicationChild(inApplicationDisplayObject) ) return;
			
			//close the display object (to make the display object invisible first)
			if (!inApplicationDisplayObject.isClosed && autoClosePage) 
			{
				inApplicationDisplayObject.addEventListener(ApplicationEvent.PAGE_CLOSED, pageClosedHandler);
				inApplicationDisplayObject.closePage();
			}
			else
			{
				//setIsClosed(true);
				// if the display object has already removed(cannot be seen) from stage, removeChild directly.
				pageClosedHandler(new ApplicationEvent(ApplicationEvent.PAGE_CLOSED, DisplayObject(inApplicationDisplayObject)));
			}
		}
		
		public function hasApplicationChild(inApplicationDisplayObject:IApplicationDisplayObject):Boolean
		{
			var numItem:int = _subDisplayObjectList.length;
			for (var i:int = 0; i <numItem ; i++)
			{
				if (_subDisplayObjectList.getDisplayObjectByIndex(i) === inApplicationDisplayObject) return true;
			}
			
			return false;
		}
		
		protected function pageClosedHandler(e:ApplicationEvent):void
		{
			
			e.targetDisplayObject.removeEventListener(ApplicationEvent.PAGE_CLOSED, pageClosedHandler);
			
			if (e.targetDisplayObject is IApplicationDisplayObject)
			{
				var targetDisplayObject:IApplicationDisplayObject = e.targetDisplayObject as IApplicationDisplayObject;
				
				if (targetDisplayObject['destroyDisplayObject'])
				{
					targetDisplayObject['destroyDisplayObject'](/*new PrivateClass()*/);
				}
				
				//changed on 01082012 / added checking before removal
				//super.removeChild(_subDisplayObjectList.removeDisplayObject(targetDisplayObject) as DisplayObject);
				
				//final check whather target displayObject is contained in this object
				if (contains( _subDisplayObjectList.removeDisplayObject(targetDisplayObject) as DisplayObject ) )
				{
					super.removeChild(targetDisplayObject as DisplayObject);
				}
				
				
				dispatchEvent(new ApplicationEvent(ApplicationEvent.CHILD_REMOVED, targetDisplayObject as DisplayObject));
			}
		}
		
		/**
		 * to start positioning, resizing the display object itself (it will be based on the XML setting if it is set
		 * (this function should not be called directly)
		 * @param	inAppStage - main stage will be used for resizing, positioning...
		 * @param	inAutoAdjust
		 * @param	inException - a list of attr name, if it's not null, NOT to process the attr in this array
		 */
		protected function initDisplayObjectPosition(inAppStage:Stage, inAutoAdjust:Boolean = true, inException:Array = null ):void
		{
			if (_XMLSetting /*&& _XMLSetting.attributes().length() > 0*/)
			{
				var hasException:Boolean = inException && inException.length;
				var numItem:int = _XMLSetting.attributes().length();
				
				
				for (var i:int = 0; i <numItem ; i++)
				{
					var process:Boolean = true;
					var attr:XML = _XMLSetting.attributes()[i] as XML;
					var attrName:String = attr.name().toString();
					
					if (hasException)
					{
						var numException:int = inException.length;
						
						for (var j:int = 0; j < numException; j++)
						{
							if (inException[i] == attrName)
							{
								//if found in exception array, NOT to process convertor
								process = false;
								break;
							}
						}
						
					}
					
					if (process)	
					{
						XMLAttributesConvertor.handle(MovieClip(this), attrName, attr, inAppStage, inAutoAdjust) as MovieClip;
					}
				}
			}
			
		}
		
		/* INTERFACE myShopper.common.interfaces.IResizeableDisplayObject */
		/**
		 * this function will normally be called when the main stage is being resized.
		 * @param	inAppStage - main stage will be used for resizing, positioning...
		 */
		public function onStageResize(inAppStage:Stage):void
		{
			//list of attr no need to re-process
			//noly process when init
			initDisplayObjectPosition(inAppStage, true, new Array('id', 'txtText', 'text', 'Class', 'txtAutoSize', 'txtColor', 'bgFID', 'DPIScale') );
			
			//Tracer.echo(this.name + ' : onStageResize : x : ' + x + ', y :' + y, this, 0x335577);
			
			if (_subDisplayObjectList && _subDisplayObjectList.length)
			{
				var numItem:int = _subDisplayObjectList.length;
				for (var i:uint = 0; i < numItem; i++)
				{
					_subDisplayObjectList.getDisplayObjectByIndex(i).onStageResize(inAppStage);
				}
			}
			
		}
		
		/* INTERFACE myShopper.common.interfaces.IApplicationPage */
		public function closePage(inObjTweenerEffect:Object = null):void
		{
			//Tracer.echo(this.name + ' closePage !', this, 0x336677);
			
			if (inObjTweenerEffect != null) 
			{
				if (inObjTweenerEffect.onComplete is Function)
				{
					var targetFunc:Function = inObjTweenerEffect.onComplete;
					
					inObjTweenerEffect.onComplete = function():void
					{
						targetFunc();
						setIsClosed(true);
					}
				}
				else
				{
					inObjTweenerEffect.onComplete = function():void	{ setIsClosed(true); }
				}
			}
			else
			{
				inObjTweenerEffect = TweenerEffect.setAlpha(0, 1, "easeInOutExpo", function():void { setIsClosed(true); } );
			}
			
			Tweener.addTween(ApplicationDisplayObject(this), inObjTweenerEffect);
		}
		
		public function showPage(inObjTweenerEffect:Object = null):void
		{
			//Tracer.echo(this.name + ' showPage !', this, 0x336677);
			
			if (inObjTweenerEffect != null) 
			{
				if (inObjTweenerEffect.onComplete is Function)
				{
					var targetFunc:Function = inObjTweenerEffect.onComplete;
					
					inObjTweenerEffect.onComplete = function():void
					{
						targetFunc();
						setIsClosed(false);
					}
				}
				else
				{
					inObjTweenerEffect.onComplete = function():void	{ setIsClosed(false); }
				}
			}
			else
			{
				//inObjTweenerEffect = TweenerEffect.setAlpha(1, 1, "easeInOutExpo", function():void { setIsClosed(false); } );
				inObjTweenerEffect = TweenerEffect.setAlpha(1, 1, "easeInOutExpo", setIsClosed);
				inObjTweenerEffect.onCompleteParams = [false];
			}
			
			ApplicationDisplayObject(this).alpha = 0;
			
			Tweener.addTween(ApplicationDisplayObject(this), inObjTweenerEffect);
		}
		
		/**
		 * to clone a display object
		 * @param	source - the display object to be cloned
		 * @param	autoAdd - to add the display object into scene
		 * @return the cloned display object
		 
		public function duplicateDisplayObject(source:DisplayObject, autoAdd:Boolean = false):DisplayObject
		{
			// create duplicate
			var sourceClass:Class = Object(source).constructor;
			var duplicate:DisplayObject = new sourceClass();
			
			// duplicate properties
			duplicate.transform = source.transform;
			duplicate.filters = source.filters;
			duplicate.cacheAsBitmap = source.cacheAsBitmap;
			duplicate.opaqueBackground = source.opaqueBackground;
			
			if (source.scale9Grid) 
			{
				var rect:Rectangle = source.scale9Grid;
				// WAS Flash 9 bug where returned scale9Grid is 20x larger than assigned
				// rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
				duplicate.scale9Grid = rect;
			}
			
			// add to source parent’s display list
			// if autoAdd was provided as true
			if (autoAdd && source.parent) 
			{
				source.parent.addChild(duplicate);
			}
			
			return duplicate;
		}*/
		
		/**
		 * to clone a display object as bitmap
		 * //@param	inMovieClip - a display object to be cloned
		 * @return a display object which contain the cloned bitmap
		 */
		public function cloneAsBitmap():ApplicationDisplayObject
        {
            var mc:ApplicationDisplayObject = new ApplicationDisplayObject();
            var bmpData:BitmapData = new BitmapData(width, height);
			
            bmpData.draw(this)
            
			var bmp:Bitmap = new Bitmap(bmpData);
            
			bmp.smoothing = true;
            mc.addChild(bmp);
			
            return mc;
        }
		
		public function cloneAsByte(inQuality:uint = 85):ByteArray
		{
			//var bmpData:BitmapData = new BitmapData(width, height);
			//bmpData.draw(this);
			//var ba:ByteArray = bmpData.getPixels(new Rectangle(0, 0, width, height));
			//ba.position = 0;
			//var ba:ByteArray = new JPGEncoder(inQuality).encode(bmpData);
			//ba.position = 0;
			//return ba;
			
			return Tools.getByteByDisplayObject(this, width, height, inQuality);
		}
		
		/**
		 * Disabled function! please use addApplicationChild() instead of!
		 * @param	child
		 * @return the added child
		 */
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			Tracer.echo(this.name + ' : calling disabled function : addChild(), please use addApplicationChild() instead of!', this, 0xFF0000);
			return null;
		}
		
		/**
		 * Disabled function! please use addApplicationChildAAt() instead of!
		 * @param	child
		 * @param   index
		 * @return the added child
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			Tracer.echo(this.name + ' : calling disabled function : addChildAt(), please use addApplicationChildAt() instead of!', this, 0xFF0000);
			return null;
		}
		
		/**
		 * Disabled function! please use addApplicationChild() instead of!
		 * @param	child
		 * @return the removed child
		 */
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			Tracer.echo(this.name + ' : calling disabled function : removeChild(), please use removeApplicationChild() instead of!', this, 0xFF0000);
			return null;
		}
		
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}