package com.partycommittee.manager.tree
{
	import com.partycommittee.control.tree.LoadingTreeRevert;
	import com.partycommittee.control.tree.classes.Node;
	import com.partycommittee.control.tree.classes.TreeOperationEvent;
	import com.partycommittee.events.PcAgencyEvent;
	import com.partycommittee.manager.popup.PopupMgr;
	import com.partycommittee.proxy.PcAgencyProxy;
	import com.partycommittee.util.AgencyCodeUtil;
	import com.partycommittee.util.CRUDEventType;
	import com.partycommittee.views.agencymgmt.agencyviews.AgencyMoveWindow;
	import com.partycommittee.views.agencymgmt.agencyviews.AgencyWindow;
	import com.partycommittee.vo.PcAgencyVo;
	
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;

	public class TreeHistoryContextMenuMgr {
		private static var instanceTreeHistoryContextMenuMgr:TreeHistoryContextMenuMgr;
		public function TreeHistoryContextMenuMgr() {
			if (instanceTreeHistoryContextMenuMgr) {
				throw new Error("ContextMenuMgr is singleton!");
			}
			instanceTreeHistoryContextMenuMgr = this;
		}
		
		public static function getInstance():TreeHistoryContextMenuMgr {
			if (instanceTreeHistoryContextMenuMgr == null) {
				instanceTreeHistoryContextMenuMgr = new TreeHistoryContextMenuMgr();
			}
			return instanceTreeHistoryContextMenuMgr;
		}
		
		private var _tree:LoadingTreeRevert;
		public function set tree(value:LoadingTreeRevert):void {
			this._tree = value;
		}
		public function get tree():LoadingTreeRevert {
			return this._tree;
		}
		
		private var _menu:ContextMenu;
		public function set menu(value:ContextMenu):void {
			this._menu = value;
		}
		public function get menu():ContextMenu {
			return this._menu;
		}
		
		public function registeContextMenu(loadingTree:LoadingTreeRevert):void {
			tree = loadingTree;
			menu = new ContextMenu();
			menu.hideBuiltInItems();
			loadingTree.contextMenu = menu;
			menu.addEventListener(ContextMenuEvent.MENU_SELECT, onMenuSelected);
			initMenuItems();
		}
		
		private function initMenuItems():void {
			refreshMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onRefresh);
			
			revertMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onRevert);
		}
		
		private function onMenuSelected(event:ContextMenuEvent):void {
			var node:Node = this.tree.selectedItem as Node;
			if (!node) {
				return;
			}
			var agencyVo:PcAgencyVo = node.entity as PcAgencyVo;
			if (!agencyVo) {
				return;
			}
			this._menu.customItems = createMenuItems(agencyVo);
		}
		
		private var revertMenuItem:ContextMenuItem = new ContextMenuItem("还原组织");

		private var refreshMenuItem:ContextMenuItem = new ContextMenuItem("刷 新", true);
		
		
		private function createMenuItems(agencyVo:PcAgencyVo):Array {
			var menuItems:Array = new Array();
			
			menuItems.push(refreshMenuItem);
			
			if (agencyVo.invalidDatetime> 0) {
				menuItems.push(revertMenuItem);
			}

			return menuItems;
		}
		
		private function onRefresh(event:ContextMenuEvent):void {
			var node:Node = tree.selectedItem as Node;
			if (!node) {
				return;
			}
			tree.fetchChildrenData(node);
		}
		
		public function onRevert(event:ContextMenuEvent):void {
			var node:Node = tree.selectedItem as Node;
			if (!node) {
				return;
			}
			var selectedAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (!selectedAgency) {
				return;
			}
			Alert.show("确定要还原组织【" + selectedAgency.name + "】？", "警告", 
				Alert.YES | Alert.NO, FlexGlobals.topLevelApplication.root, onRevertAlertClose);
		}
		
		private function onRevertAlertClose(event:CloseEvent):void {
			var node:Node = tree.selectedItem as Node;
			var selectedAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (event.detail == Alert.YES) {
				var evt:PcAgencyEvent = new PcAgencyEvent(PcAgencyEvent.DO_REVERT, selectedAgency);
				evt.node = node;
				evt.successCallback = onRevertAgencySuccessed;
				evt.dispatch();
			}
		}
		
		private function onRevertAgencySuccessed(data:Object, event:PcAgencyEvent):void {
			tree.dispatchEvent(new TreeOperationEvent(TreeOperationEvent.NODE_CHANGED));;
		}
		
		private function onRevacation(event:ContextMenuEvent):void {
		}
		
	}
}