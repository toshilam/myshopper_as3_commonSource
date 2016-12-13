package myShopper.common.emun 
{
	/**
	 * ...
	 * @author Macentro
	 */
	public class ServiceID
	{
		public static const AMF:String = 'amf';
		//public static const FMS:String = 'fms'; //main fms app
		//public static const FMS_SHOP:String = 'fmsShop'; //fms shop app (for interacting with shop and user)
		public static const RTMFP:String = 'rtmfp'; //p2p local network connection
		public static const WS:String = 'ws'; //web socket app (for interacting with shop and user)
		public static const WS_SHOP:String = 'wsShop'; //web socket shop app 
		public static const SWF_ADDRESS:String = 'swfAddress';
		public static const COMMUNICATION:String = 'communication';
		public static const EXTERNAL:String = 'external'; //java script
		public static const FACEBOOK:String = 'facebook'; //facebook
		public static const LOCAL_DATA:String = 'localData'; //service for storing data locally
		public static const LOCAL_DATA_DB:String = 'localDataDB'; //service for storing data to local DB
		
	}

}