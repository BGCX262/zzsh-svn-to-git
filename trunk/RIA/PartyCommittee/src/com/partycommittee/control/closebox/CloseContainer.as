package com.partycommittee.control.closebox
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	import mx.effects.Tween;
	
	public class CloseContainer extends Canvas {
		public function CloseContainer() {
			super();
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			
			this._controlButton.setStyle("right", 0);
			this.addChild(this._controlButton);
			this._controlButton.addEventListener(MouseEvent.CLICK, buttonClickHandler);
			
			this.addChild(this._contentPanel);
			
			BindingUtils.bindSetter(setWidth, this._contentPanel, "width");
		}
		
		private function buttonClickHandler(event:MouseEvent):void {
			this.closed = !this.closed;
		}
		
		private function setWidth(value:Number):void {
			this.width = value + 16;
		}
		
		private var _contentPanel:ContentPanel = new ContentPanel();
		private var _controlButton:ControlButton = new ControlButton();
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child == this._contentPanel || child == this._controlButton) {
				return super.addChild(child);
			} else {
				return this._contentPanel.addChild(child);
			}
		}
		
		private function moveUpdate(values:Array):void {
			this.x = -values[0];
		}
		
		private function moveEnd(values:Array):void {
			this.moveUpdate(values);
		}
		
		public function open():void {
			new Tween(this, [this._contentPanel.width], [0], 300, -1, moveUpdate, moveEnd);
		}
		
		public function close():void {
			new Tween(this, [0], [this._contentPanel.width], 300, -1, moveUpdate, moveEnd);
		}
		
		private var _closed:Boolean = false;
		public function get closed():Boolean {
			return this._closed;
		}
		public function set closed(value:Boolean):void {
			if (this._closed == value) return;
			this._closed = value;
			if (value) {
				this.close();
			} else {
				this.open();
			}
		}
	}
}