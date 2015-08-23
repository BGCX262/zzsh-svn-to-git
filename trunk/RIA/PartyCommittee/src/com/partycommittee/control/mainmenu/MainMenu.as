package com.partycommittee.control.mainmenu
{
	import mx.containers.HBox;

	public class MainMenu extends Menu {
		public function MainMenu() {
			super();
			this.setStyle("fontWeight", "bold");
			this._container.clipContent = false;
			this._container.setStyle("horizontalGap", 0);
			this.addChild(this._container);
		}
		
		private var _itemHeight:Number = 30;
		public function get itemHeight():Number {
			return this._itemHeight;
		}
		public function set itemHeight(value:Number):void {
			this._itemHeight = value;
			for each (var item:MenuItem in this.items) {
				item.height = value;
			}
		}
		
		private var _container:HBox = new HBox();
		public function get container():HBox {
			return this._container;
		}
		
		private var _itemGap:Number;
		public function set itemGap(value:Number):void {
			this._itemGap = value;
			this._container.setStyle("horizontalGap", this._itemGap);
		}
		public function get itemGap():Number {
			return this._itemGap;
		}
		
		override protected function createMenuItem(itemData:Object):MenuItem {
			var menuItem:MainMenuItem = new MainMenuItem();
			menuItem.itemData = itemData;
			return menuItem;
		}
		
		override protected function addMenuItem(item:MenuItem):void {
			item.height = this.itemHeight;
			super.addMenuItem(item);
			this._container.addChild(item);
		}
		
		override protected function clearMenuItems():void {
			super.clearMenuItems();
			this._container.removeAllChildren();
		}
	}
}