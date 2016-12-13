package myShopper.common.utils 
{
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.BinaryBitmap;
	import com.google.zxing.BufferedImageLuminanceSource;
	import com.google.zxing.client.result.ParsedResult;
	import com.google.zxing.client.result.ResultParser;
	import com.google.zxing.common.BitMatrix;
	import com.google.zxing.common.flexdatatypes.HashTable;
	import com.google.zxing.common.HybridBinarizer;
	import com.google.zxing.DecodeHintType;
	import com.google.zxing.MultiFormatReader;
	import com.google.zxing.MultiFormatWriter;
	import com.google.zxing.Result;
	import com.google.zxing.Writer;
	import com.google.zxing.Writer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Toshi
	 */
	public class Barcode extends Object 
	{
		
		public function Barcode() 
		{
			super();
		}
		
		public static function decodeBitmapData(bmpd:BitmapData/*, width:int, height:int*/):String
    	{
    		// create the container to store the image width and height in
        	var lsource:BufferedImageLuminanceSource = new BufferedImageLuminanceSource(bmpd);
        	// convert it to a binary bitmap
        	var bitmap:BinaryBitmap = new BinaryBitmap(new HybridBinarizer(lsource));
        	// get all the hints
    		var ht:HashTable = null;
    		ht = getAllHints()
    		var res:Result = null;
    		try
    		{
				var myReader:MultiFormatReader = new MultiFormatReader();
    			// try to decode the image
    			res = myReader.decode(bitmap,ht);
    		}
    		catch(e:*) 
    		{
    			// failed
				Tracer.echo('Barcode : decodeBitmapData : error : ' + e);
    			return null;
    		}
    		
    		// did we find something?
    		if (res == null)
    		{
				Tracer.echo('Barcode : decodeBitmapData : Could not decode image');
				return null;
    		}
    		
			// yes : parse the result
			var parsedResult:ParsedResult = ResultParser.parseResult(res);
			// get a formatted string and display it in our textarea
			return parsedResult.getDisplayResult();
		}
		
		private static function getAllHints():HashTable
	    {
	    	// get all hints from the user
	    	var ht:HashTable = new HashTable();
			ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.QR_CODE);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.DATAMATRIX);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.UPC_E);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.UPC_A);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.EAN_8);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.EAN_13);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.CODE_39);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.CODE_93);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.CODE_128);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.PDF417);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.ITF);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.AZTEC);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.RSS_14);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.RSS_EXPANDED);
			//ht.Add(DecodeHintType.POSSIBLE_FORMATS,BarcodeFormat.CODABAR);
			ht.Add(DecodeHintType.TRY_HARDER,true);
			return ht;
	    }
		
		public static function generateQRCode(inValue:String, inWH:Point):Bitmap
		{
			return generate(BarcodeFormat.QR_CODE, inWH, inValue);
		}
		
		public static function generate(barcodeType:BarcodeFormat, image:Point, contents:String/*, checkFunction:Function = null*/):Bitmap
		{      
			
			if (barcodeType == BarcodeFormat.PDF417)
			{
				//Alert.show("The output is equal to the core Java code but it is not decoding correctly");
				Tracer.echo("Barcode : generate : The output is equal to the core Java code but it is not decoding correctly");
				return null;
			}
			
			var checkFunction:Function = null;
			
			if 		(barcodeType == BarcodeFormat.EAN_8) checkFunction = checkEAN8;
			else if (barcodeType == BarcodeFormat.EAN_13) checkFunction = checkEAN13;
			else if (barcodeType == BarcodeFormat.UPC_A) checkFunction = checkUPCA;
			
			if (checkFunction != null)
			{
				contents = checkFunction(contents);
				if (contents == null) 
				{
					Tracer.echo("Barcode : generate : input check failed");
					return null; 
				} 
			}
			
			var myWriter:Writer = new MultiFormatWriter();
			
			try
			{
				// try to generate the data for the barcode
				var result:BitMatrix = myWriter.encode(contents, barcodeType, image.x - 100, image.y - 100) as BitMatrix;
			}
			catch (e:Error)
			{
				//Alert.show("An error occured when making the barcode :"+e.message);
				Tracer.echo("Barcode : generate : An error occured when making the barcode :"+e.message);
				return null;
			}
			
			var resultBits:Array = new Array(result.getWidth());
			for (var i:int=0;i<result.getWidth();i++)
			{
				resultBits[i] = result._get(i,0);
			}
				
			// map the result onto the image
			var bmpd:BitmapData = new BitmapData(image.x, image.y, false, 0x009900);
			var bmp:Bitmap = new Bitmap(bmpd);            	
			var whitepixel:Boolean;

			for (var h:int = 0; h < bmpd.height; h++)
			{
				for (var w:int=0;w<bmpd.width;w++)
				{
					
					if ((w<50||w >= (image.x-50)) || ((h<50) || (h>=(image.y-50)))) 
					{
						// make a 50px border around each barcode
						bmpd.setPixel(w,h, 0xFFFFFF);
					}
					else
					{
						if ((barcodeType == BarcodeFormat.PDF417) ||
							(barcodeType == BarcodeFormat.QR_CODE))
						{
							whitepixel = (result._get(w-50,h-50) == 0);
						}
						else
						{
							whitepixel = (resultBits[w-50] == 0);
						}
						
						if (whitepixel)
						{
							// white pixel
							bmpd.setPixel(w,h, 0xFFFFFF);
						}
						else
						{
							// black pixel
							bmpd.setPixel(w,h, 0x000000);
						}
					}		
				}
			}
			
			return bmp;
		}
		
		private static function checkUPCA(text:String):String
		{
			while (text.length < 11) { text = "0" + text; }
			if (text.length != 11) 
			{
				Tracer.echo('Barcode : checkUPCA : UPC_A should be 11 digits');
				return null;
			}
							
			var checksum_value:Number= 3*(   (text.charCodeAt(1) - 48) + 
										   (text.charCodeAt(3) - 48) + 
										   (text.charCodeAt(5) - 48) + 
										   (text.charCodeAt(7) - 48) + 
										   (text.charCodeAt(9) - 48)) +
									  (text.charCodeAt(0) - 48) + (text.charCodeAt(2) - 48) +
									  (text.charCodeAt(4) - 48) + (text.charCodeAt(6) - 48) + 
									  (text.charCodeAt(8) - 48) + (text.charCodeAt(10) - 48);
			var checksum_digit:int = 10 - (checksum_value % 10);
			if (checksum_digit == 10) { checksum_digit = 0; }
			return text+checksum_digit.valueOf();
			
		
		}
		
		private static function checkEAN13(text:String):String
		{
			if (text.length > 12) 
			{
				Tracer.echo('Barcode : checkEAN13 : EAN12 can only contain 13 digits (13th digit is checksum digit)');
				return null;
			}
			var counter:int=0;
			while(counter < text.length)
			{
				
				var cc:int = text.charCodeAt(counter);
				if ((cc<0x30) || (cc>0x39)) 
				{
					Tracer.echo("Barcode : checkEAN13 : EAN barcodes can only contain digits"); 
					 return null;
				}
				counter++;
			}
			while (text.length < 12) { text = "0" + text; }
			// calculate checksum
			var checksum_value:Number= 3*(   (text.charCodeAt(1) - 48) + 
										   (text.charCodeAt(3) - 48) + 
										   (text.charCodeAt(5) - 48) + 
										   (text.charCodeAt(7) - 48) + 
										   (text.charCodeAt(9) - 48) + 
										   (text.charCodeAt(11) - 48)) +
									  (text.charCodeAt(0) - 48) + (text.charCodeAt(2) - 48) +
									  (text.charCodeAt(4) - 48) + (text.charCodeAt(6) - 48) + 
									  (text.charCodeAt(8) - 48) + (text.charCodeAt(10) - 48);
			var checksum_digit:int = 10 - (checksum_value % 10);
			if (checksum_digit == 10) { checksum_digit = 0; }
			return text+checksum_digit.valueOf();
		} 
		
		private static function checkEAN8(text:String):String
		{
			if (text.length > 7) 
			{
				Tracer.echo('Barcode : checkEAN8 : EAN8 can only contain 7 digits (8th digit is used for checksum');
				return null;
			}
			var counter:int=0;
			while(counter < text.length)
			{
				
				var cc:int = text.charCodeAt(counter);
				if ((cc<0x30) || (cc>0x39)) 
				{
					Tracer.echo("Barcode : checkEAN8 : EAN barcodes can only contain digits"); 
					return null;
				}
				counter++;
			}
			while (text.length < 7) { text = "0" + text; }
			// calculate the checksum
			var checksum_value:int = (text.charCodeAt(1) - 48) + (text.charCodeAt(3) - 48) + (text.charCodeAt(5) - 48) + 
									  3 * ((text.charCodeAt(0) - 48) + (text.charCodeAt(2) - 48) + (text.charCodeAt(4) - 48) + (text.charCodeAt(6) - 48));
			var checksum_digit:int = 10 - (checksum_value % 10);
			if (checksum_digit == 10) { checksum_digit = 0; }
			return text+checksum_digit.valueOf();
		} 
	}

}