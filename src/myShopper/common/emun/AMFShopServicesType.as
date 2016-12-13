package myShopper.common.emun 
{
	/**
	 * amf sservice types, that has to be matched with server side.
	 * @author Toshi
	 */
	public class AMFShopServicesType
	{
		//shop services
		public static const REGISTER:String = 'shopper.shops.Shop.register';
		public static const GET_INFO_BY_USER_ID:String = 'shopper.shops.Shop.getInfoByUserID'; //shop info
		public static const UPLOAD_IMAGE:String = 'shopper.shops.Shop.uploadImage';
		public static const DOWNLOAD_IMAGE:String = 'shopper.shops.Shop.downloadImage';
		public static const GET_ABOUT:String = 'shopper.shops.Shop.getAbout';
		public static const GET_INFO_BY_SHOP_ID:String = 'shopper.shops.Shop.getInfoByShopID'; //sp-XXXXXX
		public static const GET_NEWS:String = 'shopper.shops.Shop.getNews';
		public static const GET_CUSTOM:String = 'shopper.shops.Shop.getCustom';
		public static const GET_PRODUCT:String = 'shopper.shops.Shop.getProduct';
		public static const GET_PRODUCT_BY_NO:String = 'shopper.shops.Shop.getProductByNo';
		public static const GET_CATEGORY:String = 'shopper.shops.Shop.getCategory';
		public static const GET_COUNTRY:String = 'shopper.shops.Shop.getCountry';
		public static const GET_CITY:String = 'shopper.shops.Shop.getCity';
		public static const GET_AREA:String = 'shopper.shops.Shop.getArea'; //not used?
		public static const GET_CATEGORY_PRODUCT:String = 'shopper.shops.Shop.getCategoryAndProduct';
		
		//for shop client app
		public static const USER_CONTACT:String = 'shopper.shops.Shop.userContact';
	}

}