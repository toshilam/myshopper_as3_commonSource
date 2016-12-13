package myShopper.common.net 
{
	import myShopper.common.interfaces.IFacebookResponder;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class FacebookResponder implements IFacebookResponder 
	{
		//public var onFBResult:Function;
		public var onResult:Function;
		public var onFault:Function;
		
		//protected var _isHandleError:Boolean;
		
		public function FacebookResponder() 
		{
			onResult = new Function();
			onFault = new Function();
			
			//_isHandleError = false;
		}
		
		/* INTERFACE myShopper.common.interfaces.IFacebookResponder */
		
		public function fbResult(inData:Object, inFault:Object/*, inHandleError:Boolean = true*/):Boolean 
		{
			//_isHandleError = inHandleError;
			
			if (inData)
			{
				result(inData);
				return true;
			}
			else if (inFault)
			{
				fault(inFault);
			}
			
			return false;
		}
		
		public function result(data:Object):void 
		{
			try
			{
				onResult(data);
			}
			catch (e:Error)
			{
				Tracer.echo('FacebookResponder : result : error executing onResult!');
			}
		}
		
		public function fault(info:Object):void 
		{
			try
			{
				onFault(info);
			}
			catch (e:Error)
			{
				Tracer.echo('FacebookResponder : fault : error executing onFault!');
			}
		}
		
	}

}