package myShopper.common.interfaces 
{
	import flash.display.Stage;
	import myShopper.common.interfaces.IDataManager;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public interface IApplicationMultiContentDisplayObject extends IApplicationDisplayObject 
	{
		//function get mainStage():Stage;
		//function get dataManager():IDataManager;
		//function get voManager():IVOManager;
		
		function get isChangingContent():Boolean;
		
		//function initLayout(inMainStage:Stage, inDataManager:IDataManager, inVOManager:IVOManager):void
		
		function changeContent(inDisplayObject:IApplicationDisplayObject, inAutoTransition:Boolean = true ):IApplicationDisplayObject
		
		function removeContent(inShowSubsribedDisplayObject:Boolean = false, inAutoTransition:Boolean = true ):IApplicationDisplayObject
		
		//function showContent():IApplicationDisplayObject
	}
	
}