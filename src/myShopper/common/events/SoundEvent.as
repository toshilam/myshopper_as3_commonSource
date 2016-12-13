package myShopper.common.events 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.media.Sound;
	import myShopper.common.interfaces.ISoundRequest;
	import myShopper.common.media.ApplicationSound;
	/**
	 * 
	 * @author Macentro
	 */
	public class SoundEvent extends ApplicationEvent 
	{
		
		public static const STARTED:String = 'started';
		public static const FAILED:String = 'failed';
		public static const STOPPED:String = 'stopped';
		public static const MUTED:String = 'muted';
		public static const COMPLETED:String = 'completed';
		public static const COMPLETED_ALL:String = 'completedAll';
		
		private var _id:String;
		public function get id():String { return _id; }
		
		private var _sound:ApplicationSound;
		public function get sound():ApplicationSound { return _sound; }
		
		public function SoundEvent(type:String, inID:String, inSound:ApplicationSound, inData:ISoundRequest, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			_id = inID;
			_sound = inSound;
			super(type, null, inData, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SoundEvent(type,_id, _sound, _data as ISoundRequest, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SoundEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
		
	}
	
}