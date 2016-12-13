package myShopper.common.data.communication 
{
	import myShopper.common.data.VO;
	
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class CommVO extends VO 
	{
		protected var _type:String; //FMS/AMF service type
		//protected var _fromID:String; //the communication sent by (fms/user id) / it can be empty if the commVO create by myself
		protected var _fromUID:String; //the actual shopper id (it can be empty if the user if not logged in)
		protected var _data:Object; 
		
		
		public function CommVO(inID:String, inType:String, inFromID:String, inData:Object = null, inFromUID:String = '') 
		{
			super(inID);
			_type = inType;
			//_fromID = inFromID;
			_data = inData;
			_fromUID = inFromUID;
		}
		
		public function get type():String {return _type;}
		public function set type(value:String):void 
		{
			_type = value;
			dispatchChangeEvent('type', value);
		}
		
		/*public function get fromID():String {return _fromID;}
		public function set fromID(value:String):void 
		{
			_fromID = value;
			dispatchChangeEvent('fromID', value);
		}*/
		
		public function get data():Object {return _data;}
		public function set data(value:Object):void 
		{
			_data = value;
			dispatchChangeEvent('data', value);
		}
		
		public function get fromUID():String {return _fromUID;}
		public function set fromUID(value:String):void 
		{
			_fromUID = value;
			dispatchChangeEvent('fromUID', fromUID);
		}
		
	}

}