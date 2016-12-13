package myShopper.amf.shop.data 
{
	import myShopper.common.data.VO;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	//[RemoteClass(alias="shopper.amf.common.data.CategoryVO")]
	public class CategoryVO extends VO 
	{
		public var category:String;
		public var dateTime:String;
		public var no:String;
		public var isPrivate:Boolean;
		public var product:Object;
		
		public function CategoryVO(inID:String = '', inCategory:String = '', inDateTime:String = '', inNo:String = '', inPrivate:Boolean = false, inProduct:Object = null) 
		{
			super(inID);
			category = inCategory;
			dateTime = inDateTime;
			no = inNo;
			isPrivate = inPrivate;
			product = inProduct;
		}
		
	}

}