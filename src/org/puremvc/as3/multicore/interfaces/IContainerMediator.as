package org.puremvc.as3.multicore.interfaces 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IContainerMediator extends IApplicationMediator
	{
		//set child window index to the top of container
		function setIndex(inIndex:int = -1):void;
	}
	
}