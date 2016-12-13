package myShopper.common.emun 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class AMFShopperServicesType 
	{
		public static const CONTACT_ADMIN:String = 'shopper.shopper.Shopper.contactAdmin'; //when fail set shopper data, (sql service may down) send email to admin
		public static const CONTACT_US_SHOP:String = 'shopper.shopper.Shopper.contactUsShop';
		public static const CONTACT_US:String = 'shopper.shopper.Shopper.contactUs';
		public static const POPUP:String = 'shopper.shopper.Shopper.popup'; //popup iframe window
		public static const GET_PRODUCT_CATEGORY:String = 'shopper.shopper.Shopper.getCategoryAndProduct';
		public static const GET_CITY_AREA:String = 'shopper.shopper.Shopper.getCityArea'; //used for map and shop registration form. Data seperately stored in different vo object
		public static const GET_ACTIVE_CITY:String = 'shopper.shopper.Shopper.getActiveCity';
		public static const GET_ACTIVE_COUNTRY:String = 'shopper.shopper.Shopper.getActiveCountry';
		public static const GET_STATE_BY_COUNTRY_ID:String = 'shopper.shopper.Shopper.getStateByCountryID';
		public static const GET_CITY_BY_STATE_ID:String = 'shopper.shopper.Shopper.getCityByStateID';
		//public static const GET_ACTIVE_COUNTRY_CITY_AREA:String = 'shopper.shopper.Shopper.getActiveCountryCityArea';
		public static const SEARCH_SHOP:String = 'shopper.shopper.Shopper.searchShop';
		public static const GET_NEW_SHOP:String = 'shopper.shopper.Shopper.getNewShop';
		public static const GET_HOT_PRODUCT:String = 'shopper.shopper.Shopper.getHotProduct';
	}

}