package com.partycommittee.manager.tree
{
	import com.partycommittee.control.tree.classes.LoadingTreeNodeFactory;
	import com.partycommittee.control.tree.classes.Node;
	import com.partycommittee.events.PcAgencyEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.vo.PcAgencyVo;
	
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;

	public class TreeHistoryMgr {
		private static var instanceTreeHistoryMgr:TreeHistoryMgr;
		public function TreeHistoryMgr() {
			if (instanceTreeHistoryMgr) {
				throw new Error("TreeHistoryMgr is singleton!");
			}
			instanceTreeHistoryMgr = this;
		}
		
		public static function getInstance():TreeHistoryMgr {
			if (instanceTreeHistoryMgr == null) {
				instanceTreeHistoryMgr = new TreeHistoryMgr();
			}
			return instanceTreeHistoryMgr;
		}
		
		[Bindable]
		private var model:ModelLocator = ModelLocator.getInstance();
		
		public function initRoot(root:PcAgencyVo):void {
			if (!model.treeHistoryCollection) {
				model.treeHistoryCollection = new ArrayCollection();
			}
			model.treeHistoryCollection.removeAll();
			var rootItem:Node = createItem(root);
			model.treeHistoryCollection.addItem(rootItem);

			// Load children under root node.
			model.treeHistory.selectedItem = rootItem;
			model.treeHistory.fetchChildrenData(rootItem);
		
			
			model.isTreeHistoryInitialized = true;
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