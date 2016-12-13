package org.puremvc.as3.multicore.interfaces 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IApplicationMediator extends IMediator
	{
		function get mainStage():Stage;
		
		function startListener():void;
		function stopListener():void;
	}
	
}