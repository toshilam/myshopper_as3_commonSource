package myShopper.common.resources
{
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.ISoundRequest;
	import myShopper.common.media.SoundRequest;
	import myShopper.common.media.SoundService;
	import myShopper.common.utils.Tracer;
	
	/**
	 * 
	 * @author Toshi
	 */
	public class SoundManager extends DataManager implements IDataManager
	{
		public static const PREFIX_SOUND_ID:String = 'Snd';
		
		private var _soundService:SoundService;
		
		public function SoundManager() 
		{
			super();
			
			_soundService = SoundService.getInstance();
		}
		
		/**
		 * To add a swf Lib into this class
		 * @param	inAsset - IDataManager
		 * @param	inAssetID - 
		 */
		override public function addAsset(inAsset:Object, inAssetID:String):Boolean
		{
			if (inAsset is IDataManager)
			{
				_soundService.assetManager = inAsset as IDataManager;
				return true;
			}
			
			Tracer.echo('SoundManager : addAsset : asset exists : ' + inAssetID, this, 0xff0000);
			return false;
		}
		
		
		/**
		 * 
		 * @param	inRequest
		 * @param	inLoaderInfoID
		 * @return
		 */
		override public function getData(inRequest:*,  inAssetID:String):*
		{
			if (!_soundService || !(inRequest is ISoundRequest))
			{
				Tracer.echo('SoundManager : getData : no asset found/unknown request type : '  + inRequest, this, 0xff0000);
				return null;
			}
			
			return _soundService.request(inRequest as ISoundRequest, inAssetID);
		}
		
		/**
		 * play game sound
		 * @param	inDataID - sound id
		 * @param	inAssetID - sound lib id
		 * @param	inSoundLevel - The volume (from option panel), ranging from 0 (silent) to 5 (full volume) / -1 = use default setting
		 * @param	inStartTime - start playing from
		 * @param	inLoops - number of time to be played
		 * @return	soundResponse object which contains unique sound id, and all the sound info
		 */
		public function playSound(inDataID:Array, inAssetID:String, inVolumeLevel:Number = -1, inStartTime:Number = 0, inLoops:int = 0):*
		{
			return getData(new SoundRequest(SoundRequest.SOUND_PLAY, inDataID, inStartTime, inLoops, null, inVolumeLevel), inAssetID);
		}
		
		/**
		 * play background sound
		 * @param	inDataID - sound id
		 * @param	inAssetID - sound lib id
		 * @param	inSoundLevel - The volume (from option panel), ranging from 0 (silent) to 5 (full volume) / -1 = use default setting
		 * @param	inStartTime - start playing from
		 * @param	inLoops - number of time to be played
		 * @return	soundResponse object which contains unique sound id, and all the sound info
		 */
		public function playBackgroundSound(inDataID:Array, inAssetID:String, inVolumeLevel:Number = -1, inStartTime:Number = 0, inLoops:int = 0):*
		{
			var request:SoundRequest = new SoundRequest(SoundRequest.SOUND_PLAY, inDataID, inStartTime, inLoops, null, inVolumeLevel);
			request.isBGSound = true;
			return getData(request, inAssetID);
		}
		
		public function changeSoundVolume(inVolumeLevel:Number = 5):*
		{
			return getData(new SoundRequest(SoundRequest.SOUND_CHANGE_SETTING, null, -1, -1, null, inVolumeLevel), null);
		}
		
		public function changeBackgroundSoundVolume(inVolumeLevel:Number = 5):*
		{
			return getData(new SoundRequest(SoundRequest.SOUND_CHANGE_SETTING, null, -1, -1, null, inVolumeLevel), null);
		}
	}

}