package myShopper.common.utils 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import myShopper.common.Config;
	import myShopper.common.data.AlerterVO;
	import myShopper.common.display.ApplicationDisplayObject;
	import myShopper.common.emun.AlerterType;
	import myShopper.common.emun.AssetLibID;
	import myShopper.common.emun.SWFClassID;
	import myShopper.common.events.AlerterEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IDataDisplayObject;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IVO;
	import myShopper.fl.Alerter;
	import myShopper.fl.ConfirmAlerter;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class Alert extends EventDispatcher 
	{
		private static var instance:Alert;
		
		//the target display to be shown alert
		private static var _target:ApplicationDisplayObject;
		//the asset manager container all common asset
		private static var _assetManager:IDataManager;
		
		//the alerter which is current on stage
		private static var _onStageObject:ApplicationDisplayObject
		public static function get onStageObject():ApplicationDisplayObject 
		{
			return _onStageObject;
		}
		
		//an array contains all alert which is waiting to be shown, object will be removed once an alerts is confiramed
		private static var _arrAlert:Vector.<IVO>;
		
		public function Alert(pvt:PrivateClass, inTarget:ApplicationDisplayObject = null, inAssetManager:IDataManager = null) 
		{
			//only able to set it once, to avoid override previous setting
			if (!_assetManager && inAssetManager) _assetManager = inAssetManager;
			if (!_target && inTarget) _target = inTarget;
			
			_arrAlert = new Vector.<IVO>();
		}
		
		public static function getInstance(inTarget:ApplicationDisplayObject = null, inAssetManager:IDataManager = null):Alert
		{
			if (Alert.instance == null) 
			{
				Alert.instance = new Alert(new PrivateClass(), inTarget, inAssetManager);
			}
			
			
			return Alert.instance;
		}
		
		public static function show(inVO:IVO):ApplicationDisplayObject
		{
			if (!_target && !_assetManager)
			{
				Tracer.echo('Alert : show : target object or asset manager is not set yes!', Alert, 0xff0000);
				return null;
			}
			
			if (!(inVO is AlerterVO))
			{
				Tracer.echo('Alert : show : unknown data type ' + inVO, Alert, 0xff0000);
				return null;
			}
			
			var vo:AlerterVO = inVO as AlerterVO;
			
			var alert:ApplicationDisplayObject;
			
			//if (vo.type == AlerterType.DISPLAY_OBJECT && vo.data is ApplicationDisplayObject)
			//{
				//alert = vo.data as ApplicationDisplayObject;
			//}
			//else
			//{
				alert = getAlertByType(vo);
			//}
			
			if (!_onStageObject)
			{
				//_arrAlert.push(alert);
				_onStageObject = alert;
				
				if (alert is IDataDisplayObject)
				{
					IDataDisplayObject(alert).setInfo(inVO);
				}
				
				
				createMask();
				
				if (alert is Alerter) //alerter no need to wait for response
				{
					alert.addEventListener(MouseEvent.CLICK, mouseEventHandler, false, 0, true);
					_target.stage.addEventListener(MouseEvent.CLICK, mouseEventHandler, false, 0, true);
				}
				else if (alert is ConfirmAlerter) // yes/no alerter
				{
					var ca:ConfirmAlerter = alert as ConfirmAlerter;
					ca.addEventListener(AlerterEvent.CANCEL, confirmAlerterHandler, false, 0, true);
					ca.addEventListener(AlerterEvent.CONFIRM, confirmAlerterHandler, false, 0, true);
					ca.addEventListener(AlerterEvent.CLOSE, confirmAlerterHandler, false, 0, true);
				}
				else if (alert is ApplicationDisplayObject)
				{
					/*var container:ApplicationDisplayObject = alert.parent as ApplicationDisplayObject;
					
					if (container)
					{
						container.addEventListener(
					}*/
				}
				
				
				_target.addApplicationChild(alert, vo.settingXML, vo.autoShow);
				
			}
			else
			{
				Tracer.echo('Alert : show : unable to show object, added to queue : ' + vo.type, Alert, 0xff0000);
				//return null;
				
				_arrAlert.push(vo);
				
				//alert = getAlertByType(vo);
			}
			
			return alert;
		}
		
		public static function close(inAutoClose:Boolean = true):ApplicationDisplayObject
		{
			removeMask();
			if (_onStageObject)
			{
				_target.removeApplicationChild(_onStageObject, inAutoClose);
				
				var onStageObject:ApplicationDisplayObject = _onStageObject;
				_onStageObject = null;
				
				if (_arrAlert.length)
				{
					Alert.show(_arrAlert.splice(0, 1)[0]);
				}
				
				return onStageObject;
			}
			
			
			return null;
		}
		
		private static function createMask():void
		{
			var mask:ApplicationDisplayObject = _target.subDisplayObjectList.getDisplayObjectByID(SWFClassID.BG_WHITE) as ApplicationDisplayObject
			if (!mask)
			{
				mask = _target.addApplicationChild(_assetManager.getData(SWFClassID.BG_WHITE, AssetLibID.AST_COMMON), null, false) as ApplicationDisplayObject;
				mask.alpha = 0.2;
				mask.width = _target.stage.stageWidth;
				mask.height = _target.stage.stageHeight;
				
				_target.stage.addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			}
			
		}
		
		private static function removeMask():void
		{
			var mask:ApplicationDisplayObject = _target.subDisplayObjectList.getDisplayObjectByID(SWFClassID.BG_WHITE) as ApplicationDisplayObject;
			if (mask)
			{
				var autoClose:Boolean = !ApplicationDisplayObject.isMobile();
				_target.removeApplicationChild(mask, false /*autoClose*/);
			}
		}
		
		private static function resizeHandler(e:Event):void 
		{
			var mask:ApplicationDisplayObject = _target.subDisplayObjectList.getDisplayObjectByID(SWFClassID.BG_WHITE) as ApplicationDisplayObject;
			if (mask)
			{
				mask.width = _target.stage.stageWidth;
				mask.height = _target.stage.stageHeight;
			}
		}
		
		
		public static function create(inVO:IVO):ApplicationDisplayObject
		{
			if (!_assetManager)
			{
				Tracer.echo('Alert : show : target object or asset manager is not set yes!', Alert, 0xff0000);
				return null;
			}
			
			if (!(inVO is AlerterVO))
			{
				Tracer.echo('Alert : create : unknown data type ' + inVO, Alert, 0xff0000);
				return null;
			}
			
			var alert:IDataDisplayObject = _assetManager.getData(SWFClassID.FORM_ALERTER, AssetLibID.AST_COMMON);
			
			if (alert)
			{
				if ( alert.setInfo(inVO) )
				{
					return alert as ApplicationDisplayObject;
				}
			}
			
			Tracer.echo('Alert : create : unable to create alerter object ', Alert, 0xff0000);
			return null;
		}
		
		private static function mouseEventHandler(e:MouseEvent):void 
		{
			_onStageObject.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			_target.stage.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			
			close();
		}
		
		private static function confirmAlerterHandler(e:AlerterEvent):void 
		{
			if (e.targetDisplayObject.hasEventListener(AlerterEvent.CANCEL))
			{
				e.targetDisplayObject.removeEventListener(AlerterEvent.CANCEL, confirmAlerterHandler);
				e.targetDisplayObject.removeEventListener(AlerterEvent.CONFIRM, confirmAlerterHandler);
				e.targetDisplayObject.removeEventListener(AlerterEvent.CLOSE, confirmAlerterHandler);
			}
			
			//_target.removeApplicationChild(e.targetDisplayObject as IApplicationDisplayObject);
			
			//_onStageObject = null;
			//
			//removeMask();
			
			close();
		}
		
		private static function getAlertByType(inVO:AlerterVO):ApplicationDisplayObject
		{
			if		(inVO.type == AlerterType.CONFIRM) return _assetManager.getData(SWFClassID.CONFIRM_ALERTER, AssetLibID.AST_COMMON);
			else if	(inVO.type == AlerterType.MESSAGE) return _assetManager.getData(SWFClassID.MESSAGE_ALERTER, AssetLibID.AST_COMMON);
			else if	(inVO.type == AlerterType.DISPLAY_OBJECT) return inVO.data as ApplicationDisplayObject;
			else 	return _assetManager.getData(SWFClassID.MESSAGE_ALERTER, AssetLibID.AST_COMMON);
		}
	}

}

class PrivateClass
{
	public function PrivateClass():void{}
}