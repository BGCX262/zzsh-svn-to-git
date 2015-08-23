package com.partycommittee.control.mainmenu
{
	import com.partycommittee.events.MenuEvent;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.effects.Fade;
	import mx.effects.Tween;
	import mx.managers.CursorManager;
	
	public class MenuItem extends Canvas {
		public function MenuItem() {
			super();
			this.clipContent = false;
//			this.mouseChildren = false;
//			this.buttonMode = true;
//			this.useHandCursor = true;
			this.setStyle("color", 0x000000);
			this._label.setStyle("verticalCenter", 0);
			this.addChild(this._label);
			this.addEventListener(MouseEvent.ROLL_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
		}
		
		private function mouseOverHandler(event:MouseEvent):void {
			this.mouseOver();
		}
		
		private function mouseOutHandler(event:MouseEvent):void {
			this.mouseOut();
		}
		
		protected var _mouseOn:Boolean = false;
		protected function mouseOver():void {
			this._mouseOn = true;
			this.invalidateDisplayList();
			if (this.itemEnabled) {
				this.showSubMenu();
			}
		}
		
		protected function mouseOut():void {
			this._mouseOn = false;
			this.invalidateDisplayList();
			this.hideSubMenu();
		}
		
		private var _menu:Menu;
		public function get menu():Menu {
			return this._menu;
		}
		public function set menu(value:Menu):void {
			this._menu = value;
		}
		
		private var _subMenu:SubMenu;
		public function get subMenu():SubMenu {
			return this._subMenu;
		}
		
		private var _label:Label = new Label();
		public function get titleLabel():Label {
			return this._label;
		}
		
		private var _labelField:String = "label";
		public function get labelField():String {
			return this._labelField;
		}
		public function set labelField(value:String):void {
			if (!value || value == "") return;
			this._labelField = value;
			if (!this._itemData || !this._itemData.hasOwnProperty(value)) return;
			this._label.text = String(this._itemData[value]);
		}
		
		private var _itemData:Object;
		public function get itemData():Object {
			return this._itemData;
		}
		public function set itemData(value:Object):void {
			this._itemData = value;
			if (!value || !value.hasOwnProperty(this._labelField)) return;
			this._label.text = String(value[this._labelField]);
			
			this.itemEnabled = String(value["enabled"]) != "false";
			this._clickFunc = value["click"] as Function;
			
			if (value.hasOwnProperty("children")) {
				var children:Array = value.children as Array;
				if (children) {
					var subMenu:SubMenu = new SubMenu();
					subMenu.visible = false;
					subMenu.menuData = children;
					subMenu.parentItem = this;
					this._subMenu = subMenu;
					this.addChild(subMenu);
					subMenu.validateNow();
					subMenu.resetSize();
					subMenu.setStyle("showEffect", this.showFade);
					subMenu.setStyle("hideEffect", this.hideFade);
				}
			}
		}
		
		private var _itemEnabled:Boolean = true;
		public function get itemEnabled():Boolean {
			return this._itemEnabled;
		}
		public function set itemEnabled(value:Boolean):void {
			this._itemEnabled = value;
			
//			if (value) {
//				this.setStyle("color", 0xffffdd);
//				this.mouseEnabled = true;
//			} else {
//				this.setStyle("color", 0xeeeeee);
//				this.mouseEnabled = false;
//			}
		}
		
		private var _showFade:Fade;
		protected function get showFade():Fade {
			if (!this._showFade) {
				this._showFade = new Fade();
				this._showFade.duration = 300;
			}
			return this._showFade;
		}
		
		private var _hideFade:Fade;
		protected function get hideFade():Fade {
			if (!this._hideFade) {
				this._hideFade = new Fade();
				this._hideFade.duration = 300;
			}
			return this._hideFade;
		}
		
		protected function showSubMenu():void {
			if (this._subMenu) {
				this.hideFade.end();
				this._subMenu.visible = true;
			}
		}
		protected function hideSubMenu():void {
			if (this._subMenu) {
				this.showFade.end();
				this.subMenu.visible = false;
			}
		}
		
		protected function hideItem():void {
			var menu:SubMenu;
			var item:MenuItem;
			
//			this.hideSubMenu();
			
			menu = this.menu as SubMenu;
			while (menu) {
				item = menu.parentItem;
				if (item) {
					item.hideSubMenu();
					menu = item.menu as SubMenu;
				} else {
					break;
				}
			}
		}
		
		private var _clickFunc:Function;
		
		private function clickHandler(event:MouseEvent):void {
			if (!this.itemEnabled) {
				return;
			}
			this.hideItem();
//			if (this._clickFunc === null) return;
//			this._clickFunc();
			if (!this.menu) {
				return;
			}
			
			if (this.menu is MainMenu) {
				if (this._itemData.hasOwnProperty('menuEvent') && this._itemData['menuEvent'] == true) {
					this.menu.dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK, this._itemData));
				}
			} else {
				this.menu.dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK, this._itemData));
			}
		}
	}
}