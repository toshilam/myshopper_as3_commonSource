package myShopper.common.resources
{
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.utils.Tracer;
	import myShopper.common.interfaces.IDataManager;
	
	/**
	 * To manage all the swf libs, and return the movieclip from the added swf lib.
	 * 
	 * @author Macentro (toshil)
	 * @version 1.3
	 */
	public class AssetManager extends DataManager implements IDataManager
	{
		public function AssetManager() 
		{
			super();
			
		}
		
		/**
		 * To add a swf Lib into this class, and an ID for identifying
		 * @param	inLoaderInfo 
		 * @param	inLoaderInfoID 
		 */
		override public function addAsset(inLoaderInfo:Object, inLoaderInfoID:String):Boolean
		{
			if (_objAssets[inLoaderInfoID] == undefined && (inLoaderInfo is LoaderInfo || inLoaderInfo is MovieClip))
			{
				_objAssets[inLoaderInfoID] = inLoaderInfo is MovieClip ? MovieClip(inLoaderInfo).loaderInfo : inLoaderInfo;
				_lastAddedAssetID = inLoaderInfoID;
				return true;
			}
			
			Tracer.echo('AssetManager : addAsset : asset exists : ' + inLoaderInfoID, this, 0xff0000);
			return false;
		}
		
		/**
		 * To get a loaded swf.
		 * @param	inLoaderInfoID
		 * @return a loaded swf
		*/ 
		override public function getAsset(inLoaderInfoID:String):*
		{
			if (_objAssets[inLoaderInfoID] != undefined)
			{
				//return LoaderInfo(_objAssets[inLoaderInfoID]).loader;
				return _objAssets[inLoaderInfoID];
			}
			return null;
		}
		
		/**
		 * To get a movie clip from the swf lib.
		 * @param	inID - name of MC ID needed in swf lib
		 * @param	inLoaderInfoID - to get the right swf lib which is already added into this class
		 * @param	inTargetMC - targert movieclip that lib object will be cast as
		 * @param	inNewName - if wanna have a different name from lib ID
		 * @return a Movieclip from lib
		 */
		override public function getData(inDataID:*,  inLoaderInfoID:String):*
		{
			if (_objAssets[inLoaderInfoID] != undefined && inDataID && hasData(inDataID, inLoaderInfoID))
			{
				var animationClass:Class = LoaderInfo(_objAssets[inLoaderInfoID]).applicationDomain.getDefinition(inDataID) as Class;
				
				if (animationClass)
				{
					var obj:Object = new animationClass();
					
					if (obj is IApplicationDisplayObject)
					{
						DisplayObject(obj).name = IApplicationDisplayObject(obj).id = inDataID;
					}
					else if (obj is DisplayObject)
					{
						DisplayObject(obj).name = inDataID;
					}
					else
					{
						//if it's not display object, then retrun class directly
						return animationClass;
					}
					
					return obj;
				}
				
				Tracer.echo('AssetManager : getData : LoaderInfoID : ' + inLoaderInfoID + ' : no such data exist : ' + inDataID, this, 0xff0000);
				
			}
			
			Tracer.echo('AssetManager : getData : LoaderInfoID : ' + inLoaderInfoID + ' : no such data exist : ' + inDataID, this, 0xff0000);
			return null;
		}
		
		/**
		 * to check whether the indicated data is exist
		 * @param	inDataID - a name of data to be got 
		 * @param	inLoaderInfoID - the data to be got from
		 * @return return true is the data is found, otherwise false
		 */
		override public function hasData(inDataID:*,  inLoaderInfoID:String):Boolean
		{
			if (_objAssets[inLoaderInfoID] == undefined || !inDataID) 
			{
				trace('AssetManager : hasData : LoaderInfoID : ' + inLoaderInfoID + ' : undefined');
				return false;
			}
			
			return LoaderInfo(_objAssets[inLoaderInfoID]).applicationDomain.hasDefinition(inDataID);
			
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
		 * @param	inMovieClip - a display object to be cloned
		 * @return a display object which contain the cloned bitmap
		 
		public function cloneAsBitmap(inMovieClip:DisplayObject):DisplayObject
        {
            var mc:MovieClip = new MovieClip();
            var bmpData:BitmapData = new BitmapData(inMovieClip.width, inMovieClip.height);
			
            bmpData.draw(inMovieClip)
            
			var bmp:Bitmap = new Bitmap(bmpData);
            
			bmp.smoothing = true;
            mc.addChild(bmp);
			
            return mc;
        }*/
	}

}