package com.partycommittee.control.closebox
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.filters.BevelFilter;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	
	public class ContentPanel extends Canvas {
		public function ContentPanel() {
			super();
			this.filters = [new BevelFilter(2)];
		}
		
		private function RGB(r:uint, g:uint, b:uint):uint {
			return (r << 16) + (g << 8) + b;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = this.graphics;
			g.clear();
			
			var corner:Number = 8;
			
			g.lineStyle(0, 0, 0);
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);
			g.beginGradientFill(GradientType.LINEAR, [RGB(40, 75, 120), RGB(126, 149, 177)], [1, 1], [0, 255], m);
			g.drawRect(0, 0, unscaledWidth, unscaledHeight);
//			g.moveTo(corner, 0);
//			g.lineTo(unscaledWidth - (corner + 1), 0);
//			g.curveTo(unscaledWidth - 1, 0, unscaledWidth - 1, corner);
//			g.lineTo(unscaledWidth - 1, unscaledHeight - (corner + 1));
//			g.curveTo(unscaledWidth - 1, unscaledHeight - 1, unscaledWidth - (corner + 1), unscaledHeight - 1);
//			g.lineTo(corner, unscaledHeight - 1);
//			g.curveTo(0, unscaledHeight - 1, 0, unscaledHeight - (corner + 1));
//			g.lineTo(0, 40);
//			g.lineTo(-10, 30);
//			g.lineTo(0, 20);
//			g.lineTo(0, corner);
//			g.curveTo(0, 0, corner, 0);
			g.endFill();
		}
	}
}