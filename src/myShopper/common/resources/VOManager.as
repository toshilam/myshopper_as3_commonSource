package myShopper.common.resources 
{
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tracer;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class VOManager extends DataManager implements IDataManager 
	{
		
		public function VOManager() 
		{
			super();
			
		}
		
		override public function addAsset(inAsset:Object, inAssetID:String):Boolean 
		{
			if (!(inAsset is IVO))
			{
				Tracer.echo('VOManager : addAsset : unknown data type : ' + inAsset, this, 0xff0000);
				return false;
			}
			
			return super.addAsset(inAsset, inAssetID);
		}
		
		
		/*override public function getData(inRequest:*, inAssetID:String):* 
		{
			if (!(inRequest is IServiceRequest))
			{
				Tracer.echo('VOManager : addAsset : unknown data type : ' + inRequest, this, 0xff0000);
				return false;
			}
			
			var service:IService = super.getAsset(inAssetID);
			if (service)
			{
				service.request(inRequest);
				
				return true;
			}
			
			Tracer.echo('ServiceManager : getData : no matched service controller found : ' + inAssetID, this, 0xff0000);
			return false;
		}*/
	}

}