package com.partycommittee.control.mainmenu
{
	import flash.display.Graphics;
	
	import mx.controls.Label;
	import mx.events.ResizeEvent;

	public class SubMenuItem extends MenuItem {
		public function SubMenuItem() {
			super();
			this.clipContent = false;
			this.titleLabel.setStyle("verticalCenter", 0);
			this.titleLabel.setStyle("left", 15);
			this.titleLabel.addEventListener(ResizeEvent.RESIZE, titleResizeHandler);
		}
		;
		private function titleResizeHandler(event:ResizeEvent):void {
			this.width = this.titleLabel.width + 30 + (this.subMenu ? 20 : 0); 
		}
		
		override public function set itemData(value:Object):void {
			super.itemData = value;
			this.width = this.titleLabel.width + 30 + (this.subMenu ? 20 : 0);
		}
		
		override protected function showSubMenu():void {
			if (!this.subMenu) return;
			
			var x:Number = this.width;
			var y:Number = 0;
			var x2:Number = -this.subMenu.width;
			var y2:Number = this.height - this.subMenu.height;
			if (x + this.subMenu.width > this.stage.width) {
				x = x2;
			}
			if (y + this.subMenu.height > this.stage.height) {
				y = y2;
			}
			this.subMenu.move(x, y);
			this.subMenu.resetSize();
			this.subMenu.visible = true;
			super.showSubMenu();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = this.graphics;
			g.clear();
			
			g.beginFill(0xffff99);
			g.drawRect(0, 0, unscaledWidth, unscaledHeight);
			g.endFill();
			
			if (this.itemEnabled && this._mouseOn) {
				g.beginFill(0xffcc00);
				g.drawRect(3, 3, unscaledWidth - 3, unscaledHeight - 3);
				g.endFill();
			}
			
			if (this.subMenu && this.subMenu.items && this.subMenu.items.length) {
				g.beginFill(this.mouseEnabled ? 0xffffff : 0x7f7f7f);
				g.moveTo(unscaledWidth - 15, unscaledHeight / 2 - 3);
				g.lineTo(unscaledWidth - 11, unscaledHeight / 2);
				g.lineTo(unscaledWidth - 15, unscaledHeight / 2 + 3);
				g.lineTo(unscaledWidth - 15, unscaledHeight / 2 - 3);
				g.endFill();
			}
		}
	}
}