package myShopper.common.data.service 
{
	import flash.utils.ByteArray;
	import myShopper.common.Config;
	import myShopper.common.data.FileImageVO;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ImageVOService 
	{
		
		public function ImageVOService() 
		{
			
		}
		
		public static function hasImageData(inData:Object):Boolean
		{
			return inData && inData['i_data'] is ByteArray;
		}
		
		public static function setByteToObj(inData:Object, inNoImageByte:ByteArray):Object
		{
			if (inData)
			{
				inData['i_data'] = inNoImageByte;
				
			}
			return inData;
		}
		
		public static function setImageVO(inVO:FileImageVO, inData:Object):Boolean
		{
			if (inData == null || !(inVO is FileImageVO))
			{
				Tracer.echo('ImageVOService : setImageVO : no data provided : ' + inData, ImageVOService, 0xff0000 );
				return false;
			}
			
			var byte:ByteArray = inData['i_data'] as ByteArray;
			var name:String = inData['i_name'] as String;
			var path:String = inData['i_path'] as String;
			var type:String = inData['i_type'] as String;
			var size:String = inData['i_size'] as String;
			var extra:Object = inData['i_extra'];
			
			if (!byte || !byte.bytesAvailable)
			{
				Tracer.echo('ImageVOService : setImageVO : no data provided : ' + inData, ImageVOService, 0xff0000 );
				return false;
			}
			
			inVO.name = name ? name : '';
			inVO.path = path ? path : '';
			inVO.type = type ? type : '';
			inVO.size = size ? size : '';
			inVO.extra = extra ? extra : null;
			inVO.data = byte;
			return true;
		}
		
		public static function setImageVOByVO(inVO:FileImageVO, inData:FileImageVO):Boolean
		{
			if (inData == null || !(inVO is FileImageVO) || !(inData is FileImageVO))
			{
				Tracer.echo('ImageVOService : setImageVO : no data provided : ' + inData, ImageVOService, 0xff0000 );
				return false;
			}
			
			var byte:ByteArray = inData.data;
			var name:String = inData.name;
			var path:String = inData.path;
			var type:String = inData.type;
			var size:String = inData.size;
			
			if (!byte || !byte.bytesAvailable)
			{
				Tracer.echo('ImageVOService : setImageVO : no data provided : ' + inData, ImageVOService, 0xff0000 );
				return false;
			}
			
			inVO.data = byte;
			inVO.name = name ? name : '';
			inVO.path = path ? path : '';
			inVO.type = type ? type : '';
			inVO.size = size ? size : '';
			
			return true;
		}
		
		public static function getRemoteImageObj(inData:FileImageVO, inUID:String):Object
		{
			return 	{
						i_name:inData.name,
						i_data:inData.data,
						i_type:inData.type,
						i_size:inData.size,
						i_path:inData.path,
						i_extra:inData.extra,
						i_user_id:inUID
					}
		}
		
		public static function getImageURL(inHost:String, inUID:String, inPath:String, inExtra:Array = null):String
		{
			var extra:String = '';
			if (inExtra)
			{
				while (inExtra.length)
				{
					extra += inExtra.splice(0, 1)[0] + '/';
				}
			}
			
			
			//inExtra to be used for product no currently
			return inHost + '/' + inUID +  inPath + extra + '.img';
		}
		
	}

}