package com.partycommittee.control 
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Label;

	/**
	 * PropertyGrid is a canvas for display properties. 
	 * we can config its:
	 *  1, interval background color
	 *  2, property name column width
	 */
	public class PropertyGrid extends HBox {
		public var intervalColor:uint = 0x19516d;
		
		public function PropertyGrid() {
			super();
			this.setStyle("color", 0xffffff);
			this.setStyle("horizontalGap", 5);
			
			this._keysVBox.setStyle("horizontalAlign", "right");
			this.addChild(this._keysVBox);
			this._valuesVBox.percentWidth = 100;
			this.addChild(this._valuesVBox);
		}
		
		private var _keysVBox:VBox = new VBox();
		private var _valuesVBox:VBox = new VBox();
		
		private var _keysBoxWidth:Number;
		public function set keysBoxWidth(value:Number):void {
			this._keysBoxWidth = value;
			if (this._keysVBox) {
				this._keysVBox.width = value;
			}
		}
		public function get keysBoxWidth():Number {
			return this._keysBoxWidth;
		}
		
		private var _dataProvider:Array;
		public function get dataProvider():Array {
			return this._dataProvider;
		}
		public function set dataProvider(value:Array):void {
			this._keysVBox.removeAllChildren();
			this._valuesVBox.removeAllChildren();
			
			_dataProvider = value;
			
			if (!value) return;
			
			for (var i:int = 0; i < value.length; i++) {
				var data:Object = value[i];
				
				var titleLabel:Label = new Label();
				titleLabel.text = data["label"];
				this._keysVBox.addChild(titleLabel);
				
				var valueLabel:Label = new Label();
				valueLabel.text = data["value"];
				valueLabel.maxWidth = 140;
				this._valuesVBox.addChild(valueLabel);
			}
			
			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var g:Graphics = this.graphics;
			
			g.clear();
			if (!this._dataProvider || !this._dataProvider.length) return;
			
			var height:Number = unscaledHeight / this._dataProvider.length;
			for (var i:int = 0; i < Math.floor(this._dataProvider.length / 2); i++) {
				g.beginFill(this.intervalColor, 1);
				g.drawRect(0, (i * 2 + 1) * height, unscaledWidth, height);
				g.endFill();
			}
		}
	}
}