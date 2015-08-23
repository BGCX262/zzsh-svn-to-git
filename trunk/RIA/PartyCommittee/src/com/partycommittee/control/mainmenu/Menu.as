package com.partycommittee.control.mainmenu
{
	import mx.containers.Canvas;
	
	public class Menu extends Canvas {
		public function Menu() {
			super();
			this.setStyle("color", 0xffffff);
			this.clipContent = false;
		}
		
		private var _items:Array;
		public function get items():Array {
			return this._items;
		}
		
		private var _menuData:Array;
		public function get menuData():Array {
			return this._menuData;
		}
		public function set menuData(value:Array):void {
			this.clearMenuItems();
			
			this._menuData = value;
			if (!value) return;
			
			for each (var itemData:Object in value) {
				var menuItem:MenuItem = this.createMenuItem(itemData);
				if (menuItem) {
					menuItem.menu = this;
					this.addMenuItem(menuItem);
				}
			}
		}
		
		protected function createMenuItem(itemData:Object):MenuItem {
			var menuItem:MenuItem = new MenuItem();
			menuItem.itemData = itemData;
			return menuItem;
		}
		
		protected function addMenuItem(item:MenuItem):void {
			this._items.push(item);
		}
		
		protected function clearMenuItems():void {
			this._items = new Array();
		}
	}
}