package org.puremvc.as3.multicore.utilities.pipes.interfaces
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;

	public interface IPipeAwareModule extends IPipeAware
	{
		function getModuleID():String;
		
		function startup(inApplication:Object):Boolean;
		
		//function unload():void;
		//
		//function cleanup():void;
		
		/** This should be called by the parent of the loaded module once the module's
		 * junction as been wired up.  Note this is to support a 'QueueingJunction', if your
		 * not using a queueingjunction feel free to ignore this function
		 */
		//function junctionConnected():void;
				//
		//function cacheFitting(localFitting:IPipeFitting,remoteFitting:IPipeFitting):void;
		
		//function set applicationJunction(junction:Junction):void
		
		//function get applicationJunction():Junction;
	
	}
}