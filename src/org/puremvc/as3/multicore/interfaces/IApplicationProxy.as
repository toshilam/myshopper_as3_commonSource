package org.puremvc.as3.multicore.interfaces 
{
	import myShopper.common.interfaces.IModuleMain;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IApplicationProxy extends IProxy
	{
		function get host():IModuleMain;
		function initAsset(inAsset:Object = null):void;
	}
	
}