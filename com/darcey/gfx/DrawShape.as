package com.darcey.gfx
{
	// --------------------------------------------------------------------------------------------
	import com.darcey.utils.DTools;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;

	// --------------------------------------------------------------------------------------------
	
	
	// --------------------------------------------------------------------------------------------
	public class DrawShape
	{
		
		// --------------------------------------------------------------------------------------------
		public function DrawShape()
		{
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function draw3ColorGradientColorCircle(graphics:Graphics,radius:Number,color1:Number=0x00FF00,color2:Number=0xFFFF00,color3:Number=0xFF0000):void
		{
			var nRadians:Number;
			var objMatrix:Matrix;
			var nX:Number;
			var nY:Number;
			var iThickness:int;
			var color:Number = 0x000000;
			var ct:ColorTransform = new ColorTransform();
			var r1:uint = DTools.rgbGetRFromHex(color1);
			var g1:uint = DTools.rgbGetGFromHex(color1);
			var b1:uint = DTools.rgbGetBFromHex(color1);
			var r2:uint = DTools.rgbGetRFromHex(color2);
			var g2:uint = DTools.rgbGetGFromHex(color2);
			var b2:uint = DTools.rgbGetBFromHex(color2);
			var r3:uint = DTools.rgbGetRFromHex(color3);
			var g3:uint = DTools.rgbGetGFromHex(color3);
			var b3:uint = DTools.rgbGetBFromHex(color3);
			var color2Reached:Boolean = false;
			// Target colors
			var tr:uint = 0;
			var tg:uint = 0;
			var tb:Number = 0;
			
			// Clear the graphics container.
			graphics.clear();
			
			// Calculate the thickness of the lines which draw the colors.
			iThickness = 1 + int(radius / 50);
			
			var step:Number = 0;
			var inc:Number = 0;
			for(var i:int = 0; i < 360; i++)
			{
				// Convert the degree to radians (correct for -90 deg offsset)
				nRadians = (i-89.9) * (Math.PI / 180);
				
				// Calculate the coordinate in which the line should be drawn to.
				nX = radius * Math.cos(nRadians);
				nY = radius * Math.sin(nRadians);
				
				// Create a matrix for the lines gradient color.
				objMatrix = new Matrix();
				objMatrix.createGradientBox(radius * 2, radius * 2, nRadians, -radius, -radius);
				
				// Work out color
				var degRange:Number = 360/2;
				if (i <= degRange)
				{
					tr = drawGradientColorCircleGetRGBTransition(i,degRange,r1,r2);
					tg = drawGradientColorCircleGetRGBTransition(i,degRange,g1,g2);
					tb = drawGradientColorCircleGetRGBTransition(i,degRange,b1,b2);
				} else {
					tr = drawGradientColorCircleGetRGBTransition(i,degRange,r2,r3);
					tg = drawGradientColorCircleGetRGBTransition(i,degRange,g2,g3);
					tb = drawGradientColorCircleGetRGBTransition(i,degRange,b2,b3);
				}
				color = DTools.rgbToHex(tr,tg,tb);
				//trace(tr + ":" + tg + ":" + tb +  "   HEX = " + DTools.getHexStringFromRGB(tr,tg,tb));
				
				// Create and drawn the line.
				graphics.lineStyle(iThickness, color, 1, false, LineScaleMode.NONE, CapsStyle.NONE);
				graphics.moveTo(-4, 0);
				graphics.lineTo(nX, nY);
			}
		}
		// --------------------------------------------------------------------------------------------
		// --------------------------------------------------------------------------------------------
		public static function drawGradientColorCircle(graphics:Graphics,radius:Number,color1:Number=0xFFCC33,color2:Number=0x000000):void
		{
			var nRadians:Number;
			var objMatrix:Matrix;
			var nX:Number;
			var nY:Number;
			var iThickness:int;
			var color:Number = 0x000000;
			var ct:ColorTransform = new ColorTransform();
			// start color in rgb
			var sr:uint = DTools.rgbGetRFromHex(color1);
			var sg:uint = DTools.rgbGetGFromHex(color1);
			var sb:uint = DTools.rgbGetBFromHex(color1);
			// End color in rgb
			var er:uint = DTools.rgbGetRFromHex(color2);
			var eg:uint = DTools.rgbGetGFromHex(color2);
			var eb:uint = DTools.rgbGetBFromHex(color2);
			// Target colors
			var tr:uint = 0;
			var tg:uint = 0;
			var tb:Number = 0;
			
			// Clear the graphics container.
			graphics.clear();
			
			// Calculate the thickness of the lines which draw the colors.
			iThickness = 1 + int(radius / 50);
			
			var range:uint = 0;
			var step:Number = 0;
			var inc:Number = 0;
			for(var i:int = 0; i < 360; i++)
			{
				// Convert the degree to radians (correct for -90 deg offsset)
				nRadians = (i-90) * (Math.PI / 180);
				
				// Calculate the coordinate in which the line should be drawn to.
				nX = radius * Math.cos(nRadians);
				nY = radius * Math.sin(nRadians);
				
				// Create a matrix for the lines gradient color.
				objMatrix = new Matrix();
				objMatrix.createGradientBox(radius * 2, radius * 2, nRadians, -radius, -radius);
				
				// Work out color
				tr = drawGradientColorCircleGetRGBTransition(i,360,sr,er);
				tg = drawGradientColorCircleGetRGBTransition(i,360,sg,eg);
				tb = drawGradientColorCircleGetRGBTransition(i,360,sb,eb);
				color = DTools.rgbToHex(tr,tg,tb);
				//trace(tr + ":" + tg + ":" + tb +  "   HEX = " + DTools.getHexStringFromRGB(tr,tg,tb));
				
				// Create and drawn the line.
				graphics.lineStyle(iThickness, color, 1, false, LineScaleMode.NONE, CapsStyle.NONE);
				graphics.moveTo(-4, 0);
				graphics.lineTo(nX, nY);
			}
		}
		// --------------------------------------------------------------------------------------------
		public static function drawGradientColorCircleGetRGBTransition(position:uint,degRange:Number,startColor:Number=0,endColor:Number=255):Number {
			var range:int = endColor - startColor;
			var step:Number = range / degRange;
			var inc:Number = step * (position);
			var targetColor:uint = 0;
			targetColor = (startColor + inc);
			//trace("startColor:" + startColor + " + inc:" + inc.toFixed(1) + "  =  targetColor:" + targetColor + "        range:" + range);
			return targetColor;
		}
		// --------------------------------------------------------------------------------------------

		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function drawGradientSpecturmWheel(graphics:Graphics,radius:Number):void
		{
			var nRadians   : Number;
			var nR         : Number;
			var nG         : Number;
			var nB         : Number;
			var nColor     : Number;
			var objMatrix  : Matrix;
			var nX         : Number;
			var nY         : Number;
			var iThickness : int;
			
			// Clear the graphics container.
			graphics.clear();
			
			// Calculate the thickness of the lines which draw the colors.
			iThickness = 1 + int(radius / 50);
			
			// Loop from '0' to '360' degrees, drawing lines from the center 
			// of the wheel outward the length of the specified radius.
			for(var i:int = 0; i < 360; i++)
			{
				// Convert the degree to radians.
				nRadians = i * (Math.PI / 180);
				
				// Calculate the RGB channels based on the angle of the line being drawn.
				nR = Math.cos(nRadians)                   * 127 + 128 << 16;
				nG = Math.cos(nRadians + 2 * Math.PI / 3) * 127 + 128 << 8;
				nB = Math.cos(nRadians + 4 * Math.PI / 3) * 127 + 128;
				
				// OR the individual color channels together.
				nColor = nR | nG | nB;
				
				// Calculate the coordinate in which the line should be drawn to.
				nX = radius * Math.cos(nRadians);
				nY = radius * Math.sin(nRadians);
				
				// Create a matrix for the lines gradient color.
				objMatrix = new Matrix();
				objMatrix.createGradientBox(radius * 2, radius * 2, nRadians, -radius, -radius);
				
				// Create and drawn the line.
				graphics.lineStyle(iThickness, 0, 1, false, LineScaleMode.NONE, CapsStyle.NONE);
				graphics.lineGradientStyle(GradientType.LINEAR, [0xFFFFFF, nColor], [100, 100], [127, 255], objMatrix);
				graphics.moveTo(0, 0);
				graphics.lineTo(nX, nY);
			}
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function drawRadialGradientCircle(graphics:Graphics,radius:Number,color1:Number=0xFF0000,color2:Number=0xFFFF00,alpha1:Number=1,alpha2:Number=1,ratio1:Number=0,ratio2:Number=255):void
		{
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(radius*2,radius*2,0,-radius,-radius);
			graphics.beginGradientFill(GradientType.RADIAL, [color1, color2], [alpha1,alpha2], [ratio1,ratio2], mtx);
			graphics.drawCircle(0,0,radius);
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function drawPieMask(
			graphics:Graphics, percentage:Number, radius:Number = 50, 
			x:Number = 0, y:Number = 0, rotation:Number = 0, 
			sides:int = 6):void
		{	
			//rotation = 0.0174532925 * (rotation-90);
			rotation = (Math.PI / 180) * (rotation-90);
			
			graphics.clear();
			graphics.beginFill(0x000000,1);
			
			// graphics should have its beginFill function already called by now
			graphics.moveTo(x, y);
			if (sides < 3) sides = 3; // 3 sides minimum
			
			// Increase the length of the radius to cover the whole target
			radius /= Math.cos(1/sides * Math.PI);
			
			// Shortcut function
			var lineToRadians:Function = function(rads:Number):void {
				graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
			};
			
			// Find how many sides we have to draw
			var sidesToDraw:int = Math.floor(percentage * sides);
			for (var i:int = 0; i <= sidesToDraw; i++)
				lineToRadians((i / sides) * (Math.PI * 2) + rotation);
			
			// Draw the last fractioned side
			if (percentage * sides != sidesToDraw)
				lineToRadians(percentage * (Math.PI * 2) + rotation);
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawSquareBox(width:Number=100,height:Number=100,colour:Number=0x003366,bClearShapeBeforeDraw:Boolean = true):Shape
		{
			var myShape:Shape = new Shape();
			
			if (bClearShapeBeforeDraw) { myShape.graphics.clear(); }
			myShape.graphics.beginFill(colour);
			//myShape.graphics.lineStyle(1, 0x000000,1,true,'normal',null,'JointStyle.BEVEL',10);
			myShape.graphics.drawRect(0,0,width,height);
			myShape.graphics.endFill();		
			
			return myShape;
		}// --------------------------------------------------------------------------------------------
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawSquareOutlinedBox(
				width:Number = 100,
				height:Number = 100,
				fillColor:Number = 0x444444,
				lineColor:Number = 0xCCCCCC,
				lineThickness:Number = 1,
				shape:Shape = null
		):Shape
		{
			var myShape:Shape;
			
			if (shape == null){
				myShape = new Shape();
			} else {
				myShape = shape;
			}
			
			myShape.graphics.clear();
			
			myShape.graphics.beginFill(fillColor);
			myShape.graphics.lineStyle(lineThickness, lineColor,1,true,'normal',null,'JointStyle.BEVEL',3);
			myShape.graphics.drawRect(0,0,width,height);
			myShape.graphics.endFill();		
			
			return myShape;
		}// --------------------------------------------------------------------------------------------
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledBox(width:Number=100,height:Number=100,colour:Number=0x003366,cornerRadius:Number = 60,bClearShapeBeforeDraw:Boolean = true):Shape
		{
			var myShape:Shape = new Shape();
			
			if (bClearShapeBeforeDraw) { myShape.graphics.clear(); }
			myShape.graphics.beginFill(colour);
			//myShape.graphics.lineStyle(1, 0x000000,1,true,'normal',null,'JointStyle.BEVEL',10);
			myShape.graphics.drawRoundRect(0, 0, width, height, cornerRadius,cornerRadius);
			myShape.graphics.endFill();		
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledBoxWithOutline(
				width:Number = 100,
				height:Number = 100,
				fillColor:Number = 0x444444,
				lineColor:Number = 0xCCCCCC,
				cornerRadius:Number = 60,
				lineThickness:Number = 1
			):Shape
		{
			var myShape:Shape = new Shape();
			
			myShape.graphics.clear();
			myShape.graphics.beginFill(fillColor);
			myShape.graphics.lineStyle(lineThickness, lineColor,1,true,'normal',null,'JointStyle.BEVEL',3);
			myShape.graphics.drawRoundRect(0, 0, width, height, cornerRadius,cornerRadius);
			myShape.graphics.endFill();		
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
				
		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledBoxWithOutlineUsingRoundedRectangles(
				width:Number = 100,
				height:Number = 100,
				fillColor:Number = 0x444444,
				lineColor:Number = 0xCCCCCC,
				cornerRadius:Number = 60,
				lineThickness:Number = 1
			):Shape
		{
			var myShape:Shape = new Shape();
			
			// Outline box
			myShape.graphics.clear();
			myShape.graphics.beginFill(lineColor);
			myShape.graphics.drawRoundRect(0, 0, width, height, cornerRadius,cornerRadius);
			myShape.graphics.endFill();
			
			// Innter fill box	
			myShape.graphics.beginFill(fillColor);
			myShape.graphics.drawRoundRect(0+lineThickness, 0+lineThickness, width-(lineThickness*2), height-(lineThickness*2), cornerRadius,cornerRadius);
			myShape.graphics.endFill();	
				
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		

		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawLine(startX:Number=100,startY:Number=100,endX:Number=200,endY:Number = 200,color:Number=0xFFFFFF,thickness:Number = 1,bClearOnCall:Boolean = true):Shape
		{
			var myShape:Shape = new Shape();
			
			if (bClearOnCall)
			{
				myShape.graphics.clear();
			}
			myShape.graphics.moveTo(startX, startY);
			myShape.graphics.lineStyle(thickness, color);
			myShape.graphics.lineTo(endX, endY);
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawOutlineBoxWithCornerGaps(nWidth:Number=100,nHeight:Number=100,color:Number=0xFFFFFF,nCornerGapSize:Number = 1):Shape
		{
			var myShape:Shape = new Shape();
			
			var thickness:Number = 1;
			
			// TOP LEFT > BOTTOM LEFT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(0,nCornerGapSize,thickness,nHeight-(nCornerGapSize*2));
			myShape.graphics.endFill();
			
			// TOP LEFT > TOP RIGHT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(nCornerGapSize,0,nWidth-(nCornerGapSize),thickness);
			myShape.graphics.endFill();
			
			// TOP RIGHT > BOTTOM RIGHT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(nWidth,nCornerGapSize,thickness,nHeight-(nCornerGapSize*2));
			myShape.graphics.endFill();
			
			// BOTTOM LEFT > BOTTOM RIGHT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(nCornerGapSize,nHeight-thickness,nWidth-(nCornerGapSize),thickness);
			myShape.graphics.endFill();

			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawGradientBox(
			graphics:Graphics,
			nColor1:Number = 0xFF0000,
			nColor1Alpha:Number = 1,
			nColor2:Number = 0xFFFFFF,
			nColor2Alpha:Number = 0.5,
			nWidth:Number=100,
			nHeight:Number=100,
			nAngle:Number=0,
			nRatio1:Number=0,
			nRatio2:Number=0
		):void
		{			
			var a:Number = 30;
			var b:Number = 255;
			var c:Number = 255;
			var d:Number = 0;
			var e:Number = 0;
			var cornerRadius:Number = 0;
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [nColor1, nColor2];
			var alphas:Array = [nColor1Alpha, nColor2Alpha]; // transparancies
			var ratios:Array = [a, b];
			var spreadMethod:String = SpreadMethod.PAD;
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(nWidth, nHeight, (nAngle * Math.PI/180), 0, 0);
			
			graphics.clear();
			graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod); 
			graphics.drawRoundRect(0, 0, nWidth,nHeight, cornerRadius,cornerRadius);
			graphics.endFill();	
		}// --------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawGradientBoxWithOutline(
			nColor1:Number = 0xFF0000,
			nColor1Alpha:Number = 1,
			nColor2:Number = 0xFFFFFF,
			nColor2Alpha:Number = 0.5,
			nWidth:Number=100,
			nHeight:Number=100,
			nAngle:Number=0,
			nRatio1:Number=0,
			nRatio2:Number=0,
			lineThickness:Number=1,
			lineColor:Number=0x550000
		):Shape
		{			
			var a:Number = 30;
			var b:Number = 255;
			var c:Number = 255;
			var d:Number = 0;
			var e:Number = 0;
			var cornerRadius:Number = 0;
			
			
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [nColor1, nColor2];
			var alphas:Array = [nColor1Alpha, nColor2Alpha]; // transparancies
			var ratios:Array = [a, b];
			var spreadMethod:String = SpreadMethod.PAD;
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(nWidth, nHeight, (nAngle * Math.PI/180), 0, 0);
			
			var shapeGradient:Shape = new Shape();
			shapeGradient.graphics.lineStyle(lineThickness,lineColor,1,true);
			shapeGradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod); 
			shapeGradient.graphics.drawRoundRect(0, 0, nWidth,nHeight, cornerRadius,cornerRadius);
			shapeGradient.graphics.endFill();	
			
			return shapeGradient;
		}// --------------------------------------------------------------------------------------------

		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledGradientBoxWithOutline(
			nColor1:Number = 0xFF0000,
			nColor1Alpha:Number = 1,
			nColor2:Number = 0xFFFFFF,
			nColor2Alpha:Number = 0.5,
			nWidth:Number=100,
			nHeight:Number=100,
			nAngle:Number=0,
			nRatio1:Number=0,
			nRatio2:Number=0,
			lineColor:Number = 0xCCCCCC,
			cornerRadius:Number = 60,
			lineThickness:Number = 1
		):Shape
		{			
			var a:Number = 30;
			var b:Number = 255;
			var c:Number = 255;
			var d:Number = 0;
			var e:Number = 0;
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [nColor1, nColor2];
			var alphas:Array = [nColor1Alpha, nColor2Alpha]; // transparancies
			var ratios:Array = [a, b];
			var spreadMethod:String = SpreadMethod.PAD;
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(nWidth, nHeight, (nAngle * Math.PI/180), 0, 0);
			
			var shapeGradient:Shape = new Shape();
			shapeGradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			shapeGradient.graphics.lineStyle(lineThickness, lineColor,1,true,'normal',null,'JointStyle.BEVEL',3);
			shapeGradient.graphics.drawRoundRect(0, 0, nWidth,nHeight, cornerRadius,cornerRadius);
			shapeGradient.graphics.endFill();	
			
			return shapeGradient;
		}// --------------------------------------------------------------------------------------------



	}
}