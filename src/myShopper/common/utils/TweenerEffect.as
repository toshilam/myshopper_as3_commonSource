package myShopper.common.utils 
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class TweenerEffect
	{
		
		public function TweenerEffect() 
		{
			
		}
		
		public static function setBlur
		(
			inBlurX:uint = 5, 
			inBlurY:uint = 5, 
			inQuality:Number = .5,
			inTime:Number = 1,
			inDelay:Number = 0,
			inTransition:String = 'easeOutSine'
		):Object
		{
			return { time:inTime, transition:inTransition, _Blur_blurX:inBlurX, _Blur_blurY:inBlurY, _Blur_quality:inQuality, delay:inDelay };
		}
		
		public static function setGlow
		(
			inTime:Number = 1, 
			inTransition:String = 'easeOutSine', 
			inColor:uint = 0xFFFFFF, 
			inBlur:uint = 5, 
			inQuality:uint = 5,
			inAlpha:Number= .3
		):Object
		{
			return { time:inTime, transition:inTransition, _Glow_color:inColor, _Glow_blurY:inBlur, _Glow_blurX:inBlur, _Glow_quality:inQuality, _Glow_alpha:inAlpha };
		}
		
		public static function resetGlow
		(
			inTime:uint = 1, 
			inTransition:String = 'easeOutSine'
		):Object
		{
			return { time:inTime, transition:inTransition, _Glow_blurY:0, _Glow_blurX:0, _Glow_quality:0, _Glow_alpha:0 };
		}
		
		public static function setColor
		(
			inTime:Number = 1, 
			inColor:uint = 0xFFFFFF,
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null
		):Object
		{
			return { time:inTime, transition:inTransition, _color:inColor, onComplete:inCompleteFunction };
		}
		
		public static function setMove
		(
			inX:int = 0,
			inY:int = 0,
			inTime:Number = 1, 
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null
		):Object
		{
			return { x:inX, y:inY, time:inTime, transition:inTransition, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
		
		public static function setMoveWithAlpha
		(
			inAlpha:uint = 0,
			inX:int = 0,
			inY:int = 0,
			inTime:Number = 1, 
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null
			
		):Object
		{
			return { _autoAlpha:inAlpha, x:inX, y:inY, time:inTime, transition:inTransition, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
		
		public static function setMoveWithDelay
		(
			inDelay:uint = 1,
			inX:int = 0,
			inY:int = 0,
			inTime:Number = 1, 
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null
			
		):Object
		{
			return { delay:inDelay, x:inX, y:inY, time:inTime, transition:inTransition, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
		
		public static function setAlpha
		(
			inAlpha:Number = 0,
			inTime:Number = 1, 
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null,
			inDelay:Number = 0
		):Object
		{
			return { _autoAlpha:inAlpha, time:inTime, transition:inTransition, delay:inDelay, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
		
		public static function setAlphaWithDelay
		(
			inAlpha:Number = 0,
			inTime:Number = 1, 
			inDelay:Number = 0.3,
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null
		):Object
		{
			return { _autoAlpha:inAlpha, time:inTime, delay:inDelay, transition:inTransition, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
		
		public static function setScale
		(
			inScale:Number = 1,
			inTime:Number = 1,
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null
		):Object
		{
			return { _scale:inScale, time:inTime, transition:inTransition, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
		
		public static function setWidthHeight
		(
			inWidth:Number,
			inHeight:Number,
			inTime:Number = 1,
			inTransition:String = 'easeOutSine',
			inCompleteFunction:Function = null,
			inUpdateFunction:Function = null
		):Object
		{
			return { width:inWidth, height:inHeight, time:inTime, transition:inTransition, onComplete:inCompleteFunction, onUpdate:inUpdateFunction };
		}
	}

}