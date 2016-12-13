package myShopper.common
{
	/**
	 * ...
	 * @author Toshi
	 */
	public class Config
	{
		//TODO : to be removed, use CONFIG::debug / CONFIG::release instead of!
		public static const IS_TEST_MODE:Boolean = false;
		
		public static const APPLICATION_TITLE:String = 'MY SHOPPER';
		public static const APPLICATION_URI:String = 'myshoppersp';
		
		public static const PF_CODE_WEB:String = 'web';
		public static const PF_CODE_QQ:String = 'qq';
		public static const PF_CODE_FB:String = 'fb';
		public static const PF_CODE_MOBILE:String = 'mob';
		//public static const PF_CODE_MOBILE_ANDROID:String = 'mobAnd';
		//public static const PF_CODE_MOBILE_IOS:String = 'mobIOS';
		
		public static const LANG_CODE_EN:String = 'en';
		public static const LANG_CODE_CHT:String = 'cht';
		public static const LANG_CODE_CHS:String = 'chs';
		public static const LANG_CODE_JP:String = 'jp';
		
		public static const CURRENCY_NO_HKD:int = 0;
		public static const CURRENCY_NO_USD:int = 2;
		public static const CURRENCY_NO_JPY:int = 3;
		public static const CURRENCY_NO_TWD:int = 4;
		public static const CURRENCY_NO_SGD:int = 5;
		public static const CURRENCY_NO_THB:int = 6;
		public static const CURRENCY_NO_PHP:int = 7;
		
		//NOTE: currency code has to be matched with paypal code
		public static const CURRENCY_CODE_HKD:String = 'HKD';
		public static const CURRENCY_CODE_USD:String = 'USD';
		public static const CURRENCY_CODE_JPY:String = 'JPY';
		public static const CURRENCY_CODE_TWD:String = 'TWD';
		public static const CURRENCY_CODE_SGD:String = 'SGD';
		public static const CURRENCY_CODE_THB:String = 'THB';
		public static const CURRENCY_CODE_PHP:String = 'PHP';
		
		public static const COUNTRY_HK:String = 'HK';
		
		public static const APP_HEADER_HEIGHT:int = 55;
		public static const APP_FOOTER_HEIGHT:int = 30;
		
		public static const STAGE_MARGIN_WIDTH:int = 7;
		public static const PASSWORD_LENGHT:int = 6;
		
		public static const BUTTON_GAP:int = 10;
		public static const BUTTON_BG_EXTRA_WIDTH:int = 20;
		
		public static const USER_WINDOW_GAP:int = 10;
		
		//toshi.hk google map key / key is store in map module
		//public static const CONTENT_MAP_KEY:String = 'ABQIAAAAgqSBZmaQCieTGPdTS6ZdihRrrPEtAWo65iZ3eN0-A9Zs_hX_kBTcTBlZpxoQ1cTBpcveuCPvkmODEg';
		//public static const CONTENT_MAP_KEY:String = 'ABQIAAAAgqSBZmaQCieTGPdTS6ZdihSaKKSzOV_xdd46O2mF2OLwrM3GKhTcY3G4oED-85RzJBC9YVcQw9cKUA';
		
		public static const PAGE_SERPERATOR:String = '/';
		public static const NETVIAGATOR_SERPERATOR:String = ' > ';
		
		//public static const FMS_APPLICATION:String = 'hkshopper';
		//public static const AMF_GATEWAY:String = 'shopperamf/gateway.php';
		public static const DEFAULT_APP_DPI:Number = 160;
		
		public static const FILE_MAX_SIZE_50K:Number = 51200; //50KB
		public static const FILE_MAX_SIZE_100K:Number = 102400; //100KB
		public static const FILE_MAX_SIZE_150K:Number = 153600; //150KB
		public static const FILE_MAX_SIZE_200K:Number = 204800; //200KB
		public static const FILE_MAX_SIZE_500K:Number = 512000; //500KB
		public static const FILE_MAX_SIZE_1M:Number = 1024000; //1m
		public static const FILE_MAX_SIZE_1_5M:Number = 1536000; //1.5m
		public static const FILE_MAX_SIZE_2M:Number = 2048000; //2m
		
		//public static const FILE_LOGO_UPLOAD_MAX_SIZE:Number = 51200; //50KB
		//public static const FILE_PRODUCT_UPLOAD_MAX_SIZE:Number = 102400; //100KB
		//public static const FILE_BG_UPLOAD_MAX_SIZE:Number = 512000; //500KB
		public static const FILE_LOGO_MAX_WIDTH:uint = 100;
		public static const FILE_LOGO_MAX_HEIGHT:uint = 100;
		
		//public static const FILE_USER_LOGO_UPLOAD_MAX_SIZE:Number = 51200; //50KB
		public static const FILE_USER_LOGO_MAX_WIDTH:uint = 120;
		public static const FILE_USER_LOGO_MAX_HEIGHT:uint = 120;
		
		//public static const FILE_USER_PHOTO_UPLOAD_MAX_SIZE:Number = 512000; //500KB
		
		public static const FILE_NEWS_MAX_WIDTH:uint = 450;
		public static const FILE_NEWS_MAX_HEIGHT:uint = 400;
		
		public static const TEXT_FIELD_EMAIL_RESTRICT:String = '.@a-zA-Z0-9_\\-';
		public static const TEXT_FIELD_SIGN_RESTRICT:String = "^`~!@#$%/\\^&*+=";
		public static const TEXT_FIELD_SIGN_RESTRICT_WITHOUT_SPACE:String = "^`~!@#$%/\\^&*+= ";
		public static const TEXT_FIELD_NUMBER:String = "0-9";
		public static const TEXT_FIELD_PRICE:String = "0-9.";
		
		public static const HYPHEN_CHAR:String = "-";
		
		public static const URL_SHOPPER_ABOUT:String = 'http://sp.my-shopper.com/{0}/';
		public static const URL_SHOPPER_PRIVCY:String = '/help/policies/privacy.php';
		public static const URL_SHOPPER_TERMS:String = '/help/policies/terms.php';
		public static const URL_SHOPPER_SHIPPING:String = '/help/shipment/p1.php';
		public static const URL_SHOPPER_BENEFIT:String = '/help/info/benefit.php';
		public static const URL_SHOPPER_PROCEDURE:String = 'http://spdoc.my-shopper.com/{0}/getting-started#OnlineShoppingProcedure';
		public static const URL_SHOPPER_USER_PROCEDURE:String = '/help/info/user-shopping-procedure.php';
		public static const URL_SHOPPER_SERVICE:String = '/help/info/pay-service.php';
		public static const URL_SHOPPER_HOWTO:String = 'http://spdoc.my-shopper.com/{0}/getting-started';
		
		public static const URL_SHOPPER_LOGO:String = '/asset/images/common/myshopper/logo.jpg';
		public static const URL_SHOPPER_LOGO2:String = '/asset/images/common/myshopper/logo2_s.jpg';
		public static const URL_SHOPPER_LOGO3:String = '/asset/images/common/myshopper/MySHOPPER_logo_120x120.png';
		
		//public static const FACEBOOK_KEY:String = '171679642849677'; //old
		public static const FACEBOOK_KEY:String = '150762148379076';
		public static const FACEBOOK_FAN_PAGE:String = 'http://www.facebook.com/my.shopper.co';
		public static const WEIBO_FAN_PAGE:String = 'http://www.weibo.com/myshopper';
		public static const QQ_SHARE_PAGE:String = 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?';
		public static const WEIBO_SHARE_PAGE:String = 'http://service.weibo.com/share/share.php?';
		public static const FACEBOOK_MY_SHOPPER_ID:String = '323065627746290';
		//public static const FACEBOOK_CROSS_DOMAIN_URL:String = "https://a2.sphotos.ak.fbcdn.net/crossdomain.xml";
		public static const URL_FACEBOOK_CROSS_DOMAIN:String = "https://fbcdn-profile-a.akamaihd.net/crossdomain.xml";
		
		
		public static const URL_GOOGLE_OAUTH:String = "https://accounts.google.com/o/oauth2/auth";
		public static const GOOGLE_CLIENT_ID:String = "1096387612510.apps.googleusercontent.com";
		
		public static const DB_SALES_DB:String = 'myshopper_shopmgt';
		public static const DB_SALES_TABLE:String = 'shop_sales';
	}

}