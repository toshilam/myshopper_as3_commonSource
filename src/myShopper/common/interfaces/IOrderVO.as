package myShopper.common.interfaces 
{
	import myShopper.common.data.shop.ShopProductList;
	import myShopper.common.data.VOList;
	
	/**
	 * ...
	 * @author Macentro
	 */
	public interface IOrderVO extends IVO
	{
		function get productList():ShopProductList;
		function get extraList():VOList;
	}
	
}