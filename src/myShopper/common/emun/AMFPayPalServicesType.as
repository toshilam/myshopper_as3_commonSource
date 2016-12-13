package myShopper.common.emun 
{
	/**
	 * amf sservice types, that has to be matched with server side.
	 * @author Toshi
	 */
	public class AMFPayPalServicesType
	{
		//paypal services
		public static const GET_PAY_KEY:String = 'shopper.paypal.PayPal.getPayKey';
		public static const GET_PAY_DETAIL:String = 'shopper.paypal.PayPal.getPayDetail'; 
		public static const PAY:String = 'shopper.paypal.PayPal.pay'; //to be use by external service
		public static const PAY_SUCCESS:String = 'shopper.paypal.PayPal.paySuccess'; //to be use by external service
		public static const PAY_CANCEL:String = 'shopper.paypal.PayPal.payCancel'; //to be use by external service
		public static const GET_ACC_VERIFY_STATUS:String = 'shopper.paypal.PayPal.getVerifiedStatus'; //check is shop acc is verified
		
		
	}

}