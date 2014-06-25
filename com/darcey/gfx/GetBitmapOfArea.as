package com.darcey.gfx
{
	// -------------------------------------------------------------------------------------------------------------------------------
	import com.darcey.debug.Ttrace;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	// -------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------------------------------------------
	public class GetBitmapOfArea extends Sprite
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var matrix:Matrix;
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function GetBitmapOfArea(target:DisplayObject,area:Rectangle)
		{
			matrix = new Matrix(1,0,0,1);
			matrix.translate(-area.x,-area.y);
			
			bmpData = new BitmapData(area.width,area.height,false);
			bmpData.draw(target, matrix);
			bmp = new Bitmap(bmpData);
			addChild(bmp);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function getBitmap():Bitmap
		{
			return bmp;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function getBitmapData():BitmapData
		{
			return bmpData;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
	}
	// -------------------------------------------------------------------------------------------------------------------------------
}