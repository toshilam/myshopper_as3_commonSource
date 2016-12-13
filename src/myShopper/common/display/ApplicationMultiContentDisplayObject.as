package myShopper.common.display 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import myShopper.common.events.ApplicationEvent;
	import myShopper.common.interfaces.IApplicationDisplayObject;
	import myShopper.common.interfaces.IApplicationMultiContentDisplayObject;
	import myShopper.common.interfaces.IVOManager;
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.utils.Tracer;
	
	[Event(name = "contentChanging", type = "myShopper.common.events.ApplicationEvent")]
	/**
	 * ...
	 * @author Toshi
	 */
	public class ApplicationMultiContentDisplayObject extends ApplicationDisplayObject implements IApplicationMultiContentDisplayObject
	{
		//protected var _mainStage:Stage;
		//protected var _dataManager:IDataManager;
		//protected var _voManager:IVOManager;
		//
		//public function get mainStage():Stage { return _mainStage; }
		//public function get dataManager():IDataManager { return _dataManager; }
		//public function get voManager():IVOManager { return _voManager; }
		
		protected var _isChangingContent:Boolean;
		public function get isChangingContent():Boolean { return _isChangingContent; }
		
		protected var _onStageContent:IApplicationDisplayObject;
		public function get onStageContent():IApplicationDisplayObject { return _onStageContent; }
		
		protected var _subscribedStageDisplayObject:IApplicationDisplayObject;
		protected var _showSubscribedStageDisplayObject:Boolean;
		
		public function ApplicationMultiContentDisplayObject() 
		{
			super();
		}
		
		/**
		 * init layout
		 * @param	inMainStage - main stage
		 * @param	inDataManager - data manager which is holding all the swf lib asset
		 * @param	inVOManager - vo manager which is holding all registered value object
		 */
		/*public function initLayout(inMainStage:Stage, inDataManager:IDataManager, inVOManager:IVOManager):void
		{
			_mainStage = inMainStage;
			_dataManager = inDataManager;
			_voManager = inVOManager;
		}*/
		
		/**
		 * to remove the current on stage display object if any, and show the newly added display object onto stage
		 * @param	inDisplayObject - the display object to to shown on stage
		 */
		public function changeContent(inDisplayObject:IApplicationDisplayObject, inAutoTransition:Boolean = true ):IApplicationDisplayObject
		{
			if (inDisplayObject == null)
			{
				Tracer.echo('changeContent : ERROR : inDisplayObject null value', this, 0xff0000);
				return null;;
			}
			
			//if currently removing object, and a new object need to be added in, remove tweener, and remove object instantly
			//if (_isChangingContent && Tweener.isTweening(_onStageContent))
			if (_onStageContent && Tweener.isTweening(_onStageContent))
			{
				Tracer.echo('changeContent : currently previous object is tweening!!', this, 0xff0000);
				
				Tweener.removeTweens(_onStageContent);
				
				dispatchEvent(new ApplicationEvent(ApplicationEvent.CONTENT_CHANGING, inDisplayObject as DisplayObject, _onStageContent));
				
				removeApplicationChild(_onStageContent, false);
				
				if (_onStageContent.hasEventListener(ApplicationEvent.PAGE_CLOSED))
				{
					Tracer.echo('changeContent : currently previous object is being RFEMOVED', this, 0xff0000);
					_onStageContent.removeEventListener(ApplicationEvent.PAGE_CLOSED, pageEventHandler);
				}
				
				if (_onStageContent.hasEventListener(ApplicationEvent.PAGE_SHOW))
				{
					Tracer.echo('changeContent : currently previous object is being SHOWED', this, 0xff0000);
					_onStageContent.removeEventListener(ApplicationEvent.PAGE_SHOW, pageEventHandler);
					
				}
				
				_onStageContent = inDisplayObject;
					
					
				return showContent();
				/*if (Tweener.removeTweens(_onStageContent))
				{
					if (_onStageContent.hasEventListener(ApplicationEvent.PAGE_CLOSED))
					{
						_onStageContent.removeEventListener(ApplicationEvent.PAGE_CLOSED, pageEventHandler);
					}
					
					if (DisplayObject(_onStageContent).parent)
					{
						removeApplicationChild(_onStageContent, false);
					}
					
					_onStageContent = null;
				}*/
			}
			
			if (_onStageContent && _onStageContent.id == inDisplayObject.id) 
			{
				Tracer.echo('changeContent : same content! no change needed : ' + _onStageContent.id, this, 0x996633);
				return _onStageContent;
			}
			
			_subscribedStageDisplayObject = inDisplayObject;
			
			if (_onStageContent != null)
			{
				dispatchEvent(new ApplicationEvent(ApplicationEvent.CONTENT_CHANGING, _subscribedStageDisplayObject as DisplayObject, _onStageContent));
				removeContent(true, inAutoTransition);
			}
			else
			{
				_onStageContent = _subscribedStageDisplayObject;
				showContent();
			}
			
			return inDisplayObject;
		}
		
		/**
		 * to remove the current on stage display object if any.
		 * @param	inShowSubsribedDisplayObject - to show subscribed display object after removing the on stage display object 
		 * 			(it's normally only used by changeContent())
		 * @return the removed display object
		 */
		public function removeContent(inShowSubsribedDisplayObject:Boolean = false, inAutoTransition:Boolean = true):IApplicationDisplayObject
		{
			_showSubscribedStageDisplayObject = inShowSubsribedDisplayObject;
			
			if (_onStageContent != null)
			{
				Tracer.echo('removeContent : removing : ' + _onStageContent.id, this, 0x996633);
				
				_isChangingContent = true;
				
				_onStageContent.addEventListener(ApplicationEvent.PAGE_CLOSED, pageEventHandler);
				removeApplicationChild(_onStageContent, inAutoTransition);
				
				return _onStageContent;
			}
			
			Tracer.echo('removeContent : no content to be removed. ', this, 0x996633);
			return null;
			
		}
		
		/**
		 * show the content which has added previously
		 * @return the on stage display object
		 */
		protected function showContent():IApplicationDisplayObject
		{
			if (_onStageContent == null)
			{
				return null;
			}
			
			Tracer.echo(name + ' : showContent : adding object : ' + _onStageContent.id, this, 0x996633);
			
			_isChangingContent = true;
			
			_onStageContent.addEventListener(ApplicationEvent.PAGE_SHOW, pageEventHandler);
			
			if (!hasApplicationChild(_onStageContent))
			{
				Tracer.echo(name + 'showContent : added object in container : ' + name + ' : content : ' + _onStageContent.id, this, 0x996633);
				addApplicationChild(_onStageContent, null);
				//onStageResize(stage);
				//return _onStageContent;
			}
			else if (_onStageContent.isClosed)
			{
				Tracer.echo(name + 'showContent : adding object : isClosed : ' + _onStageContent.isClosed, this, 0x996633);
				_onStageContent.showPage();
			}
			
			if(_subscribedStageDisplayObject != null) _subscribedStageDisplayObject = null;
			
			onStageResize(stage);
			return _onStageContent;
		}
		
		protected function pageEventHandler(e:ApplicationEvent):void 
		{
			Tracer.echo(name + ' : pageEventHandler : ' + e.type + ' : ' + IApplicationDisplayObject(e.targetDisplayObject).id, this, 0xff0000);
			
			_isChangingContent = false;
			
			if (e.type == ApplicationEvent.PAGE_CLOSED)
			{
				e.targetDisplayObject.removeEventListener(ApplicationEvent.PAGE_CLOSED, pageEventHandler);
				
				_onStageContent = null;
				
				if (_showSubscribedStageDisplayObject) 
				{
					_onStageContent = _subscribedStageDisplayObject;
					showContent();
				}
				
			}
			else if (e.type == ApplicationEvent.PAGE_SHOW)
			{
				e.targetDisplayObject.removeEventListener(ApplicationEvent.PAGE_SHOW, pageEventHandler);
				onStageResize(stage);
			}
		}
	}

}