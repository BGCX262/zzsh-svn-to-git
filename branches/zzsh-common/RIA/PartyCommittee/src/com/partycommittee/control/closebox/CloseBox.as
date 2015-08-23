package com.partycommittee.control.closebox
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.Canvas;
	
	public class CloseBox extends Canvas {
		public function CloseBox() {
			super();
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			this.clipContent = true;
			
			this.addChild(this._closeContainer);
			BindingUtils.bindProperty(this, "width", this._closeContainer, "width");
		}
		
		public function get clsoed():Boolean {
			return this._closeContainer.closed;
		}
		public function set closed(value:Boolean):void {
			this._closeContainer.closed = value;
		}
		
		private var _closeContainer:CloseContainer = new CloseContainer();
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child == this._closeContainer) {
				return super.addChild(child);
			} else {
				return this._closeContainer.addChild(child);
			}
		}
	}
}