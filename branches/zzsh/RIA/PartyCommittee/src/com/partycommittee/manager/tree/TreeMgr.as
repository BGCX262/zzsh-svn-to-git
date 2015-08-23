package com.partycommittee.manager.tree
{
	import com.partycommittee.control.tree.classes.LoadingTreeNodeFactory;
	import com.partycommittee.control.tree.classes.Node;
	import com.partycommittee.events.PcAgencyEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.vo.PcAgencyVo;
	
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;

	public class TreeMgr {
		private static var instance:TreeMgr;
		public function TreeMgr() {
			if (instance) {
				throw new Error("TreeMgr is singleton!");
			}
			instance = this;
		}
		
		public static function getInstance():TreeMgr {
			if (instance == null) {
				instance = new TreeMgr();
			}
			return instance;
		}
		
		[Bindable]
		private var model:ModelLocator = ModelLocator.getInstance();
		
		public function initRoot(root:PcAgencyVo):void {
			if (!model.treeCollection) {
				model.treeCollection = new ArrayCollection();
			}
			model.treeCollection.removeAll();
			var rootItem:Node = createItem(root);
			model.treeCollection.addItem(rootItem);
			
			if (root.codeId == PCConst.AGENCY_CODE_TEAM || root.codeId == PCConst.AGENCY_CODE_BRANCH) {
				// Load parent node.
				model.isLeafUser = true;
				var agencyEvt:PcAgencyEvent = new PcAgencyEvent(PcAgencyEvent.GET_PARENT);
				agencyEvt.agency = root;
				agencyEvt.successCallback = onGetParentSuccess;
				agencyEvt.dispatch();
			} else {
				// Load children under root node.
				model.tree.selectedItem = rootItem;
				model.focusAgencyVo = rootItem.entity as PcAgencyVo;
				model.tree.fetchChildrenData(rootItem);
			}
			
			model.isTreeInitialized = true;
		}
		
		private function onGetParentSuccess(data:Object, evt:PcAgencyEvent):void {
			var child:PcAgencyVo = evt.agency;
			model.leafAgency = child;
			var parent:PcAgencyVo = data as PcAgencyVo;
			if (parent) {
				var parentNode:Node = createItem(parent);
				var childNode:Node = createItem(child);
				parentNode.children.addItem(childNode);
				parentNode.initialized = true;
				model.treeCollection = new ArrayCollection();
				model.treeCollection.addItem(parentNode);
				model.tree.validateNow();
				model.tree.expandItem(parentNode, true);
				model.tree.selectedItem = childNode;
				model.tree.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK));
			}
		}
		
		public function createItem(agencyVo:PcAgencyVo):Node {
			if (!agencyVo) {
				return null;
			}
			var node:Node = new Node();
			node.entity = agencyVo;
			node.labelField = "name";
			node.nodeType = LoadingTreeNodeFactory.NODETYPE_INVENTORY;
			node.children = new ArrayCollection();
			return node;
		}
	}
}