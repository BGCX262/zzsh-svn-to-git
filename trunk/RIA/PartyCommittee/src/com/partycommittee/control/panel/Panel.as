package com.partycommittee.control.panel
{
	import flash.display.DisplayObject;
	
	import mx.containers.Canvas;
	
	public class Panel extends Canvas {
		public function Panel() {
			super();
			this._panelTitle.setStyle("top", 0);
			this._panelTitle.height = this._titleHeight;
			this.horizontalScrollPolicy = "off";
			this.verticalScrollPolicy = "off";
			this.addChild(this._panelTitle);
			
			this._container.setStyle("top", this._titleHeight);
			this._container.setStyle("bottom", 0);
			this._container.percentWidth = 100;
			this.addChild(this._container);
		}
		
		private var _titleHeight:Number = 30;
		
		private var _panelTitle:PanelTitle = new PanelTitle();
		public function get title():String {
			return this._panelTitle.title;
		}
		public function set title(value:String):void {
			this._panelTitle.title = value;
		}
		
		private var _panelTitleColor:uint;
		public function set panelTitleColor(value:uint):void {
			this._panelTitle.titleColor = value;
		}
		
		private var _container:Canvas = new Canvas();
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if (child == this._panelTitle || child == this._container) {
				return super.addChild(child);
			} else {
				return this._container.addChild(child);
			}
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			if (child == this._panelTitle || child == this._container) {
				return super.removeChild(child);
			} else {
				return this._container.removeChild(child);
			}
		}
		
		override public function createComponentsFromDescriptors(recurse:Boolean=true):void {
			super.createComponentsFromDescriptors(recurse);
			for each (var child:DisplayObject in this.getChildren()) {
				this.addChild(child);
			}
		}
	}
}