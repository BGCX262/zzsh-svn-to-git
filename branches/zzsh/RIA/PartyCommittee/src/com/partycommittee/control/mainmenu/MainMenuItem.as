package com.partycommittee.control.mainmenu
{
	import flash.display.Graphics;
	import flash.filters.DropShadowFilter;
	
	import mx.events.ResizeEvent;

	public class MainMenuItem extends MenuItem {
		public function MainMenuItem() {
			super();
			this.setStyle("backgroundColor", 0xffffff);
			this.setStyle("backgroundAlpha", 0);
			this.titleLabel.setStyle("left", 15);
//			this.titleLabel.setStyle("right", 10);
			this.titleLabel.addEventListener(ResizeEvent.RESIZE, titleResizeHandler);
		}
		
		private function titleResizeHandler(event:ResizeEvent):void {
			this.width = this.titleLabel.width + 30;// + (this.subMenu ? 10 : 0);
			if (this.subMenu) {
				this.subMenu.container.minWidth = this.width;
			}
		}
		
		override public function set itemData(value:Object):void {
			super.itemData = value;
			this.width = this.titleLabel.width + 30;// + (this.subMenu ? 10 : 0);
		}
		
		override protected function showSubMenu():void {
			if (!this.subMenu) return;
			
			var x:Number = 0;
			var y:Number = this.height;
			var x2:Number = this.width - this.subMenu.width;
			var y2:Number = -this.subMenu.height;
			if (x + this.subMenu.width > this.stage.width) {
				x = x2;
			}
			if (y + this.subMenu.height > this.stage.height) {
				y = y2;
			}
			this.subMenu.move(x, y);
			this.subMenu.resetSize();
			super.showSubMenu();
		}
		
		private var _shadow:DropShadowFilter;
		protected function get shadow():DropShadowFilter {
			if (!this._shadow) {
				this._shadow = new DropShadowFilter(2, 45, 0x7f7f7f, 0.7, 2, 2);
			}
			return this._shadow;
		}
		
		override protected function mouseOver():void {
			super.mouseOver();
//			this.filters = [this.shadow];
		}
		
		override protected function mouseOut():void {
			super.mouseOut();
//			this.filters = [];
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = this.graphics;
			g.clear();
			
			g.lineStyle(1, 0x000000, 1, true);
			if (this._mouseOn && this.itemEnabled) {
				g.beginFill(0xffff99);
			} else {
				g.beginFill(0xffcd00);
			}
			g.moveTo(8, 0);
			g.lineTo(unscaledWidth - 8, 0);
			g.curveTo(unscaledWidth, 0, unscaledWidth, 8);
			g.lineTo(unscaledWidth, unscaledHeight);
			g.lineStyle(0, 0xffffff, 0, true);
			g.lineTo(0, unscaledHeight);
			g.lineStyle(1, 0xffffff, 1, true);
			g.lineTo(0, 8);
			g.curveTo(0, 0, 8, 0);
			g.endFill();
			
			if (this.subMenu && this.subMenu.items && this.subMenu.items.length) {
				g.lineStyle(0, 0, 0, true);
				g.beginFill(this.itemEnabled ? 0xffffdd : 0x7f7f7f);
				g.moveTo(unscaledWidth - 13, unscaledHeight / 2 - 2);
				g.lineTo(unscaledWidth - 7, unscaledHeight / 2 - 2);
				g.lineTo(unscaledWidth - 10, unscaledHeight / 2 + 2);
				g.lineTo(unscaledWidth - 13, unscaledHeight / 2 - 2);
				g.endFill();
			}
		}
	}
}