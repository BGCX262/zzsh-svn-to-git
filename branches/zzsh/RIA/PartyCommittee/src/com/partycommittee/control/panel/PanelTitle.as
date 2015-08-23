package com.partycommittee.control.panel
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	
	public class PanelTitle extends Canvas {
		public function PanelTitle() {
			super();
			this.percentWidth = 100;
			this._label.setStyle("verticalCenter", 0);
			this._label.setStyle("left", 20);
			
			this._label.setStyle("color", 0xffffff);
			this._label.setStyle("fontWeight", "bold");
			this.addChild(this._label);
		}
		
		private var _label:Label = new Label();
		public function get title():String {
			return this._label.text;
		}
		public function set title(value:String):void {
			this._label.text = value;
		}
		
		private var _titleColor:uint = 0x19516d;
		public function set titleColor(value:uint):void {
			this._titleColor = value;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = this.graphics;
			g.clear();
			
			var cornerRadius:Number = 6;
			
			var x:Number = 0;
			
			var w:Number = unscaledWidth;
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, unscaledHeight, Math.PI / 2, 0, 0);
			g.beginGradientFill(GradientType.LINEAR, [this._titleColor, this._titleColor], [1, 1], [0, 255], matrix);
			g.moveTo(cornerRadius + x, 0);
			g.lineTo(w - cornerRadius, 0);
			g.curveTo(w, 0, w, cornerRadius);
			g.lineTo(w, unscaledHeight);
			g.lineTo(x, unscaledHeight);
			g.lineTo(x, cornerRadius);
			g.curveTo(x, 0, cornerRadius + x, 0);
			g.endFill();
		}
	}
}