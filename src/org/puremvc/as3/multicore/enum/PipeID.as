package org.puremvc.as3.multicore.enum 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class PipeID 
	{
		public static const NAME:String							= 'PipeID';
		/**
		 * Standard output pipe name constant.
		 */
		public static const APP_TO_MODULE:String 				= NAME + 'AppToModule';
		
		/**
		 * Standard input pipe name constant.
		 */
		//public static const STDIN:String 						= NAME + 'standardInput';
		
		/**
		 * Standard Shell input pipe name constant.
		 */
		public static const MODULE_TO_APP:String	 			= NAME + 'ModuleToApp';
		
		/**
		 * Module to Module output pipe name constant.
		 */
		public static const MODULE_TO_MODULE:String 			= NAME + 'helloToHelloOut';
	}

}