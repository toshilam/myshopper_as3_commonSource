package myShopper.common.data.user 
{
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class UserShoppingRecordProductVO extends UserShoppingCartProductVO 
	{
		
		public function UserShoppingRecordProductVO
		(
			inVOID:String, 
			inProductNo:String = '', 
			inProductID:String = '', 
			inProductName:String = '', 
			inProductPrice:String = '', 
			inProductDescription:String = '', 
			inProductCurrency:String = '', 
			inProductCategoryNo:String = '', 
			inProductDateTime:String = '', 
			inProductURL:String = '', 
			inProductCategoryName:String = ''
		) 
		{
			super
			(
				inVOID, 
				inProductNo, 
				inProductID, 
				inProductName, 
				inProductPrice, 
				inProductDescription, 
				inProductCurrency, 
				inProductCategoryNo, 
				inProductDateTime, 
				inProductURL, 
				inProductCategoryName
			);
			
		}
		
	}

}