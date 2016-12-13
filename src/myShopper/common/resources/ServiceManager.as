package myShopper.common.resources 
{
	import myShopper.common.interfaces.IDataManager;
	import myShopper.common.interfaces.IService;
	import myShopper.common.interfaces.IServiceRequest;
	import myShopper.common.utils.Tracer;
	
	/**
	 * remote service manager that help communicate between servers
	 * @author Toshi Lam
	 */
	public class ServiceManager extends DataManager implements IDataManager 
	{
		
		public function ServiceManager() 
		{
			super();
		}
		
		override public function addAsset(inAsset:Object, inAssetID:String):Boolean 
		{
			if (!(inAsset is IService))
			{
				Tracer.echo('ServiceManager : addAsset : unknown data type : ' + inAsset, this, 0xff0000);
				return false;
			}
			
			return super.addAsset(inAsset, inAssetID);
		}
		
		
		override public function getData(inRequest:*, inAssetID:String):* 
		{
			if (!(inRequest is IServiceRequest))
			{
				Tracer.echo('ServiceManager : addAsset : unknown data type : ' + inRequest, this, 0xff0000);
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
		}
	}

}