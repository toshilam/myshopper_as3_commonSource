package myShopper.common.data.service 
{
	import myShopper.common.Config;
	public class GoogleVOService 
	{
		
		public function GoogleVOService() 
		{
			
		}
		
		
		public static function getOAuthURL():String
		{
			//return Config.URL_GOOGLE_OAUTH + '?scope=email%20profile&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id=' + Config.GOOGLE_CLIENT_ID;
			return Config.URL_GOOGLE_OAUTH + '?scope=https://www.googleapis.com/auth/cloudprint&redirect_uri=oob&response_type=code&client_id=' + Config.GOOGLE_CLIENT_ID;
		}
	}

}