package myShopper.common.data.paypal 
{
	import myShopper.common.data.VO;
	import myShopper.common.interfaces.IVO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class PaypalVO extends VO 
	{
		//public var defaultFundingPlan:String;
		public var payKey:String;
		public var paymentStatus:String;
		public var ack:String;
		
		public function PaypalVO(inID:String/*, inPayKey:String, inPaymentStatus:String, inAck:String*/) 
		{
			super(inID);
			//payKey = inPayKey;
			//paymentExecStatus = inPaymentStatus;
			//ack = inAck;
		}
		
		override public function clear():void 
		{
			payKey = paymentStatus = ack = null;
		}
		
		override public function clone():IVO 
		{
			return new PaypalVO(_id/*, payKey, paymentExecStatus, ack*/);
		}
		
	}

}