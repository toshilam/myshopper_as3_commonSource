package myShopper.common.utils 
{
	import flash.net.FileFilter;
	/**
	 * ...
	 * @author Toshi
	 */
	public class File
	{
		
		public function File() 
		{
			
		}
		
		public static function getImageTypeFilter():FileFilter
		{
			return new FileFilter("Image (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
		}
		
		public static function getTextTypeFilter():FileFilter
		{
			return new FileFilter("Image (*.txt, *.rtf)", "*.txt; *.rtf;");
		}
	}

}