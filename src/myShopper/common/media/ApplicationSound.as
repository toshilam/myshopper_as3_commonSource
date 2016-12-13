package myShopper.common.media 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import myShopper.common.events.SoundEvent;
	import myShopper.common.interfaces.IApplicationSound;
	import myShopper.common.interfaces.ISoundRequest;
	
	[Event(name="started", type="myShopper.common.events.SoundEvent")] 
	[Event(name="failed", type="myShopper.common.events.SoundEvent")] 
	[Event(name="stopped", type="myShopper.common.events.SoundEvent")] 
	[Event(name="muted", type="myShopper.common.events.SoundEvent")] 
	[Event(name="completed", type="myShopper.common.events.SoundEvent")] 
	
	/**
	 * ...
	 * @author Macentro
	 */
	public class ApplicationSound extends EventDispatcher implements IEventDispatcher, IApplicationSound
	{
		private var _soundInfo:ISoundRequest;
		private var _soundChannel:SoundChannel;
		private var _sound:Sound;
		private var _volume:Number;
		
		private var _isPlaying:Boolean;
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		private var _id:String;
		public function get id():String 
		{
			return _id;
		}
		
		public function ApplicationSound(inID:String, inSound:Sound, inSoundInfo:ISoundRequest) 
		{
			super();
			_id = inID;
			_sound = inSound;
			_soundInfo = inSoundInfo;
			_volume = _soundInfo.volume;
			
		}
		
		public function play():Boolean
		{
			if (_sound && _soundInfo)
			{
				_soundChannel = _sound.play(_soundInfo.startTime, _soundInfo.loops, new SoundTransform(_soundInfo.volume));
				
				if (!_soundChannel)
				{
					dispatchEvent(new SoundEvent(SoundEvent.FAILED, _id, this, _soundInfo));
					return false;
				}
				
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundEventHandler);
				
				_isPlaying = true;
				dispatchEvent(new SoundEvent(SoundEvent.STARTED, _id,  this, _soundInfo));
				
				//return _soundChannel;
				return true;
			}
			
			return false;
		}
		
		public function stop():void
		{
			if (_soundChannel && _isPlaying)
			{
				_soundChannel.stop();
				dispatchEvent(new SoundEvent(SoundEvent.STOPPED, _id, this, _soundInfo));
			}
		}
		
		private function soundEventHandler(e:Event):void 
		{
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundEventHandler);
			_soundChannel = null;
			_isPlaying = false;
			dispatchEvent(new SoundEvent(SoundEvent.COMPLETED, _id, this, _soundInfo));
		}
		
		public function get volume():Number
		{
			if (_soundChannel)
			{
				_soundChannel.soundTransform.volume;
			}
			
			return NaN;
		}
		
		public function set volume(inValue:Number):void
		{
			_volume = inValue;
			
			if (_soundChannel)
			{
				//_soundChannel.soundTransform.volume = _volume;
				_soundChannel.soundTransform = new SoundTransform(_volume);
				
				if (inValue == 0)
				{
					dispatchEvent(new SoundEvent(SoundEvent.MUTED, _id, this, _soundInfo));
				}
				
			}
		}
		
		
	}

}