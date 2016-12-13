package myShopper.common.data.shop 
{
	import myShopper.common.data.FileImageVO;
	import myShopper.common.data.VO;
	import myShopper.common.emun.FileType;
	/**
	 * ...
	 * @author Toshi
	 */
	public class ShopCustomPageVO extends VO
	{
		public var pageNo:String;
		public var pageID:String;
		private var _pageName:String;
		private var _pageTitle:String;
		private var _pageContent:String;
		public var date:String;
		
		public var photoFileVO:FileImageVO;
		
		/*public function set id(inID:String):void
		{
			_id = inID;
		}*/
		
		public function get pageContent():String 
		{
			return _pageContent;
		}
		
		public function set pageContent(value:String):void 
		{
			_pageContent = value;
			dispatchChangeEvent('pageContent', value);
		}
		
		public function get pageTitle():String 
		{
			return _pageTitle;
		}
		
		public function set pageTitle(value:String):void 
		{
			_pageTitle = value;
			dispatchChangeEvent('pageTitle', value);
		}
		
		public function get pageName():String 
		{
			return _pageName;
		}
		
		public function set pageName(value:String):void 
		{
			_pageName = value;
			dispatchChangeEvent('pageName', value);
		}
		
		public function ShopCustomPageVO
		(
			inVOID:String,
			inPageNo:String = '', 
			inPageID:String = '', 
			inPageName:String = '',
			inPageTitle:String = '',
			inPageContent:String = '',
			inDate:String = ''
		) 
		{
			super(inVOID);
			
			pageNo = inPageNo;
			pageID = inPageID;
			pageName = inPageName;
			pageTitle = inPageTitle;
			pageContent = inPageContent;
			date = inDate;
			
			photoFileVO = new FileImageVO(_id);
			photoFileVO.path = FileType.PATH_SHOP_CUSTOM;
		}
		
		override public function clear():void
		{
			pageNo = '';
			pageID = '';
			pageName = '';
			pageTitle = '';
			pageContent = '';
			date = '';
			photoFileVO.clear();
		}
		
	}

}