package com.partycommittee.control.mainmenu
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.containers.VBox;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.effects.Fade;
	import mx.events.EffectEvent;
	import mx.managers.PopUpManager;
	
	public class SubMenu extends Menu {
		public function SubMenu() {
			super();
			this.setStyle("fontWeight", "normal");
			this._container.clipContent = false;
			this._container.setStyle("verticalGap", 0);
			this.addChild(this._container);
//			this.setStyle("showEffect", showFade);
//			this.setStyle("hideEffect", hideFade);
		}
		
//		private var _showFade:Fade;
//		protected function get showFade():Fade {
//			if (!this._showFade) {
//				this._showFade = new Fade();
//				this._showFade.duration = 300;
//			}
//			return this._showFade;
//		}
//		
//		private var _hideFade:Fade;
//		protected function get hideFade():Fade {
//			if (!this._hideFade) {
//				this._hideFade = new Fade();
//				this._hideFade.duration = 300;
//			}
//			return this._hideFade;
//		}
		
		private var _itemHeight:Number = 26;
		public function get itemHeight():Number {
			return this._itemHeight;
		}
		public function set itemHeight(value:Number):void {
			this._itemHeight = value;
			for each (var item:MenuItem in this.items) {
				item.height = value;
			}
		}
		
		private var _container:VBox = new VBox();
		public function get container():VBox {
			return this._container;
		}
		
		private var _parentItem:MenuItem;
		public function get parentItem():MenuItem {
			return this._parentItem;
		}
		public function set parentItem(value:MenuItem):void {
			this._parentItem = value;
		}
		
		override protected function createMenuItem(itemData:Object):MenuItem {
			var menuItem:SubMenuItem = new SubMenuItem();
			menuItem.itemData = itemData;
			return menuItem;
		}
		
		override protected function clearMenuItems():void {
			super.clearMenuItems();
			this._container.removeAllChildren();
		}
		
		override protected function addMenuItem(item:MenuItem):void {
			item.height = this._itemHeight;
			super.addMenuItem(item);
			this._container.addChild(item);
		}
		
		public function resetSize():void {
			var size:Number = 0;
			for each (var item:MenuItem in this.items) {
				if (item.width > size) {
					size = item.width;
				}
				item.percentWidth = 100;
			}
			this._container.width = size;
		}
	}
}