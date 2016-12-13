package org.puremvc.as3.multicore.enum 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class NotificationType 
	{
		public static const STARTUP:String 								= 'startup';
		public static const TEARDOWN:String								= "teardown";

		//public static const SEND_REMOVE_SIGNAL_TO_SHELL:String			= "sendRemoveSignalToShell";
		//public static const STORE_MESSAGE:String						= "storeMessage";
		public static const SEND_MESSAGE_TO_SHELL:String				= "sendMessageToShell";
		public static const SEND_MESSAGE_TO_MODULE:String				= "sendMessageToModule";
		
		public static const CONNECT_MODULE_TO_SHELL:String				= "connectModuleToShell";
		public static const CONNECT_SHELL_TO_MODULE:String				= "connectShellToModule";
		
		public static const ADD_HOST:String								= "addHost";
		public static const ADD_CHILD:String							= "addChild";
		
		public static const MODULE_ON:String							= "moduleOn";
		public static const MODULE_OFF:String							= "moduleOff";
	}

}