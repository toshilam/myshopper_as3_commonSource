package myShopper.common.media 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IResponder;
	import myShopper.common.interfaces.ISoundRequest;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public class SoundRequest extends VO implements ISoundRequest
	{
		public static const SOUND_PLAY:String = 'play';
		public static const SOUND_CHANGE_SETTING:String = 'changeSetting';
		public static const SOUND_STOP:String = 'stop';
		public static const SOUND_STOP_ALL:String = 'stopAll';
		public static const SOUND_DATA:String = 'data';
		
		private var _type:String;
		private var _dataID:Object;
		private var _startTime:Number;
		private var _loops:int;
		private var _responder:IResponder;
		private var _volume:Number;
		private var _soundID:String; // an unique sound id that assign by soundService
		private var _isBGSound:Boolean; 
		
		public function SoundRequest(inType:String, inDataID:Object, inStartTime:Number = 0, inLoops:int = 0, inResponder:IResponder = null, inVolume:Number = 1 ) 
		{
			super('');
			_responder = inResponder;
			_loops = inLoops;
			_startTime = inStartTime;
			_dataID = inDataID;
			_type = inType;
			_volume = inVolume;
			_isBGSound = false;
		}
		
		override public function clear():void 
		{
			_type = null;
			_dataID = null;
			_startTime = 0;
			_loops = 0;
			_volume = 0;
			_isBGSound = false;
			_responder = null;
		}
		
		
		override public function clone():IVO 
		{
			return new SoundRequest(_type, _dataID, _startTime, _loops, _responder, _volume);
		}
		
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get data():Object 
		{
			return _dataID;
		}
		
		public function set data(value:Object):void 
		{
			_dataID = value;
		}
		
		public function get startTime():Number 
		{
			return _startTime;
		}
		
		public function set startTime(value:Number):void 
		{
			_startTime = value;
		}
		
		public function get loops():int 
		{
			return _loops;
		}
		
		public function set loops(value:int):void 
		{
			_loops = value;
		}
		
		public function get responder():IResponder 
		{
			return _responder;
		}
		
		public function set responder(value:IResponder):void 
		{
			_responder = value;
		}
		
		public function get soundID():String 
		{
			return _soundID;
		}
		
		public function set soundID(value:String):void 
		{
			_soundID = value;
		}
		
		public function get isBGSound():Boolean 
		{
			return _isBGSound;
		}
		
		public function set isBGSound(value:Boolean):void 
		{
			_isBGSound = value;
		}
		
	}

}