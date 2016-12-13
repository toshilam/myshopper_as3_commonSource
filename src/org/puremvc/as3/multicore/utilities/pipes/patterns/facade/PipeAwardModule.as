package org.puremvc.as3.multicore.utilities.pipes.patterns.facade 

{
	import myShopper.common.interfaces.IModuleMain;
	import myShopper.common.utils.Tracer;
	import org.puremvc.as3.multicore.enum.NotificationType;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAwareModule;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	/**
	* ...
	* @author Toshi Lam
	*/
	public class PipeAwardModule extends Facade implements IPipeAwareModule
	{
		protected var _module:IModuleMain;
		public function get module():IModuleMain 
		{
			return _module;
		}
		
		public function PipeAwardModule(key:String):void
		{
			super(key);
		}
		
		/**
		 * Application startup
		 *
		 * @param app a reference to the application component
		 */
		public function startup( inApplication:Object ):Boolean
		{
			if (!(inApplication is IModuleMain))
			{
				Tracer.echo(multitonKey + ' : startup : unknown object type! ', this, 0xff0000);
				return false;
			}
			
			_module = inApplication as IModuleMain;
			sendNotification( NotificationType.STARTUP, _module );
			return true;
		}
		
		public function getModuleID():String
		{
			return _module.moduleName;
		}
		
		/**
		 * Accept an input pipe.
		 * <P>Registers an input pipe with this module's Junction.</P>
		 */
		public function acceptInputPipe( inName:String, inPipe:IPipeFitting ):void
		{
			sendNotification( JunctionMediator.ACCEPT_INPUT_PIPE, inPipe, inName );
		}
		
		/**
		 * Accept an output pipe.
		 * <P>Registers an input pipe with this module's Junction.</P>
		 */
		public function acceptOutputPipe( inName:String, inPipe:IPipeFitting ):void
		{
			sendNotification( JunctionMediator.ACCEPT_OUTPUT_PIPE, inPipe, inName );
		}
		
		
	}
	
}