package myShopper.common.media 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import myShopper.common.events.SoundEvent;
	import myShopper.common.interfaces.IApplicationSound;
	import myShopper.common.utils.Tracer;
	
	[Event(name="completedAll", type="myShopper.common.events.SoundEvent")] 
	[Event(name="stopped", type="myShopper.common.events.SoundEvent")] 
	[Event(name="completed", type="myShopper.common.events.SoundEvent")] 
	/**
	 * ...
	 * @author Toshi
	 */
	internal class SoundGroup extends EventDispatcher implements IEventDispatcher, IApplicationSound
	{
		private var _arrSound:Vector.<ApplicationSound>;
		
		private var _id:String;
		public function get id():String 
		{
			return _id;
		}
		
		private var _currSoundIndex:int;
		
		private var _isPlaying:Boolean;
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		private var _volume:Number;
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function set volume(value:Number):void 
		{
			_volume = value;
		}
		
		
		
		public function SoundGroup(inID:String, inSoundGroup:Vector.<ApplicationSound>) 
		{
			_id = inID;
			_arrSound = inSoundGroup;
			_currSoundIndex = 0;
		}
		
		public function play():Boolean
		{
			if (_isPlaying) 
			{
				Tracer.echo('SoundGroup : ' + _id + ' : play : sounds are currently playing', this, 0xff0000);
				return false;
			}
			if (!_arrSound || !_arrSound.length)
			{
				Tracer.echo('SoundGroup : ' + _id + ' : play : no sound found!', this, 0xff0000);
				return false;
			}
			
			_currSoundIndex = 0;
			
			var s:ApplicationSound = _arrSound[_currSoundIndex];
			if (s is ApplicationSound)
			{
				playSound(s);
				return true;
			}
			
			return false;
		}
		
		public function stop():void
		{
			if (_isPlaying)
			{
				for (var i:int = 0; i < _arrSound.length; i++)
				{
					if (_arrSound[i].isPlaying)
					{
						_arrSound[i].stop();
					}
				}
				
				_isPlaying = false;
				_currSoundIndex = 0;
				
				dispatchEvent(new SoundEvent(SoundEvent.STOPPED, _id, null, null) );
			}
		}
		
		public function clear():void
		{
			if (_arrSound && _arrSound.length)
			{
				_arrSound.length = 0;
				_currSoundIndex = 0;
			}
		}
		
		private function playSound(inSound:ApplicationSound):void
		{
			
			inSound.addEventListener(SoundEvent.COMPLETED, soundEventHandler);
			
			if (inSound.volume != _volume)
			{
				inSound.volume = _volume;
			}
			
			if ( !inSound.play() )
			{
				inSound.removeEventListener(SoundEvent.COMPLETED, soundEventHandler);
				_isPlaying = false;
				dispatchEvent(new SoundEvent(SoundEvent.FAILED, _id, inSound, null) );
				
				return;
			}
			
			_isPlaying = true;
			
		}
		
		private function soundEventHandler(e:SoundEvent):void 
		{
			if (_currSoundIndex >= _arrSound.length - 1)
			{
				_isPlaying = false;
				_currSoundIndex = 0;
				dispatchEvent(new SoundEvent(SoundEvent.COMPLETED_ALL, _id, null, null) );
				return
			}
			
			dispatchEvent(new SoundEvent(SoundEvent.COMPLETED, _id, _arrSound[_currSoundIndex], null) );
			
			var s:ApplicationSound = _arrSound[++_currSoundIndex];
			if (s is ApplicationSound)
			{
				playSound(s);
			}
		}
		
		
	}

}