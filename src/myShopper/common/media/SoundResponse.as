package myShopper.common.media 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IApplicationSound;
	import myShopper.common.interfaces.ISoundRequest;
	import myShopper.common.interfaces.IVO;

	/**
	 * ...
	 * @author Toshi
	 */
	public class SoundResponse extends VO
	{
		private var _soundRequest:ISoundRequest;
		public function get soundRequest():ISoundRequest 
		{
			return _soundRequest;
		}
		
		private var _sound:IApplicationSound;
		public function get sound():IApplicationSound 
		{
			return _sound;
		}
		
		/**
		 * 
		 * @param	inID - the unique sound id
		 * @param	inSoundRequest - the sound request from requester
		 */
		public function SoundResponse(inID:String, inSoundRequest:ISoundRequest, inSound:IApplicationSound) 
		{
			super(inID);
			_soundRequest = inSoundRequest;
			_sound = inSound;
		}
		
		override public function clear():void 
		{
			if (_soundRequest is SoundRequest) SoundRequest(_soundRequest).clear();
			
		}
		
		override public function clone():IVO 
		{
			return new SoundResponse(_id, _soundRequest, _sound);
		}
		
		
		
		
	}

}