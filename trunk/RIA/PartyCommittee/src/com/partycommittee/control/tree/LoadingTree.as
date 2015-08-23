package com.partycommittee.control.tree {
   import com.partycommittee.control.menu.AdvancedMenu;
   import com.partycommittee.control.tree.classes.ErrorNode;
   import com.partycommittee.control.tree.classes.LoadingNode;
   import com.partycommittee.control.tree.classes.LoadingTreeNodeFactory;
   import com.partycommittee.control.tree.classes.Node;
   import com.partycommittee.control.tree.classes.TreeOperationEvent;
   import com.partycommittee.events.PcAgencyEvent;
   import com.partycommittee.manager.tree.TreeContextMenuMgr;
   import com.partycommittee.vo.PcAgencyVo;
   
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.controls.ProgressBar;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.controls.listClasses.ListBaseContentHolder;
   import mx.core.FlexGlobals;
   import mx.events.CollectionEvent;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.MenuEvent;
   import mx.events.TreeEvent;
   import mx.logging.ILogger;
   import mx.utils.URLUtil;

   /**
    * It is an extension of AutoSizeTree <- Tree, it support:
    * (1). Every node can be created by dynamically.
    * (2). Can be configured by config file on server, so we can change the menu level or service method by edit the file on server directly.
    * (3). The right click menu can be configured by config file too.
    * (4). Added the loading node when we call for fetching children.
    * (5). Added the error node when we catch any exception from backend, and show the error message at the error node's label.
    * (6). The common refresh method on every node.
    * (7). Can set binding with partical method in partical class(must be a static method).
    * TODO wegao: include privilege limit.
    */
   public class LoadingTree extends AutoSizeTree {
      // Const define. For right click menu.
      public static const MENUCONFIG_NAME:String = "menu";
      public static const MENUCONFIG_ID:String = "id";

      public static const MENUITEM_TYPE_REFRESH:String = "refresh";

      // Create node factory.
      public var nodeFactory:LoadingTreeNodeFactory = new LoadingTreeNodeFactory();

      public var menuData:XML;

      // For display the progress when loading configuration files and add node manually.
      private var loadingBar:ProgressBar;

      /**
      * Constructor
      */
      public function LoadingTree() {
         super();

         doubleClickEnabled = true;

         // Below is default set for loading tree.
         iconFunction = loadingTreeIconFunction;
		 labelFunction = loadingTreeLabelFunction;

         //_menu = createContextMenu();

         // Event listener:
         addEventListener(ListEvent.ITEM_DOUBLE_CLICK, onItemDoubleClick);
         addEventListener(ListEvent.ITEM_CLICK, onSelectedItemChanged);
         addEventListener(FlexEvent.VALUE_COMMIT, onSelectedItemChanged);
         addEventListener(ListEvent.CHANGE, onSelectedItemChanged);

         addEventListener(TreeEvent.ITEM_OPEN, onItemOpen);
//         addEventListener(AdvancedMouseEvent.RIGHT_MOUSE_DOWN, onMenuSelectedHandler);
		 
		 addEventListener(TreeOperationEvent.CHILD_NODE_CHAGNED, onChildNodeChanged);
		 addEventListener(TreeOperationEvent.NODE_CHANGED, onNodeChanged);
      }
	  
	  private function onChildNodeChanged(event:TreeOperationEvent):void {
	  	 var node:Node = this.selectedItem as Node;
		 if (node) {
		 	fetchChildrenData(node);
		 }
	  }
	  
	  private function onNodeChanged(event:TreeOperationEvent):void {
		  var node:Node = this.selectedItem as Node;
		  if (node.parentNode) {
			  fetchChildrenData(node.parentNode);
		  }
	  }

      public function getItemUnderMouse(x:Number, y:Number, items:ArrayCollection):Node {
         for each(var item:* in items) {
            if (!(item is Node)) {
               continue;
            }

            var itemRenderer:IListItemRenderer = itemToItemRenderer(item) as IListItemRenderer;

            if (itemRenderer != null && (itemRenderer as DisplayObject).hitTestPoint(x, y)) {
               return item;
            } else if (item.children != null) {
               var node:Node = getItemUnderMouse(x, y, item.children);
               if (node != null) {
                  return node;
               }
            }
         }

         return null;
      }

      public function getListContent():ListBaseContentHolder {
         return listContent;
      }

      /**
      * On open the selectedItem.
      */
      protected function onItemOpen(event:TreeEvent):void {
         var node:Node = event.item as Node;
         if (node is LoadingNode) {
            return;
         }

         // If the node is not as leaf node, and have not been initialize, just fetch children for this node.
         if (node.nodeType != LoadingTreeNodeFactory.NODETYPE_LEAF && !node.initialized) {
            fetchChildrenData(node);
         }
      }

      /**
      * On click menu item.
      */
      protected function onMenuItemClick(event:MenuEvent):void {
         var item:Object = event.item;
         // Field '@clickEventType' is the dispatch event type which caused by menu item click.
         if (!item.@clickEventType) {
            return;
         }

         // If click event type is common type "refresh", call refresh method to get children.
         if (String(item.@clickEventType) == MENUITEM_TYPE_REFRESH) {
            if (!(selectedItem is Node)) {
               return;
            }
            fetchChildrenData(selectedItem as Node);
            return;
         }
      }

      /**
      * On tree item double click.
      */
      protected function onItemDoubleClick(event:ListEvent):void {
         var node:Node = selectedItem as Node;
         // Just return, if the node type is leaf or the node is LoadingNode/ErrorNode.
         if (!node || node is LoadingNode || node is ErrorNode
            || node.type == LoadingTreeNodeFactory.NODETYPE_LEAF) {
            return;
         }

         if (!node.initialized) {
            // fetch data.
            fetchChildrenData(node);
         } else {
            // set open state.
            expandItem(node, !isItemOpen(node));
         }
      }

      /**
      * On tree selectedItem changed.
      * Should update the menu's dataprovider.
      */
      protected function onSelectedItemChanged(event:Event):void {
      }

      protected function getMenuDp(node:Node):XML {
         for each (var xmlItem:XML in menuConfig.menu) {
            // Must ensure the menuId equals nodeId.
            if (xmlItem.@id == node.type) {
               return xmlItem;
            }
         }
         return null;
      }

      /**
      * Get children of a node.
      */
      public function fetchChildrenData(node:Node, showLoading:Boolean = true):void {
		 if (node.type == LoadingTreeNodeFactory.NODETYPE_LEAF) {
		  	return;
		 }
         // Add LoadingNode.
         if (showLoading) {
            addLoadingStat(node);
         }

         node.initialized = false;
         callRemoteService(node);
      }

	  public var isLoading:Boolean = false; 
      protected function callRemoteService(node:Node):void {
         // Dispatch event for call service.
		 var agencyEvent:PcAgencyEvent = new PcAgencyEvent(PcAgencyEvent.GET_CHILDREN);
		 agencyEvent.node = node;
		 agencyEvent.agency = node.entity as PcAgencyVo;
		 agencyEvent.successCallback = onGetChildrenSuccess;
		 agencyEvent.failureCallback = onGetChildrenFailure;
		 isLoading = true;
		 agencyEvent.dispatch();
      }

      /**
      * Get parentNode by type.
      * Get the parentNode by travelsal the relations of nodes.
      */
      public static function getParentNodeByType(node:Node, type:String):Node {
         if (!node) {
            return null;
         }
         if (node.type == type) {
            return node;
         }
         var tmp:Node = node.clone();
         while (true) {
            if (tmp.parentNode) {
               if (tmp.parentNode.type == type) {
                  return tmp.parentNode;
               }
               tmp = tmp.parentNode;
               continue;
            }
            break;
         }
         return null;
      }

      /**
       * Get children by type.
       * Get the children by travelsal the relations of nodes.
       * Only support one level
       */
      public static function getChildNodeByType(node:Node, type:String):Node {
         if (!node) {
            return null;
         }
         if (node.type == type) {
            return node;
         }
         var tmp:Node = node.clone();
         if (!tmp.children) {
            return null;
         }
         var len:int = tmp.children.length;
         while (len--) {
            var childNode:Node = tmp.children.getItemAt(len) as Node;
            if (!childNode) {
               return null;
            }
            if (childNode.type == type) {
               return childNode;
            }
         }
         return null;
      }

      /**
      * Add ErrorNode.
      */
      private function addErrorStat(node:Node, error:String):void {
         if (!node.children) {
            node.children = new ArrayCollection();
         }
         node.children.removeAll();
         node.children.addItem(new ErrorNode(error));
      }

      /**
      * Add LoadingNode. Then expand the parentNode.
      */
      private function addLoadingStat(node:Node):void {
         if (!node.children) {
            node.children = new ArrayCollection();
         }
         node.children.removeAll();
         node.children.addItem(new LoadingNode());
         node.initialized = false;
         if (!isItemOpen(node)) {
            expandItem(node, true);
         }
      }

      /**
      * Remove the particular stats below a node.
      * Remove the loading stat and error stat.
      */
      protected function removeNodeStat(node:Node):void {
		  if (node.children) {
			  node.children.removeAll();
		  }
      }

      /**
      * LoadingTree Icon Function
      */
      private function loadingTreeIconFunction(item:Object):Class {
         return item.icon;
      }
	  
	  /**
	   * LoadingTree Label Function
	   */
	  private function loadingTreeLabelFunction(item:Object):String {
		  if (item is LoadingNode) {
		  	return "读取中...";
		  } else if (item is ErrorNode) {
		  	return "读取错误！";
		  }
		  var agency:PcAgencyVo = (item as Node).entity as PcAgencyVo;
		  if (!agency) {
		  	return "";
		  }
	  	  return agency.name;
	  }

      /**
       * Right click menu item label Function, use I18N.
       */
      private function menuLabelFunction(item:Object):String {
		  return "";
      }

      /**
       * Right click menu item icon Function, use I18N.
       */
      private function menuIconFunction(item:Object):Class {
         return null;
      }

      /**
      * Loading the configuration files when set the path of files
      */
      override protected function commitProperties():void {
         super.commitProperties();

         if (configChanged && menuChanged) {
            initDataProvider();
            invalidateDisplayList();
         }
      }

      // Loading tree config.
      private var configChanged:Boolean;
      private var _nodeConfig:XML;

      [Bindable]
      public function get nodeConfig():XML {
         return _nodeConfig;
      }

      public function set nodeConfig(value:XML):void {
         if (_nodeConfig != value) {
            _nodeConfig = value;
            configChanged = true;
            invalidateProperties();
         }
      }

      // Right click menu config.
      private var menuChanged:Boolean;
      private var _menuConfig:XML;

      [Bindable]
      public function get menuConfig():XML {
         return _menuConfig;
      }

      public function set menuConfig(value:XML):void {
         if (_menuConfig != value) {
            _menuConfig = value;
            menuChanged = true;
            invalidateProperties();
         }
      }

      public var dataInitialized:Boolean;

      private function initDataProvider():void {
         nodeFactory.nodeConfig = nodeConfig;

         dataProvider = new ArrayCollection();

         dataInitialized = true;
         configChanged = false;
         menuChanged = false;
      }
	  
	  private function onGetChildrenFailure(info:Object, evt:PcAgencyEvent):void {
		  isLoading = false;
		  addErrorStat(evt.node, "读取错误！" + info.message);
	  }
	  
	  private function onGetChildrenSuccess(data:Object, evt:PcAgencyEvent):void {
		  isLoading = false;
		  var parentNode:Node = evt.node;
		  if (!parentNode) {
		  	  return;
		  }
		  
		  // remove loading stats
		  removeNodeStat(parentNode);
		  
		  var children:ArrayCollection = data as ArrayCollection;
		  for each (var item:Object in children) {
			  appendChildren(item, evt.node);
		  }
		  
		  parentNode.initialized = true;
		  expandItem(parentNode, false);
		  expandItem(parentNode, true);
		  
		  (dataProvider as ArrayCollection).dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
	  }
	  
      /**
      * Base on result to append children.
      */
      protected function appendChildren(result:Object, parentNode:Node):void {
		 var agencyVo:PcAgencyVo = result as PcAgencyVo;
		 var node:Node;
		 if (agencyVo.codeId != 13 && agencyVo.codeId != 10) {
			 node = createChild(result, LoadingTreeNodeFactory.NODETYPE_INVENTORY, parentNode);
		 } else {
			 node = createChild(result, LoadingTreeNodeFactory.NODETYPE_LEAF, parentNode);
		 }
		 if (node) {
			 parentNode.children.addItem(node);
			 if (parentNode.entity is PcAgencyVo) {
				 if (!(parentNode.entity as PcAgencyVo).children) {
					 (parentNode.entity as PcAgencyVo).children = new ArrayCollection();
				 }
				 (parentNode.entity as PcAgencyVo).children.addItem(agencyVo);
			 }
		 }
      }

      /**
      * Use node factory to create children.
      */
      public function createChild(item:Object, childType:String, parentNode:Node):Node {
         var node:Node = new Node();
         if (childType == LoadingTreeNodeFactory.NODETYPE_INVENTORY) {
            node = nodeFactory.createInventoryNode(item, childType, parentNode);
         } else {
            node = nodeFactory.createLeafNode(item, childType, parentNode);
         }
         return node;
      }

   }
}
