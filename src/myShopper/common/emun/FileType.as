package myShopper.common.emun 
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class FileType
	{
		public static const NAME:String = 'fileType';
		
		public static const TYPE_XML:String = 'xml';
		public static const TYPE_SWF:String = 'swf';
		public static const TYPE_BYTE:String = 'byte';
		public static const TYPE_IMG:String = 'img';
		
		/* which part file will be used */
		public static const PATH_SHOP_LOGO:String = '/shop/logo/';
		public static const PATH_SHOP_BG:String = '/shop/bg/';
		public static const PATH_SHOP_PRODUCT:String = '/shop/product/';
		public static const PATH_SHOP_PRODUCT_S:String = '/shop/product-s/';
		public static const PATH_SHOP_PRODUCT_M:String = '/shop/product-m/';
		public static const PATH_SHOP_PRODUCT_L:String = '/shop/product-l/';
		public static const PATH_SHOP_NEWS:String = '/shop/news/';
		public static const PATH_SHOP_CUSTOM:String = '/shop/custom/';
		
		public static const PATH_USER_LOGO:String = '/user/logo/';
		public static const PATH_USER_BG:String = '/user/bg/';
		public static const PATH_USER_PHOTO:String = '/user/photo/';
		
		public static const PATH_IMAGE_SIZE_100:String = '/100x100/'; //not the actual image path, it used for replace image when define one not found
		
		public function FileType() 
		{
			
		}
		
	}

}