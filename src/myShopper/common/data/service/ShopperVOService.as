package myShopper.common.data.service 
{
	import myShopper.common.Config;
	import myShopper.common.data.shopper.ShopperAreaList;
	import myShopper.common.data.shopper.ShopperAreaVO;
	import myShopper.common.data.shopper.ShopperCategoryList;
	import myShopper.common.data.shopper.ShopperCategoryVO;
	import myShopper.common.data.shopper.ShopperCityList;
	import myShopper.common.data.shopper.ShopperCityVO;
	import myShopper.common.data.shopper.ShopperCountryList;
	import myShopper.common.data.shopper.ShopperCountryVO;
	import myShopper.common.data.shopper.ShopperDistanceList;
	import myShopper.common.data.shopper.ShopperDistanceVO;
	import myShopper.common.data.shopper.ShopperHotProductVO;
	import myShopper.common.data.shopper.ShopperProductTypeVO;
	import myShopper.common.data.shopper.ShopperProductVO;
	import myShopper.common.data.shopper.ShopperStateVO;
	import myShopper.common.interfaces.IVO;
	import myShopper.common.utils.Tools;
	import myShopper.common.utils.Tracer;
	/**
	 * ...
	 * @author Toshi Lam
	 */
	public class ShopperVOService 
	{
		
		public function ShopperVOService() 
		{
			
		}
		
		public static function getQQShareURI(httpHost:String, inDesc:String, inSummary:String, inPicURL:String):String
		{
			//url=http%3A%2F%2Fprerelease.my-shopper.com%2Ftest2.php%23abc%2Fasd&showcount=1&desc=&summary=&title=&site=&pics=&style=103&width=135&height=22
			var peram:String = 'url=' + encodeURIComponent(httpHost) + '&';
			peram += 'showcount=0&';
			peram += 'desc=' + encodeURIComponent(inDesc) + '&';
			peram += 'summary=' + encodeURIComponent(inSummary) + '&';
			peram += 'title=' + encodeURIComponent(Config.APPLICATION_TITLE) + '&';
			peram += 'site=' + encodeURIComponent(httpHost) + '&';
			peram += 'pics=' + encodeURIComponent(inPicURL) + '&';
			peram += 'style=103&width=135&height=22';
			
			return peram;
		}
		
		public static function getWeiboShareURI(httpHost:String, inTitle:String, inPicURL:String):String
		{
			//url=http%3A%2F%2Fprerelease.my-shopper.com%2Ftest2.php&appkey=&title=&pic=&ralateUid=&language=
			var peram:String = 'url=' + encodeURIComponent(httpHost) + '&';
			//peram += 'showcount=0&';
			peram += 'appkey=' + '' + '&';
			peram += 'title=' + encodeURIComponent(inTitle) + '&';
			peram += 'ralateUid=' + '' + '&';
			peram += 'pic=' + encodeURIComponent(inPicURL) + '&';
			peram += 'language=';
			
			return peram;
		}
		
		public static function getArrayCBObjectByXML(inXML:XML):Array
		{
			if (!inXML) return [];
			
			var numItem:int = inXML.*.length();
			var arrData:Array = new Array();
			
			for ( var i:int = 0; i < numItem; i++)
			{
				var node:XML = inXML.*[i];
				
				if (node)
				{
					var cbData:String = node.@data;
					var cbLabel:String = node.@label;
					
					if (cbData && cbLabel)
					{
						arrData.push( { data:cbData, label:cbLabel } );
					}
					
				}
			}
			
			return arrData;
		}
		
		public static function getArrayDiscountCBObject(inStart:int, inEnd:int):Array
		{
			var arrData:Array = new Array();
			
			for ( var i:int = inStart; i <= inEnd; i++)
			{
				arrData.push( { data:i, label:i.toString() + '%' } );
			}
			
			return arrData;
		}
		
		public static function getHotProductVOByObj(inData:Object):ShopperHotProductVO
		{
			var shopNo:String = inData['s_no'];
			var shopCurrency:int = int(inData['s_currency']);
			var pID:String = inData['p_id'];
			var pNo:String = inData['p_no'];
			var userID:String = inData['p_user_id'];
			var pName:String = inData['p_name'];
			var pDescription:String = inData['p_description'];
			var pPrice:String = inData['p_price'];
			var pDiscount:int = inData['p_discount'];
			var cCategory:String = inData['c_category'];
			
			var vo:ShopperHotProductVO = new ShopperHotProductVO(pID);
			vo.shopNo = shopNo;
			vo.shopCurrency = shopCurrency;
			vo.productID = pID;
			vo.productNo = pNo;
			vo.uid = userID;
			vo.productName = pName;
			vo.productDescription = Tools.replaceRestrictedString( pDescription );
			vo.productPrice = pPrice;
			vo.productDiscount = pDiscount;
			vo.productCategoryID = cCategory;
			
			return vo;
		}
		
		/**
		 * 
		 * @param	inData - data source from server
		 * @param	inVO - orignal shopper categoryList
		 * @return	true if successfully set
		 */
		public static function setCategoryAndProduct(inData:Object, inVO:ShopperCategoryList):Boolean
		{
			if (inData && inData is Array)
			{
				var arrData:Array = inData as Array;
				var numItem:int = arrData.length;
				
				for (var i:int = 0; i < numItem; i++)
				{
					var cData:Object = arrData[i];
					
					var categoryNo:String = cData['c_no'];
					var categoryName:String = cData['c_category'];
					
					if (categoryNo && categoryName)
					{
						var cVO:ShopperCategoryVO = inVO.getVOByCategoryNo(categoryNo) as ShopperCategoryVO;
						
						if (!cVO)
						{
							cVO = new ShopperCategoryVO(categoryNo, categoryName, categoryNo);
							
							inVO.addVO( cVO );
						}
						
						var arrPData:Array = cData['c_product'] as Array;
						
						if (arrPData is Array)
						{
							var numPItem:int = arrPData.length;
							
							for (var j:int = 0; j < numPItem; j++)
							{
								var pData:Object = arrPData[j];
								
								var producutNo:String = pData['p_no'];
								var producutName:String = pData['p_product'];
								
								var pVO:ShopperProductVO = cVO.productList.getVOByProductNo(producutNo) as ShopperProductVO;
								
								if (!pVO)
								{
									pVO = new ShopperProductVO(producutNo, producutNo, producutName, cVO/*categoryNo, categoryName*/);
									
									cVO.productList.addVO(pVO);
								}
								
								var arrPTypeData:Array = pData['p_product_type'] as Array;
								
								if (arrPTypeData is Array)
								{
									var numPTypeItem:int = arrPTypeData.length;
									
									for (var k:int = 0; k < numPTypeItem; k++)
									{
										var pTypeData:Object = arrPTypeData[k];
										
										var producutTypeNo:String = pTypeData['t_no'];
										var producutTypeName:String = pTypeData['t_product_type'];
										
										var pTypeVO:ShopperProductTypeVO = pVO.productTypeList.getVOByProductTypeNo(producutTypeNo) as ShopperProductTypeVO;
										
										if (!pTypeVO)
										{
											pTypeVO = new ShopperProductTypeVO(producutTypeNo, producutTypeNo, producutTypeName, pVO/*producutNo, producutName*/);
											
											pVO.productTypeList.addVO(pTypeVO);
										}
										
										
									}
								}
								
							}
						}
					}
				}
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * 
		 * @param	inCategoryList - a categoryList that contains user selected category
		 * @return	a converted string from selected category
		 */
		public static function getCategoryStringBySelectedShopperCategory(inCategoryList:ShopperCategoryList):String
		{
			var str:String = '';
			
			if (inCategoryList && inCategoryList.length)
			{
				var numItem:int = inCategoryList.length;
				for (var i:int = 0; i < numItem; i++)
				{
					var cVO:ShopperCategoryVO = inCategoryList.getVO(i) as ShopperCategoryVO;
					
					if (cVO.isSelected)
					{
						str += cVO.categoryName + ' ; ';
					}
					
				}
			}
			
			return str;
		}
		
		/**
		 * 
		 * @param	inAreaList - a areaList that contains user selected area
		 * @return	a converted string from selected category
		 */
		public static function getAreaStringBySelectedShopperArea(inAreaList:ShopperAreaList):String
		{
			var str:String = '';
			
			if (inAreaList && inAreaList.length)
			{
				var numItem:int = inAreaList.length;
				for (var i:int = 0; i < numItem; i++)
				{
					var aVO:ShopperAreaVO = inAreaList.getVO(i) as ShopperAreaVO;
					
					if (aVO.isSelected)
					{
						str += aVO.areaName + ' ; ';
					}
					
				}
			}
			
			return str;
		}
		
		public static function getAreaStringByAreaNo(inAreaNo:String, inAreaList:ShopperAreaList):String
		{
			var numItem:int = inAreaList.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var aVO:ShopperAreaVO = inAreaList.getVO(i) as ShopperAreaVO;
				
				if (aVO && aVO.areaNo == inAreaNo)
				{
					return aVO.areaName;
				}
				
			}
			
			return '';
		}
		
		public static function getCategoryProductStringByNO(inCategoryNO:String, inProductNO:String, inProductTypeNO:String, inCategoryList:ShopperCategoryList):String
		{
			var str:String = '';
			
			var cVO:ShopperCategoryVO = inCategoryList.getVOByCategoryNo(inCategoryNO) as ShopperCategoryVO;
			if (cVO)
			{
				str = cVO.categoryName;
				
				var pVO:ShopperProductVO = cVO.productList.getVOByProductNo(inProductNO) as ShopperProductVO;
				
				if (pVO)
				{
					str += ' > ' + pVO.productName;
					
					//product type may not exist
					if (inProductTypeNO)
					{
						var pTypeVO:ShopperProductTypeVO = pVO.productTypeList.getVOByProductTypeNo(inProductTypeNO) as ShopperProductTypeVO;
						
						if (pTypeVO)
						{
							str += ' > ' + pTypeVO.productTypeName;
						}
					}
					
				}
			}
			
			return str;
		}
		
		public static function getCategoryProductStringByVO(inVO:IVO):String
		{
			var str:String = '';
			
			if (inVO is ShopperProductVO)
			{
				var pVO:ShopperProductVO = inVO as ShopperProductVO;
				str = pVO.categoryVO.categoryName + ' > ' + pVO.productName;
			}
			else if (inVO is ShopperProductTypeVO)
			{
				var pTypeVO:ShopperProductTypeVO = inVO as ShopperProductTypeVO;
				str = pTypeVO.productVO.categoryVO.categoryName + ' > ' + pTypeVO.productVO.productName + ' > ' + pTypeVO.productTypeName;
				
			}
			
			return str;
		}
		
		/**
		 * 
		 * @param	inCategoryList - selected category list by user
		 * @return	an array contain user selected category no
		 */
		public static function getCategoryNoArrayBySelectedShopperCategory(inCategoryList:ShopperCategoryList):Array
		{
			var arr:Array = new Array();
			var numItem:int = inCategoryList.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var cVO:ShopperCategoryVO = inCategoryList.getVO(i) as ShopperCategoryVO;
				if (cVO && cVO.isSelected)
				{
					arr.push(cVO.categoryNo.toString());
				}
			}
			
			return arr;
		}
		
		public static function getAreaNoArrayBySelectedAreaList(inAreaList:ShopperAreaList):Array
		{
			var arr:Array = new Array();
			var numItem:int = inAreaList.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var cVO:ShopperAreaVO = inAreaList.getVO(i) as ShopperAreaVO;
				if (cVO && cVO.isSelected)
				{
					arr.push(cVO.areaNo.toString());
				}
			}
			
			return arr;
		}
		
		/**
		 * 
		 * @param	inData - an array contains all user selected category no (from server)
		 * @param	inTargetCategory - the categoryList to be added
		 * @param	inShopperCategory - the orginal categoryList contains all category data
		 * @return	a cloned categoryList that only contains user selected category
		 */
		public static function setShopperCategoryListByCategoryNoArray(inData:Array, inTargetCategory:ShopperCategoryList, inShopperCategory:ShopperCategoryList):Boolean
		{
			if (!(inData is Array) || !(inTargetCategory is ShopperCategoryList) || !(inShopperCategory is ShopperCategoryList))
			{
				Tracer.echo('ShopperVOService : getShopperCategoryListByCategoryNoArray : unknown data type');
				return false;
			}
			
			//clear previous store data
			inTargetCategory.clear();
			
			var numItem:int = inData.length;
			for (var i:int = 0; i < numItem; i++)
			{
				var cVO:ShopperCategoryVO = inShopperCategory.getVOByCategoryNo(String(inData[i])) as ShopperCategoryVO;
				if (cVO)
				{
					cVO = cVO.clone() as ShopperCategoryVO; //clone a new one from orignal
					cVO.isSelected = true;
					inTargetCategory.addVO ( cVO );
				}
				else
				{
					//error if category not found in orginal list
					Tracer.echo('ShopperVOService : getShopperCategoryListByCategoryNoArray : data not found!');
					//return false;
				}
			}
			
			return true;
		}
		
		public static function setShopperActiveCountry(inData:Array, inCountryList:ShopperCountryList):Boolean
		{
			if (inData is Array)
			{
				var numItem:int = (inData as Array).length;
				//var arrArea:Array = new Array();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					var data:Object = (inData as Array)[i];
					
					var countryName:String = data['c_name'];
					var countryID:String = data['c_id'];
					var countryNo:String = data['c_no'];
					//var lat:Number = data['c_lat'];
					//var lng:Number = data['c_lng'];
					
					if (countryName && countryID && countryNo /*&& lat && lng*/)
					{
						var countryVO:ShopperCountryVO = inCountryList.getVOByCountryID(countryID) as ShopperCountryVO;
						
						//if area already exist, do nothing
						if( !countryVO )
						{
							//currently use country id as name as well, will be changed in the future
							countryVO = new ShopperCountryVO(countryNo, countryName, countryID)
							
						}
						
						//add country vo at the end
						inCountryList.addVO( countryVO );
					}
					else
					{
						Tracer.echo('ShopperVOService : setShopperActiveCountryCityArea : unknown data type!');
					}
				}
				
				inCountryList.isDataDownloaded = true;
				
				return true;
			}
			
			return false;
		}
		
		public static function setShopperState(inData:Array, inCountryList:ShopperCountryList):ShopperCountryVO
		{
			if (inData is Array && inData['s_country'])
			{
				var countryID:String = inData['s_country'];
				var countryVO:ShopperCountryVO = inCountryList.getVOByCountryID(countryID) as ShopperCountryVO;
				
				if (countryVO)
				{
					var numItem:int = (inData as Array).length;
					//var arrArea:Array = new Array();
					
					for ( var i:int = 0; i < numItem; i++)
					{
						var data:Object = (inData as Array)[i];
						
						var stateName:String = data['s_name'];
						var stateID:String = data['s_id'];
						var stateNo:String = data['s_no'];
						var lat:Number = Number(data['s_lat']);
						var lng:Number = Number(data['s_lng']);
						
						
						if (stateName && stateID && stateNo && !isNaN(lat) && !isNaN(lng))
						{
							var stateVO:ShopperStateVO = countryVO.stateList.getVOByStateID(stateID) as ShopperStateVO;
							
							if (!stateVO)
							{
								stateVO = new ShopperStateVO(stateID, stateNo, stateName, stateID, lat, lng, countryID); 
								countryVO.stateList.addVO( stateVO );
							}
						}
						else
						{
							Tracer.echo('ShopperVOService : setShopperState : unknown data type!');
						}
					}
					
					return countryVO;
					
				}
				
			}
			
			return null;
		}
		
		public static function setShopperCity(inData:Array, inCountryList:ShopperCountryList):ShopperStateVO
		{
			if (inData is Array)
			{
				var countryID:String = inData['c_country']
				var stateID:String = inData['c_state'];
				
				if (countryID && stateID)
				{
					var countryVO:ShopperCountryVO = inCountryList.getVOByCountryID(countryID) as ShopperCountryVO;
					if (countryVO)
					{
						var stateVO:ShopperStateVO = countryVO.stateList.getVOByStateID(stateID) as ShopperStateVO;
						if (stateVO)
						{
							var numItem:int = inData.length;
							
							for ( var i:int = 0; i < numItem; i++)
							{
								var data:Object = inData[i];
								
								var cityID:String = data['c_id'];
								var cityName:String = data['c_name'];
								var cityNo:String = data['c_no'];
								var lat:Number = data['c_lat'];
								var lng:Number = data['c_lng'];
								
								
								if ( cityID && cityName && cityNo && !isNaN(lat) && !isNaN(lng) )
								{
									var cityVO:ShopperCityVO = stateVO.cityList.getVOByCityNo( cityNo ) as ShopperCityVO;
									
									if ( !cityVO )
									{
										cityVO = new ShopperCityVO(cityNo, cityNo, cityName, cityID, lat, lng, countryID);
										stateVO.cityList.addVO( cityVO );
									}
									
									cityVO.isActive = String(data['c_active']) == '1';
									
									
								}
								else
								{
									Tracer.echo('ShopperVOService : setShopperCity : unknown data type!');
								}
							}
							
							return stateVO;
						}
					}
					
					
					
				}
				
			}
			
			return null;
		}
		
		/*public static function setShopperActiveCountryCityArea(inData:Array, inCountryList:ShopperCountryList):Boolean
		{
			if (inData is Array)
			{
				var numItem:int = (inData as Array).length;
				//var arrArea:Array = new Array();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					var data:Object = (inData as Array)[i];
					
					var countryName:String = data['c_name'];
					var countryID:String = data['c_id'];
					var countryNo:String = data['c_no'];
					var lat:Number = data['c_lat'];
					var lng:Number = data['c_lng'];
					var arrCity:Array = data['c_city'];
					
					if (countryName && countryID && countryNo && lat && lng)
					{
						var countryVO:ShopperCountryVO = inCountryList.getVOByCountryID(countryID) as ShopperCountryVO;
						
						//if area already exist, do nothing
						if( !countryVO )
						{
							//currently use country id as name as well, will be changed in the future
							countryVO = new ShopperCountryVO(countryNo, countryName, countryID)
							
						}
						
						setShopperActiveCity(arrCity, countryVO.cityList);
						
						//add country vo at the end
						inCountryList.addVO( countryVO );
					}
					else
					{
						Tracer.echo('ShopperVOService : setShopperActiveCountryCityArea : unknown data type!');
					}
				}
				
				inCountryList.isDataDownloaded = true;
				
				return true;
			}
			
			return false;
		}*/
		
		public static function setShopperActiveCity(inData:Array, inCityList:ShopperCityList):Boolean
		{
			if (inData is Array)
			{
				var numItem:int = (inData as Array).length;
				//var arrArea:Array = new Array();
				
				//var arrOther:Vector.<ShopperCityVO> = new Vector.<ShopperCityVO>();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					var data:Object = (inData as Array)[i];
					
					var countryID:String = data['c_country'];
					var stateID:String = data['c_state'];
					var cityID:String = data['c_id'];
					var cityName:String = data['c_name'];
					var cityNo:String = data['c_no'];
					var lat:Number = data['c_lat'];
					var lng:Number = data['c_lng'];
					//var arrArea:Array = data['c_area'];
					
					
					if ( countryID && cityID && cityName && cityNo && !isNaN(lat) && !isNaN(lng) )
					{
						var cityVO:ShopperCityVO = inCityList.getVOByCityNo( cityNo ) as ShopperCityVO;
						
						if ( !cityVO )
						{
							cityVO = new ShopperCityVO(cityNo, cityNo, cityName, cityID, lat, lng, countryID, stateID);
						}
						
						/*if (arrArea && arrArea is Array)
						{
							setShopperArea(arrArea, cityVO.areaList, countryID, cityID);
						}*/
						
						
						cityVO.isActive = true;
						
						/*if (cityVO.cityLat == 0 || cityVO.cityLng == 0) //other should always push to the last
						{
							arrOther.push( cityVO );
							continue;
						}*/
						
						inCityList.addVO( cityVO );
						
					}
					else
					{
						Tracer.echo('ShopperVOService : setShopperActiveCity : unknown data type!');
					}
				}
				
				inCityList.isDataDownloaded = true;
				
				return true;
			}
			
			return false;
		}
		
		public static function setShopperArea(inData:Array, inAreaList:ShopperAreaList, inCountryID:String, inCityID:String):Boolean
		{
			if (inData is Array)
			{
				var countryID:String = inCountryID;
				var cityID:String = inCityID;
				var numItem:int = (inData as Array).length;
				//var arrArea:Array = new Array();
				
				//var arrOther:Vector.<ShopperAreaVO> = new Vector.<ShopperAreaVO>();
				
				for ( var i:int = 0; i < numItem; i++)
				{
					var data:Object = (inData as Array)[i];
					
					var areaName:String = data['a_name'];
					var areaNo:String = data['a_no'];
					var areaID:String = data['a_id'];
					var areaLat:Number = Number(data['a_lat']);
					var areaLng:Number = Number(data['a_lng']);
					
					
					if (areaName && areaNo && areaID && !isNaN(areaLat) && !isNaN(areaLng) && countryID && cityID)
					{
						//if area already exist, do nothing
						if( !inAreaList.getVOByAreaNo(areaNo) )
						{
							inAreaList.addVO( new ShopperAreaVO(areaNo, areaNo, areaName, areaLat, areaLng, countryID, cityID, areaID) );
						}
					}
					else
					{
						Tracer.echo('ShopperVOService : setShopperArea : unknown data type!');
					}
				}
				
				inAreaList.isDataDownloaded = true;
				
				return true;
			}
			
			return false;
		}
	}

}