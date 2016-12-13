package myShopper.common.emun 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class OrderStatusID
	{
		public static const ORDER_ORDER:String = '-2'; //make a order and notify shop
		public static const ORDER_WAITING_PAYMENT:String = '-1'; //shop sent an invoice to user, and wait for payment
		public static const ORDER_PAID:String = '0'; //user paid for the order
		public static const ORDER_PREPARE_DELIVERY:String = '1';
		public static const ORDER_DELIVERING:String = '2';
		public static const ORDER_DELIVERED:String = '3'; 
		public static const ORDER_RECEIVED:String = '4'; //user confirm received the goods
		
	}

}