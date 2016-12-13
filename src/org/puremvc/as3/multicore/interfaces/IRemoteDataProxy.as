package org.puremvc.as3.multicore.interfaces
{
	
	/**
	 * An object help managing/handling data before/after sending/receiving from/to server
	 * @author Toshi Lam
	 */
	public interface IRemoteDataProxy extends IApplicationProxy
	{
		/**
		 * help managing/handlig data before send via AMF
		 * @param	inService - type of service
		 * @param	inData - the data to be handled
		 * @return
		 */
		function getRemoteData(inService:String, inData:Object = null):Boolean;
		
		/**
		 * help managing/handling data the received from AMF
		 * @param	inService
		 * @param	inData
		 * @return
		 */
		function setRemoteData(inService:String, inData:Object):Boolean;
	}
	
}