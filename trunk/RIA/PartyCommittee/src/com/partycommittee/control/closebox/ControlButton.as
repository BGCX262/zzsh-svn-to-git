package com.partycommittee.control.closebox
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	
	public class ControlButton extends Canvas {
		public function ControlButton() {
			super();
			this.width = 16;
			this.percentHeight = 100;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = this.graphics;
			g.clear();
			
			var corner:Number = 8;
			
			g.lineStyle(0, 0, 0);
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);
			g.beginGradientFill(GradientType.LINEAR, [0xb50100, 0xdc6801], [1, 1], [0, 255], m);
			g.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, 0, corner, 0, corner);
			g.endFill();
		}
	}
}