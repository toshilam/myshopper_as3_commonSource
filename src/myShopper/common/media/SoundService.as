package myShopper.common.media 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	import myShopper.common.events.SoundEvent;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.ISoundRequest;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public class SoundService extends EventDispatcher implements IEventDispatcher
	{
		public static const VOLUME_LEVEL:int = 5;
		private static var instance:SoundService;
		
		private var _assetManager:IDataManager;
		private var _soundMap:Dictionary;
		private var _soundBGMap:Dictionary;
		private var _soundNumber:int;
		
		public var _currVolume:Number; // 0 - 1
		public var _currBGVolume:Number; // 0 - 1
		
		public function get assetManager():IDataManager 
		{
			return _assetManager;
		}
		
		public function set assetManager(value:IDataManager):void 
		{
			_assetManager = value;
		}
		
		
		public function SoundService(inClass:PrivateSoundService, inAssetManager:IDataManager = null) 
		{
			if (inAssetManager) _assetManager = inAssetManager;
			_soundMap = new Dictionary();
			_soundBGMap = new Dictionary();
			_soundNumber = 0;
			_currBGVolume = 1;
			_currVolume = 1;
		}
		
		public static function getInstance(inAssetManager:IDataManager = null):SoundService 
		{
			if (SoundService.instance == null) 
			{
				SoundService.instance = new SoundService(new PrivateSoundService(), inAssetManager);
			}
			
			return SoundService.instance;
		}
		
		public function request(inRequest:ISoundRequest, inAssetID:*):*
		{
			return requestHandler(inRequest, inAssetID);
		}
		
		private function requestHandler(inRequest:ISoundRequest, inAssetID:*):* 
		{
			if (inRequest is ISoundRequest)
			{
				switch(inRequest.type)
				{
					case SoundRequest.SOUND_PLAY : 
					{
						if (_assetManager && _assetManager.hasAsset(inAssetID) && inRequest.data is Array && (inRequest.data as Array).length)
						{
							return getPlayFuncByDataType(inRequest.data)(inRequest, inAssetID);
						}
						
						return null;
					}
					case SoundRequest.SOUND_STOP : 				return stopSound(inRequest);
					case SoundRequest.SOUND_CHANGE_SETTING : 	return changeSoundSetting(inRequest);
				}
			}
			
			return null;
		}
		
		private function changeSoundSetting(inRequest:ISoundRequest):* 
		{
			if (inRequest.volume >= 0 && inRequest.volume <= VOLUME_LEVEL)
			{
				if (inRequest.isBGSound)  
				{
					_currBGVolume = getVolume( inRequest.volume );
				}
				else
				{
					_currVolume = getVolume( inRequest.volume );
				}
				
				changePlayingSoundVolume(inRequest.isBGSound);
				
				return SoundResponseFactory.create(inRequest.id, inRequest, null);
			}
			
			Tracer.echo('SoundService : changeSoundSetting : volume out of range : ' + inRequest.volume, this, 0xff0000);
			return null;
		}
		
		private function changePlayingSoundVolume(isBGSound:Boolean):void 
		{
			var map:Dictionary = (isBGSound) ? _soundBGMap : _soundMap;
			
			for (var i:* in map)
			{
				var s:Object = map[i];
				if (s is ApplicationSound)
				{
					ApplicationSound(s).volume = _currBGVolume;
				}
				else if (s is SoundGroup)
				{
					SoundGroup(s).volume = _currBGVolume;
				}
			}
		}
		
		private function stopSound(inRequest:ISoundRequest):* 
		{
			if (/*inRequest.id is String && */_soundMap[inRequest.id])
			{
				if (_soundMap[inRequest.id])
				{
					if (_soundMap[inRequest.id] is ApplicationSound)
					{
						ApplicationSound(_soundMap[inRequest.id]).stop();
					}
					else if (_soundMap[inRequest.id] is SoundGroup)
					{
						SoundGroup(_soundMap[inRequest.id]).stop();
					}
					else
					{
						Tracer.echo('SoundService : stopSound : unknown data type : ' + _soundMap[inRequest.id], this, 0xff0000);
						return null;
					}
					
					var respondse:SoundResponse = SoundResponseFactory.create(inRequest.id, inRequest, _soundMap[inRequest.id]);
					delete _soundMap[inRequest.id];
					
					return respondse;
				};
				
			}
			
			Tracer.echo('SoundService : stopSound : data not found : ' + inRequest.id, this, 0xff0000);
			return null;
		}
		
		private function playSound(inRequest:ISoundRequest, inAssetID:*):* 
		{
			var dataID:String = String(inRequest.data[0]);
			var sc:Class = _assetManager.getData(dataID, inAssetID);
			var s:Sound = new sc();
			
			if (s)
			{
				var soundID:String = getSoundID(dataID);
				inRequest.id = soundID;
				inRequest.volume 
				var appSound:ApplicationSound = new ApplicationSound(soundID, s, inRequest);
				appSound.addEventListener(SoundEvent.COMPLETED, soundEventHandler, false, 0, true);
				appSound.addEventListener(SoundEvent.STOPPED, soundEventHandler, false, 0, true);
				
				if ( appSound.play() )
				{
					((inRequest.isBGSound) ? _soundBGMap : _soundMap)[soundID] = appSound;
				}
				else
				{
					Tracer.echo('SoundService : playSound : fail playing sound : ' + dataID, this, 0xff0000)
					return null
				}
				
				
				
				/*if (inRequest.responder)
				{
					inRequest.responder.onResult(appSound);
				}*/
				
				//return appSound;
				return SoundResponseFactory.create(soundID, inRequest, appSound);
			}
			
			/*if (inRequest.responder)
			{
				inRequest.responder.onFault(new Error('unable to play sound!'));
			}*/
			
			Tracer.echo('SoundService : playSound : sound not found : ' + dataID, this, 0xff0000)
			
			return null
		}
		
		private function playSounds(inRequest:ISoundRequest, inAssetID:*):* 
		{
			var arrSound:Array = inRequest.data as Array;
			
			if (arrSound && arrSound.length)
			{
				var arrAppSound:Vector.<ApplicationSound> = new Vector.<ApplicationSound>();
				var soundID:String = getSoundID( String((inRequest.data as Array)[0]) ); //use the 1st sound item id as group id
				inRequest.id = soundID;
				
				for (var i:int = 0; i < arrSound.length; i++)
				{
					var dataID:String = String(arrSound[i]);
					var sc:Class = _assetManager.getData(dataID, inAssetID);
					var s:Sound = new sc();
					
					if (s)
					{
						arrAppSound.push( new ApplicationSound(soundID, s, inRequest) );
					}
					else
					{
						Tracer.echo('SoundService : playSounds : sound not found : ' + dataID, this, 0xff0000)
						return null;
					}
				}
				
				var sg:SoundGroup = new SoundGroup(soundID, arrAppSound);
				sg.addEventListener(SoundEvent.COMPLETED_ALL, soundEventHandler, false, 0, true);
				sg.addEventListener(SoundEvent.FAILED, soundEventHandler, false, 0, true);
				
				if ( sg.play() )
				{
					((inRequest.isBGSound) ? _soundBGMap : _soundMap)[soundID] = sg;
					//_soundMap[soundID] = sg;
					return SoundResponseFactory.create(soundID, inRequest, sg);
				}
				
				sg.clear();
				Tracer.echo('SoundService : playSounds : unable to play sound group : ' + arrSound[i], this, 0xff0000)
				return null;
				
			}
			
			Tracer.echo('SoundService : playSounds : unknwon data type : ' + inRequest.data, this, 0xff0000)
			return null
		}
		
		/**
		 * get unique sound id
		 * @param	inData - sound data id
		 */
		private function getSoundID(inData:String):String 
		{
			return inData + String(_soundNumber++);
		}
		
		private function getVolume(inVolume:Number):Number 
		{
			return inVolume / VOLUME_LEVEL;
		}
		
		private function getPlayFuncByDataType(inData:Object):Function
		{
			return (inData as Array).length == 1 ? playSound : playSounds;
		}
		
		private function soundEventHandler(e:SoundEvent):void 
		{
			switch(e.type)
			{
				case SoundEvent.STOPPED:
				case SoundEvent.COMPLETED:
				case SoundEvent.COMPLETED_ALL:
				case SoundEvent.FAILED:
				{
					if (_soundMap[e.id])
					{
						delete _soundMap[e.id];
					}
					break;
				}
				
			}
		}
		
		
		
	}

}

import myShopper.common.interfaces.IApplicationSound;
import myShopper.common.interfaces.ISoundRequest;
import myShopper.common.media.SoundResponse;

class PrivateSoundService
{
	public function PrivateSoundService():void{}
}

class SoundResponseFactory
{
	public function SoundResponseFactory():void { }
	public static function create(inID:String, inSoundRequest:ISoundRequest, inSound:IApplicationSound):SoundResponse
	{
		return new SoundResponse(inID, inSoundRequest.clone() as ISoundRequest, inSound);
	}
}