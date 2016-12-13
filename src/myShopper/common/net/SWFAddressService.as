package myShopper.common.net 
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.events.EventDispatcher;
	import myShopper.common.Config;
	import myShopper.common.emun.PageID;
	import myShopper.common.emun.SWFAddressServicesType;
	import myShopper.common.events.PageEvent;
	import myShopper.common.interfaces.IService;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.utils.Tracer;
	
	[Event(name="urlChanged", type="myShopper.common.events.PageEvent")] 
	[Event(name="urlAdded", type="myShopper.common.events.PageEvent")] 
	[Event(name="urlRemoved", type="myShopper.common.events.PageEvent")] 
	[Event(name="urlNotValidate", type="myShopper.common.events.PageEvent")] 
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class SWFAddressService extends EventDispatcher implements IService
	{
		private var _arrPage:Vector.<String>;
		private var _currentPages:String;
		private var _arrCurrentPages:Array;
		
		protected var _responderMap:Object;
		
		//a list of prefix url value, currently used for language code
		//once it is set, swfaddress url will be always include these value
		//but event will exclude these prefix value
		protected var _arrPrefix:Vector.<String>;
		
		public function SWFAddressService(inArrPrefixURL:Vector.<String> = null ) 
		{
			_responderMap = new Object();
			_arrPage = new Vector.<String>();
			_currentPages = '';
			//_arrCurrentPages = new Array();
			_arrCurrentPages = SWFAddress.getPathNames();
			
			_arrPrefix = inArrPrefixURL;
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, SWFAddressEventHandler);
		}
		
		public function request(inRequest:IServiceRequest):Boolean
		{
			Tracer.echo('SWFAddressService : requesting page : ' + inRequest.data, this, 0xFF0000);
			
			/*if (!(inRequest.requester.result is Function) || !(inRequest.requester.fault is Function))
			{
				Tracer.echo('SWFAddressService : missing responder! ', this, 0xFF0000);
				return false;
			}*/
			
			if (_responderMap[inRequest.data] || _currentPages == inRequest.data)
			{
				Tracer.echo('SWFAddressService : some request made! ', this, 0xFF0000);
				return false;
			}
			
			
			switch(inRequest.type)
			{
				case SWFAddressServicesType.PAGE_ADD: 
				case SWFAddressServicesType.PAGE_REMOVE: 
				case SWFAddressServicesType.PAGE_SET: 
				case SWFAddressServicesType.PAGE_NEXT: 
				case SWFAddressServicesType.PAGE_PREV: 
				{
					if (inRequest.type == SWFAddressServicesType.PAGE_SET)
					{
						//to store request for calling back later / data = url
						_responderMap[inRequest.data] = inRequest;
					}
					
					var func:Function = getFunctionByServiceType(inRequest.type);
					if ( !(func) || !func(inRequest.data) )
					{
						if (_responderMap[inRequest.data])
						{
							delete _responderMap[inRequest.data];
						}
						
						if (inRequest.requester)
						{
							//call back requester if fail set page
							inRequest.requester.fault(new Error('SWFAddressService : request fail : ' + inRequest.data));
							return false;
						}
						
					}
					
					
					
					
					break;
				}
				default:
				{
					Tracer.echo('SWFAddressService : request : unknown service type ' + inRequest.type, this, 0xFF0000);
				}
			}
			
			return true;
		}
		
		private function SWFAddressEventHandler(e:SWFAddressEvent):void 
		{
			Tracer.echo(e, this, 0x883366);
			
			var newPages:String = '';
			var newArrPages:Array = new Array();
			
			var numItem:int = e.pathNames.length
			
			for (var i:int = 0; i < numItem; i++)
			{
				/***** handle prefix ******/
				if ( _arrPrefix && _arrPrefix.length - 1 >= i )
				{
					//if the current value matched with prefix value, cut
					var prefixPageIndex:int = e.pathNames.indexOf(_arrPrefix[i]);
					if (prefixPageIndex != -1)
					{
						//e.pathNames.splice(i, 1);
						continue;
					}
				}
				
				newArrPages.push(e.pathNames[i]);
				newPages += e.pathNames[i] + ((i == e.pathNames.length - 1) ? '' : '/');
			}
			
			if (newPages == _currentPages) 
			{
				Tracer.echo('SWFAddressService : SWFAddressEventHandler : same page : ' + _currentPages, this, 0xff0000);
				return;
			}
			
			_currentPages = newPages;
			
			if (!isValidatedPage(_currentPages)) 
			{
				Tracer.echo('SWFAddressService : SWFAddressEventHandler : NOT ValidatedPage : ' + _currentPages, this, 0xff0000);
				SWFAddress.setValue(PageID.HOME + '/');
				return;
			}
			
			_arrCurrentPages =  newArrPages;
			
			Tracer.echo('SWFAddressService : page changed to : ' + _currentPages, this, 0x883366);
			
			var pageEvent:PageEvent = new PageEvent(PageEvent.URL_CHANGED, newArrPages[newArrPages.length - 1], _currentPages, _arrCurrentPages);
			
			//call back requester if it's in responderMap
			var serviceRequest:IServiceRequest = _responderMap[_currentPages];
			if (!serviceRequest)
			{
				Tracer.echo('SWFAddressService : result : no service requester found! ' + _currentPages, this, 0xFF0000);
			}
			else
			{
				delete _responderMap[_currentPages];
				
				if (serviceRequest.requester)
				{
					serviceRequest.requester.result(pageEvent);
				}
				
				
			}
			
			SWFAddress.setTitle(Config.APPLICATION_TITLE + ' / ' +  _currentPages.replace('/', ' / '));
			
			dispatchEvent(pageEvent);
			
			/*var resultPage:* = isDynamicPage(_currentPages);
			if (resultPage === false)
			{
				sendNotification(CHANGE_PAGE + _currentPages);
			}
			else
			{
				if (resultPage is Array)
				{
					sendNotification(CHANGE_PAGE + resultPage[0], resultPage[1]);
				}
			}*/
		}
		
		public function trace(inAttr:Array = null):void
		{
			Tracer.echo('getBaseURL : ' + SWFAddress.getBaseURL());
			Tracer.echo('getHistory : ' + SWFAddress.getHistory());
			Tracer.echo('getPath : ' + SWFAddress.getPath());
			Tracer.echo('getPathNames : ' + SWFAddress.getPathNames());
			Tracer.echo('getQueryString : ' + SWFAddress.getQueryString());
			Tracer.echo('getStatus : ' + SWFAddress.getStatus());
			Tracer.echo('getStrict : ' + SWFAddress.getStrict());
			Tracer.echo('getTitle : ' + SWFAddress.getTitle());
			Tracer.echo('getTracker : ' + SWFAddress.getTracker());
			Tracer.echo('getValue : ' + SWFAddress.getValue());
			
			Tracer.echo('getParameter : ' + SWFAddress.getParameterNames());
			if (inAttr && inAttr.length)
			{
				while (inAttr.length)
				{
					Tracer.echo('getParameterNames : ' + SWFAddress.getParameter(inAttr.splice(0, 1)));
				}
			}
		}
		
		private function getFunctionByServiceType(inType:String):Function 
		{
			if 		(inType == SWFAddressServicesType.PAGE_ADD) 	return addPage;
			else if (inType == SWFAddressServicesType.PAGE_REMOVE) 	return removePage;
			else if (inType == SWFAddressServicesType.PAGE_SET) 	return setPage;
			else if (inType == SWFAddressServicesType.PAGE_NEXT) 	return nextPage;
			else if (inType == SWFAddressServicesType.PAGE_PREV) 	return prevPage;
			
			return null;
		}
		
		private function nextPage(inData:Object = null):Boolean
		{
			SWFAddress.forward();
			return true;
		}
		
		private function prevPage(inData:Object = null):Boolean
		{
			SWFAddress.back();
			return true;
		}
		
		private function addPage(inPage:String):Boolean
		{
			if (!_arrPage) return false;
			if (hasPage(inPage)) 
			{
				Tracer.echo('SWFAddressService : addPage : page exists  : ' + inPage, this, 0x883399);
				return false;
			}
			
			_arrPage.push(inPage);
			dispatchEvent(new PageEvent(PageEvent.URL_ADDED, inPage, _currentPages, _arrCurrentPages));
			Tracer.echo('SWFAddressService : addPage : added : ' + inPage, this, 0x883399);
			
			return true;
		}
		
		private function setPage(inPage:String):Boolean
		{
			if (!isValidatedPage(inPage))
			{
				dispatchEvent(new PageEvent(PageEvent.URL_NOT_VALIDATE, inPage, _currentPages, _arrCurrentPages));
				Tracer.echo('SWFAddressService : setPage : is not validated page : ' + inPage, this, 0x883399);
				return false;
			}
			
			
			if (inPage == _currentPages)
			{
				Tracer.echo('SWFAddressService : setPage : same page : ' + inPage, this, 0x883399);
				return false;
			}
			
			/************* ADD prefix URL / currently used for lang code ************/
			var prefixURL:String  = '';
			
			if (_arrPrefix)
			{
				var numItem:int = _arrPrefix.length;
				for (var i:int = 0; i < numItem; i++)
				{
					prefixURL += _arrPrefix[i] + '/';
				}
			}
			/************* END ADD prefix URL / currently used for lang code ************/
			
			
			SWFAddress.setValue(prefixURL + inPage + '/');
			//trace();
			return true;
		}
		
		private function removePage(inPage:String):Boolean
		{
			if (!_arrPage || !_arrPage.length) return false;
			
			for (var i:uint = 0; i < _arrPage.length; i++)
			{
				if (_arrPage[i] == inPage)
				{
					_arrPage.splice(i, 1);
					dispatchEvent(new PageEvent(PageEvent.URL_REMOVED, inPage, _currentPages, _arrCurrentPages));
					Tracer.echo('SWFAddressService : setPage : page removed : ' + inPage, this, 0x883399);
					return true;
				}
			}
			
			Tracer.echo('SWFAddressService : setPage : page not found! : ' + inPage, this, 0x883399);
			return false;
		}
		
		public function hasPage(inPage:String):Boolean
		{
			//return isValidatedPage(inPage);
			if (_arrPage && _arrPage.length)
			{
				for (var i:uint = 0; i < _arrPage.length; i++)
				{
					if (_arrPage[i] == inPage)
					{
						return true;
					}
				}
			}
			
			
			return false;
		}
		
		public function getBaseURL():String
		{
			return SWFAddress.getBaseURL();
		}
		
		public function getCurrentPage():String
		{
			return _currentPages;
		}
		
		public function getCurrentPages():Array
		{
			return _arrCurrentPages;
		}
		
		private function isValidatedPage(inPage:String):Boolean
		{
			//CHANGED on 17/02/2012 : each module handles url by themselves
			//NOTE : already return true
			return true;
			
			if (!_arrPage || !_arrPage.length) return false;
			
			//cut peram out
			if (inPage.indexOf('?') != -1)
			{
				inPage = inPage.split('?')[0];
			}
			
			//cut '/' if at the end of url
			if (inPage.charAt(inPage.length - 1) == '/')
			{
				inPage = inPage.substring(0, inPage.length -1 );
			}
			
			for (var i:uint = 0; i < _arrPage.length; i++)
			{
				if (_arrPage[i] == inPage)
				{
					return true;
				}
			}
			
			return false;
		}
	}

}