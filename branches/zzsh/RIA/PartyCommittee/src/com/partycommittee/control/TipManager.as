package com.hp.rfid.controls.tip {
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import spark.primitives.Graphic;
	
	public class TipManager extends Canvas {
		public static const TEXT_PADDING_WIDTH:Number = 20;
		public static const TEXT_PADDING_HEIGHT:Number = 5;
		private static var instance:TipManager;
		
		public function TipManager() {
			super();
			
			if (instance) {
				return;
			}
			
			_label = new Label();
			_label.setStyle("left", TEXT_PADDING_WIDTH);
			_label.setStyle("right", TEXT_PADDING_WIDTH);
			_label.setStyle("top", TEXT_PADDING_HEIGHT);
			_label.setStyle("bottom", TEXT_PADDING_HEIGHT + 4);
			_label.setStyle("color", 0xffffff);
			_label.setStyle("fontWeight","bold");
			addChild(_label);
			
			this.filters = [new DropShadowFilter(1, 90, 0x000000, 0.7, 3,3)];
			
			_label.addEventListener(Event.RESIZE, onResize);
		}
		
		public static function getInstance():TipManager {
			if (!instance) {
				instance = new TipManager();
			}
			return instance;
		}
		
		private var _label:Label;
		private var baseX:Number;
		private var baseY:Number;
		
		// Triangle 
		private var _arrowHeight:Number = 5;
		private var _arrowWidth:Number = 8;
		
		private var _isPopup:Boolean = false;
		
		public function set isPopup(value:Boolean):void {
			_isPopup = value;
		}
		
		public function get isPopup():Boolean {
			return _isPopup;
		}
		
	    public function showTip(content:String):void {
			if (isPopup) {
				hideTip();
			}
			
			_label.text = content;
			baseX = FlexGlobals.topLevelApplication.stage.x;
			baseY = FlexGlobals.topLevelApplication.stage.y;
			calculatePosition();
			PopUpManager.addPopUp(this, FlexGlobals.topLevelApplication.root);
			FlexGlobals.topLevelApplication.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_isPopup = true;
		}
		
		public static function showToolTipAt(content:String):void {
			getInstance().showTip(content);
		}
		
		public function hideTip():void {
			PopUpManager.removePopUp(this);
			FlexGlobals.topLevelApplication.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_isPopup = false;
		}
		
		public static function hideToolTip():void {
			getInstance().hideTip();
		}
		
		private function onMouseMove(event:MouseEvent):void {
			x += event.stageX - baseX;
			y += event.stageY - baseY;
			baseX = event.stageX;
			baseY = event.stageY;
		}
		
		private function calculatePosition():void {
			if (isNaN(baseX) || isNaN(baseY)) {
				return;
			}
			
			x = baseX - TEXT_PADDING_WIDTH - _label.width/2;
			y = baseY - 8 - _label.height - TEXT_PADDING_HEIGHT*2;
		}
		
		private function onResize(event:Event):void {
			calculatePosition();
		}
		
		private static function RGBToColor(r:uint, g:uint, b:uint):uint {
			return (r << 16) + (g << 8) + b;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = graphics;
			g.clear();
			
			var cornerRadius:Number = 5;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(100, 50, Math.PI / 2, 0, 0);
			g.beginGradientFill(GradientType.LINEAR, [RGBToColor(84,162, 234), RGBToColor(60,111,216)], [0.7, 0.7], [0, 255], matrix);
			g.lineTo(unscaledWidth - cornerRadius, 0);
			g.curveTo(unscaledWidth, 0, unscaledWidth, cornerRadius);
			g.lineTo(unscaledWidth, unscaledHeight - _arrowHeight - cornerRadius);
			g.curveTo(unscaledWidth, unscaledHeight - _arrowHeight, unscaledWidth - cornerRadius, unscaledHeight-_arrowHeight);
			g.lineTo(unscaledWidth/2 + _arrowWidth/2, unscaledHeight-_arrowHeight);
			g.lineTo(unscaledWidth/2, unscaledHeight);
			g.lineTo(unscaledWidth/2 - _arrowWidth/2, unscaledHeight - _arrowHeight);
			g.lineTo(cornerRadius, unscaledHeight - _arrowHeight);
			g.curveTo(0, unscaledHeight - _arrowHeight, 0, unscaledHeight - cornerRadius - _arrowHeight);
			g.lineTo(0, cornerRadius);
			g.curveTo(0, 0, cornerRadius, 0);
			g.endFill();
		}
	}
}