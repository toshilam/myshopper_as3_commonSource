package myShopper.common.data.service 
{
	import myShopper.common.data.paypal.PaypalVO;
	public class PaypalVOService 
	{
		public static const ACK_SUCCESS:String = 'Success';
		public static const ACK_FAILURE:String = 'Failure';
		public static const ACK_WARNING:String = 'Warning';
		public static const ACK_SUCCESS_WARNING:String = 'SuccessWithWarning';
		public static const ACK_FAILURE_WARNING:String = 'FailureWithWarning';
		
		public static const PAYMENT_STATUS_CREATED:String = 'CREATED';
		public static const PAYMENT_STATUS_COMPLETED:String = 'COMPLETED';
		public static const PAYMENT_STATUS_INCOMPLETE:String = 'INCOMPLETE';
		public static const PAYMENT_STATUS_ERROR:String = 'ERROR';
		public static const PAYMENT_STATUS_REVERSALERROR:String = 'REVERSALERROR';
		public static const PAYMENT_STATUS_PROCESSING:String = 'PROCESSING';
		public static const PAYMENT_STATUS_PENDING:String = 'PENDING';
		
		public function PaypalVOService() 
		{
			/*if (!(inVO is CommList))
			{
				throw(new UninitializedError('CommVOService : unknown data type : ' + inVO));
			}
			
			
			_commInfo = inVO;*/
		}
		
		public static function setPayKeyVO(inData:Object, inPayPalVO:PaypalVO):PaypalVO
		{
			inPayPalVO.ack = inData['responseEnvelope']['ack'];
			inPayPalVO.payKey = inData['payKey'];
			inPayPalVO.paymentStatus = inData['paymentExecStatus'];
			
			return inPayPalVO
		}
		
		public static function setPayDetailVO(inData:Object, inPayPalVO:PaypalVO):PaypalVO
		{
			inPayPalVO.ack = inData['responseEnvelope']['ack'];
			inPayPalVO.paymentStatus = inData['status'];
			
			return inPayPalVO
		}
	}

}