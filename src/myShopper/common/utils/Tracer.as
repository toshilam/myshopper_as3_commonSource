package myShopper.common.utils
{
	//import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public class Tracer
	{
		public static function echo(inMessage:Object, inTarget:Object = null, inColor:uint = 0x111111):void
		{
			trace(inMessage);
			/*MonsterDebugger.trace
			(
				inTarget == null ? Tracer : inTarget, 
				inMessage,
				inColor
			);*/
		}
	}
	
}