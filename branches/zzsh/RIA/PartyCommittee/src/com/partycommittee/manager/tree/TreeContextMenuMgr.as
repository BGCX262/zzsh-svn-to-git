package com.partycommittee.manager.tree
{
	import com.partycommittee.control.tree.LoadingTree;
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

	public class TreeContextMenuMgr {
		private static var instance:TreeContextMenuMgr;
		public function TreeContextMenuMgr() {
			if (instance) {
				throw new Error("ContextMenuMgr is singleton!");
			}
			instance = this;
		}
		
		public static function getInstance():TreeContextMenuMgr {
			if (instance == null) {
				instance = new TreeContextMenuMgr();
			}
			return instance;
		}
		
		private var _tree:LoadingTree;
		public function set tree(value:LoadingTree):void {
			this._tree = value;
		}
		public function get tree():LoadingTree {
			return this._tree;
		}
		
		private var _menu:ContextMenu;
		public function set menu(value:ContextMenu):void {
			this._menu = value;
		}
		public function get menu():ContextMenu {
			return this._menu;
		}
		
		private var _editEnable:Boolean = true;
		public function get editEnable():Boolean {
			return this._editEnable;
		}
		public function set editEnable(value:Boolean):void {
			this._editEnable = value;
		}
		
		private var _enableRefresh:Boolean = true;
		public function get enableRefresh():Boolean {
			return this._enableRefresh;
		}
		public function set enableRefresh(value:Boolean):void {
			this._enableRefresh = value;
		}
		
		public function registeContextMenu(loadingTree:LoadingTree):void {
			tree = loadingTree;
			menu = new ContextMenu();
			menu.hideBuiltInItems();
			loadingTree.contextMenu = menu;
			menu.addEventListener(ContextMenuEvent.MENU_SELECT, onMenuSelected);
			initMenuItems();
		}
		
		private function initMenuItems():void {
			refreshMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onRefresh);
			
//			createFirstBranchMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onCreateChildren);
			createBasicMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onCreateChildren);
			createBranchMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onCreateChildren);
			createGaneralBranchMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onCreateChildren);
			createTeamMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onCreateChildren);
			
			updateMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onUpdate);
			moveMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMove);
			deleteMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onDelete);
//			revacationMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onRevacation);
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
			this._menu.customItems = createMenuItems(agencyVo.codeId);
		}
		
//		private var createFirstBranchMenuItem:ContextMenuItem = new ContextMenuItem("建立第一党支部");
		private var createBasicMenuItem:ContextMenuItem = new ContextMenuItem("建立基层党委");
		private var createEJDWMenuItem:Object = new ContextMenuItem("建立二级党委");
		private var createBranchMenuItem:ContextMenuItem = new ContextMenuItem("建立党支部");
		private var createGaneralBranchMenuItem:ContextMenuItem = new ContextMenuItem("建立党总支部");
		private var createTeamMenuItem:ContextMenuItem = new ContextMenuItem("建立党小组");
		
		private var refreshMenuItem:ContextMenuItem = new ContextMenuItem("刷 新", true);
		
		private var updateMenuItem:ContextMenuItem = new ContextMenuItem("修 改", true);
		private var moveMenuItem:ContextMenuItem = new ContextMenuItem("划 转", true);
		private var deleteMenuItem:ContextMenuItem = new ContextMenuItem("撤 销", true);
//		private var revacationMenuItem:ContextMenuItem = new ContextMenuItem("撤 销", true, false);
		
		private function createMenuItems(codeId:Number):Array {
			var menuItems:Array = new Array();
			if (!editEnable) {
				if (codeId != PCConst.AGENCY_CODE_TEAM && codeId != PCConst.AGENCY_CODE_BRANCH && enableRefresh) {
					menuItems.push(refreshMenuItem);
				}
				return menuItems;
			}
			switch (codeId) {
				case PCConst.AGENCY_CODE_BOARDCOMMITTEES:
					menuItems.push(createBasicMenuItem, createBranchMenuItem);
					break;
				case PCConst.AGENCY_CODE_BASICCOMMITTEES:
					menuItems.push(createGaneralBranchMenuItem, createEJDWMenuItem, createBranchMenuItem, deleteMenuItem);
					break;
				case PCConst.AGENCY_CODE_BRANCH:
					menuItems.push(moveMenuItem, deleteMenuItem);
					break;
				case PCConst.AGENCY_CODE_FIRSTBRANCH:
					menuItems.push(createTeamMenuItem);
					break;
				case PCConst.AGENCY_CODE_GANERALBRANCH:
				case PCConst.AGENCY_CODE_EJDW:
					menuItems.push(createBranchMenuItem, deleteMenuItem);
					break;			
				case PCConst.AGENCY_CODE_TEAM:
					break;
			}
			if (codeId != PCConst.AGENCY_CODE_TEAM && codeId != PCConst.AGENCY_CODE_BRANCH && enableRefresh) {
				menuItems.push(refreshMenuItem);
			}
			if (codeId != PCConst.AGENCY_CODE_BOARDCOMMITTEES) {
//				menuItems.push(updateMenuItem, moveMenuItem, deleteMenuItem, revacationMenuItem);
				menuItems.push(updateMenuItem);
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
		
		// MenuItem select event.
		private function onCreateChildren(event:ContextMenuEvent):void {
			var menuItem:ContextMenuItem = event.currentTarget as ContextMenuItem;
			var agencyCodeId:Number;
			switch (menuItem) {
//				case createFirstBranchMenuItem:
//					agencyCodeId = PCConst.AGENCY_CODE_FIRSTBRANCH;
//					break;
				case createBasicMenuItem:
					agencyCodeId = PCConst.AGENCY_CODE_BASICCOMMITTEES;
					break;
				case createBranchMenuItem:
					agencyCodeId = PCConst.AGENCY_CODE_BRANCH;
					break;
				case createGaneralBranchMenuItem:
					agencyCodeId = PCConst.AGENCY_CODE_GANERALBRANCH;
					break;
				case createTeamMenuItem:
					agencyCodeId = PCConst.AGENCY_CODE_TEAM;
					break;
				case createEJDWMenuItem:
					agencyCodeId = PCConst.AGENCY_CODE_EJDW;					
					break;
			}
			if (!agencyCodeId) {
				return;
			}
			var title:String = "新建" + AgencyCodeUtil.getAgencyCodeDes(agencyCodeId);
			var node:Node = tree.selectedItem as Node;
			if (!node) {
				return;
			}
			var parentAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (parentAgency) {
				var win:AgencyWindow = new AgencyWindow();
				win.type = CRUDEventType.CREATE;
				win.title = title;
				win.agencyCodeId = agencyCodeId;
				win.parentAgency = parentAgency;
				PopupMgr.instance.popupWindow(win);
			}
		}
		
		public function onUpdate(event:ContextMenuEvent):void {
			var node:Node = tree.selectedItem as Node;
			if (!node || !node.entity) {
				return;
			}
			var agencyCodeId:Number = (node.entity as PcAgencyVo).codeId;
			var title:String = "修改" + AgencyCodeUtil.getAgencyCodeDes(agencyCodeId);
			var selectedAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (selectedAgency) {
				var win:AgencyWindow = new AgencyWindow();
				win.type = CRUDEventType.UPDATE;
				win.title = title;
				win.agency = selectedAgency;
				PopupMgr.instance.popupWindow(win);
			}
		}
		
		public function onMove(event:ContextMenuEvent):void {
			var node:Node = tree.selectedItem as Node;
			if (!node || !node.entity) {
				return;
			}
			var agencyCodeId:Number = (node.entity as PcAgencyVo).codeId;
			var title:String = AgencyCodeUtil.getAgencyCodeDes(agencyCodeId) + "划转";
			var parentAgency:PcAgencyVo = node.parentNode.entity as PcAgencyVo;
			var selectedAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (selectedAgency) {
				var win:AgencyMoveWindow = new AgencyMoveWindow();
				win.type = CRUDEventType.MOVE;
				win.title = title;
				win.agency = selectedAgency;
				win.parentAgency = parentAgency;
				PopupMgr.instance.popupWindow(win);
			}
		}		

		public function onDelete(event:ContextMenuEvent):void {
			var node:Node = tree.selectedItem as Node;
			if (!node) {
				return;
			}
			var selectedAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (!selectedAgency) {
				return;
			}
			Alert.show("确定要撤销组织【" + selectedAgency.name + "】？", "警告", 
				Alert.YES | Alert.NO, FlexGlobals.topLevelApplication.root, onDeleteAlertClose);
		}
		
		private function onDeleteAlertClose(event:CloseEvent):void {
			var node:Node = tree.selectedItem as Node;
			var selectedAgency:PcAgencyVo = node.entity as PcAgencyVo;
			if (event.detail == Alert.YES) {
				var deleteAgencyEvent:PcAgencyEvent = new PcAgencyEvent(CRUDEventType.DELETE, selectedAgency);
				deleteAgencyEvent.node = node;
				deleteAgencyEvent.successCallback = onDeleteAgencySuccessed;
				deleteAgencyEvent.dispatch();
			}
		}
		
		private function onDeleteAgencySuccessed(data:Object, event:PcAgencyEvent):void {
			tree.dispatchEvent(new TreeOperationEvent(TreeOperationEvent.NODE_CHANGED));;
		}
		
		private function onRevacation(event:ContextMenuEvent):void {
		}
		
	}
}