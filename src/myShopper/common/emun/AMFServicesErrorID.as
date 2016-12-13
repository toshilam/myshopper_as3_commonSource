package myShopper.common.emun 
{
	/**
	 * AMF services error code, all the error code are the same with PHP error code
	 * @author Toshi
	 */
	public class AMFServicesErrorID
	{
		/**
		 * no error
		 */
		public static const NONE:String = '0';
		
		public static const CALL_FAIL:String = '1';
		
		/**
		 * DB error
		 */
		public static const USER_LOGIN_FAIL:String = '500';
		
		/**
		 * DB error
		 */
		public static const DB_GET_DATA:String = '1000';
		
		/**
		 * DB error inserting data
		 */
		public static const DB_INSERT_DATA:String = '1001';
		
		/**
		 * invalid data
		 */
		public static const INVALID_DATA:String = '2000';
		
		/**
		 * error creating data
		 */
		public static const CREATE_DATA:String = '2001';
		
		/**
		 * missing data
		 */
		public static const MISS_DATA:String = '2002';
		
		/**
		 * duplicated data
		 */
		public static const DUPLICATE_DATA:String = '2003';
		
		
		/**
		 * FMS  
		 * shop together : fail join a group
		 * 2100 : as user already joined another already
		 * 2101 : group not exist
		 * 2102 : myself already shopping together, can not join one more group
		 */
		public static const E2100:String = '2100';
		public static const E2101:String = '2101';
		public static const E2102:String = '2102';
		
		/**
		 * error sending email
		 */
		public static const EMAIL_SEND_FAIL:String = '3000';
		
		/**
		 * paypal error from 4000
		 */
		public static const PAYPAL_VERIFY_ACC_STATUS_FAIL:String = '4000';
		
	}

}