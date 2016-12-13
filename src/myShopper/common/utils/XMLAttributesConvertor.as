package myShopper.common.utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.emun.AssetLibID;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IButton;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.ILabel;
	import myShopper.common.resources.XMLManager;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi
	 */
	public class XMLAttributesConvertor
	{
		//a prefix for different system
		public static var xmlManager:IDataManager;
		protected static var _xmlLang:XML;
		
		
		public static const STAGE_MARGIN_WIDTH:int = 8;
		
		public function XMLAttributesConvertor() 
		{
			
		}
		
		public static function handle(inDisplayObject:DisplayObject, inAttributeName:String, inAttributeValue:Object, inStage:Stage, inAutoAdjust:Boolean = true):Object
		{
			switch(inAttributeName)
			{
				case 'Class':
				{
					
					break;
				}
				case 'id':
				{
					inDisplayObject.name = String(inAttributeValue);
					if (inDisplayObject is IApplicationDisplayObject) IApplicationDisplayObject(inDisplayObject).id = String(inAttributeValue);
					break;
				}
				case 'x':
				{
					inDisplayObject.x = Number(positionHandler(String(inAttributeValue), inDisplayObject, inStage, inAutoAdjust));
					break;
				}
				case 'y':
				{
					inDisplayObject.y = Number(positionHandler(String(inAttributeValue), inDisplayObject, inStage, inAutoAdjust));
					break;
				}
				case 'width':
				{
					inDisplayObject.width = Number(sizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'height':
				{
					inDisplayObject.height = Number(sizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'alpha':
				{
					inDisplayObject.alpha = Number(inAttributeValue);
					break;
				}
				case 'bgWidth':
				{
					inDisplayObject['bg'].width = Number(sizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'bgHeight':
				{
					inDisplayObject['bg'].height = Number(sizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'bgAlpha':
				{
					inDisplayObject['bg'].alpha = Number(inAttributeValue);
					break;
				}
				case 'bgFID':
				{
					if (inDisplayObject['bg'] is MovieClip)
					{
						MovieClip(inDisplayObject['bg']).gotoAndStop(int(inAttributeValue));
					}
					break;
				}
				case 'txtText':
				{
					if (inDisplayObject['txt'])
					{
						inDisplayObject['txt'].text = textHandler(String(inAttributeValue));
					}
					
					break;
				}
				case 'text':
				{
					if (inDisplayObject is ILabel)
					{
						ILabel(inDisplayObject).text = textHandler(String(inAttributeValue));
						break;
					}
					else
					{
						Tracer.echo('---- not label and text button : ' + inDisplayObject,  null, 0xff0000);
					}
				}
				case 'tooltip':
				{
					if (inDisplayObject is ApplicationDisplayObject)
					{
						(inDisplayObject as ApplicationDisplayObject).tooltip = textHandler(String(inAttributeValue));
					}
					break;
				}
				case 'txtX':
				{
					inDisplayObject['txt'].x = Number(sizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'txtY':
				{
					inDisplayObject['txt'].y = Number(sizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'txtAutoSize':
				{
					TextField(inDisplayObject['txt']).autoSize = String(txtAutoSizeHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'txtColor':
				{
					TextField(inDisplayObject['txt']).textColor = uint(txtColorHandler(String(inAttributeValue), inDisplayObject, inStage));
					break;
				}
				case 'DPIScale':
				{
					if (inDisplayObject is ApplicationDisplayObject)
					{
						(inDisplayObject as ApplicationDisplayObject).dpiScale = Number(inAttributeValue);
					}
					//DPIScale="160" 
					//inDisplayObject.scaleX = inDisplayObject.scaleY = Tools.getScalingFactorByDPI(Number(inAttributeValue));
					break;
				}
				default:
				{
					Tracer.echo('XMLAttributesConvertor : handle : no matched attribute found : ' + inDisplayObject.name + ' : ' + inAttributeName, XMLAttributesConvertor);
				}
			}
			return inDisplayObject;
		}
		
		static private function textHandler(inValue:String):String 
		{
			if (xmlManager)
			{
				
				var value:String = (xmlManager as XMLManager).getString(inValue);
				
				/*if (!_xmlLang)
				{
					_xmlLang = xmlManager.getAsset(AssetLibID.XML_LANG_COMMON);
				}
				
				if (_xmlLang)
				{
					var targetNode:* = _xmlLang.string.(@id == inValue);
					
					
					if (targetNode is XMLList)
					{
						value = targetNode[0];
					}
				}*/
				
				if (value)
				{
					return value;
				}
			}
			
			return inValue;
		}
		
		public static function positionHandler(inValue:String, inDisplayObject:DisplayObject, inStage:Stage, inAutoAdjust:Boolean):String
		{
			switch(inValue)
			{
				case 'RIGHT': return String(inStage.stageWidth - inDisplayObject.width - ((inAutoAdjust) ? STAGE_MARGIN_WIDTH : 0));
				case 'LEFT' : return String(0 + ((inAutoAdjust) ? STAGE_MARGIN_WIDTH : 0));
				case 'TOP' : return String(0 + ((inAutoAdjust) ? STAGE_MARGIN_WIDTH : 0));
				case 'BOTTOM' : return String(inStage.stageHeight - inDisplayObject.height - ((inAutoAdjust) ? STAGE_MARGIN_WIDTH : 0));
				case 'CENTER' : return String((inStage.stageHeight - inDisplayObject.height) / 2);
				default:
				{
					//Tracer.echo('XMLAttributesConvertor : positionHandler : no value matched : ' + inValue);
					if (ApplicationDisplayObject.isMobile())
					{
						inValue = String(Number(inValue) * Tools.getScalingFactorByDPI());
					}
					
					return inValue;
				}
			}
			
			
		}
		
		public static function txtAutoSizeHandler(inValue:String, inDisplayObject:DisplayObject, inStage:Stage):String
		{
			switch(inValue)
			{
				case 'RIGHT': return TextFieldAutoSize.RIGHT;
				case 'LEFT' : return TextFieldAutoSize.LEFT;
				case 'CENTER' : return TextFieldAutoSize.CENTER;
				case 'NONE' : return TextFieldAutoSize.NONE;
				default:
				{
					//Tracer.echo('XMLAttributesConvertor : txtAutoSizeHandler : no value matched : ' + inValue);
					return inValue;
				}
			}
			
			
		}
		
		public static function txtColorHandler(inValue:String, inDisplayObject:DisplayObject, inStage:Stage):uint
		{
			switch(inValue)
			{
				case 'WHITE': return 0xffffff;
				case 'BLACK' : return 0x000000;
				
				default: return 0x000000;
			}
			
			
		}
		
		public static function sizeHandler(inValue:String, inDisplayObject:DisplayObject, inStage:Stage):String
		{
			switch(inValue)
			{
				case 'stageWidth': return String(inStage.stageWidth);
				case 'stageHeight' : return String(inStage.height);
				default:
				{
					//Tracer.echo('XMLAttributesConvertor : sizeHandler : no value matched : ' + inValue);
					return inValue;
				}
				
			}
			
		}
	}

}