package com.partycommittee.control.tree.classes
{
	import com.partycommittee.control.tree.classes.ErrorNode;
	import com.partycommittee.control.tree.classes.Node;
	import com.partycommittee.vo.PcAgencyVo;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;

   /**
    * For create different types of node.
    */
	public class LoadingTreeNodeFactory
	{
      // Node configuration info.
      private var _nodeConfig:XML;

      private var xmlCollection:ArrayCollection = new ArrayCollection();

      public static const NODE_ELEMENT:String = "node";
      public static const NODE_ELEMENTTYPE:String = "type";
      public static const NODE_TYPE:String = "nodetype";

      // Define node types.
      public static const NODETYPE_AGGREGATE:String = "aggregate";
      public static const NODETYPE_INVENTORY:String = "inventory";
      public static const NODETYPE_LEAF:String = "leaf";

      private var hasInitialized:Boolean = false;

      // Assort all nodes by node type.
      private var _inventoryCollection:ArrayCollection = new ArrayCollection();
      private var _aggregateCollection:ArrayCollection = new ArrayCollection();
      private var _leafCollection:ArrayCollection = new ArrayCollection();

      public function set nodeConfig(value:XML):void {
         this._nodeConfig = value;
         xmlCollection.addItem(_nodeConfig);
         xmlRecursive(_nodeConfig.node);
      }

      public function get nodeConfig():XML {
         return _nodeConfig;
      }

      public function get inventoryCollection():ArrayCollection {
         if (!hasInitialized) {
            if (initNodeTypeCollections()) {
               return _inventoryCollection;
            }
         }
         return _inventoryCollection;
      }

      public function get aggregateCollection():ArrayCollection {
         if (!hasInitialized) {
            if (initNodeTypeCollections()) {
               return _aggregateCollection;
            }
         }
         return _aggregateCollection;
      }

      public function get leafCollection():ArrayCollection {
         if (!hasInitialized) {
            if (initNodeTypeCollections()) {
               return _leafCollection;
            }
         }
         return _leafCollection;
      }

      /**
      * After loading the configuration file, should initialize the arrayCollection sort by node type.
      */
      public function initNodeTypeCollections():Boolean {
         // get all types of nodes
         if (!xmlCollection || !xmlCollection.length) {
            return true;
         }
         var xmlLen:int = xmlCollection.length;
         while (xmlLen--) {
            var type:String = String((xmlCollection.getItemAt(xmlLen) as XML).@type);
            var nodeType:String = String((xmlCollection.getItemAt(xmlLen) as XML).@nodetype);
            switch (nodeType) {
               case NODETYPE_INVENTORY:
                  _inventoryCollection.addItem(type);
                  break;
               case NODETYPE_AGGREGATE:
                  _aggregateCollection.addItem(type);
                  break;
               case NODETYPE_LEAF:
                  _leafCollection.addItem(type);
                  break;
            }
         }
         hasInitialized = true;
         return true;
      }

      /**
      * Check if the node type is exist.
      */
      public function exist(type:String, category:String):Boolean {
         var len:int = xmlCollection.length;
         while (len--) {
            var xml:XML = xmlCollection.getItemAt(len) as XML;
            if (String(xml.@type) == type && String(xml.@nodetype) == category) {
               return true;
            }
         }
         return false;
      }

      /**
      * Get all xml element by recursive.
      */
      private function xmlRecursive(xml:XMLList):void {
         for each (var xmlChildren:XML in xml) {
            xmlCollection.addItem(xmlChildren);
            if (xmlChildren.hasComplexContent()) {
               var xmlList:XMLList = xmlChildren.children();
               xmlRecursive(xmlList);
            }
         }
      }

      /**
      * Get detail node config info by node type.
      */
      private function getNodeXMLFromCollection(type:String):XML {
         if (!xmlCollection || !xmlCollection.length) {
            return null;
         }
         var len:int = xmlCollection.length;
         while (len--) {
            var xmlItem:XML = xmlCollection.getItemAt(len) as XML;
            if (String(xmlItem.@type) == type) {
               return xmlItem;
            }
         }
         return null;
      }

      /**
      * Create the root node.
      */
		public function createTreeRootNode(root:XML, rootType:String, item:Object):Node {
         if (!rootType) {
            return null;
         }
         if (!root) {
            if (!nodeConfig) {
               return null;
            }
            root = nodeConfig;
         }
         switch (rootType) {
            case NODETYPE_INVENTORY:
               return createInventoryNode(item, root.@type, null);
            case NODETYPE_AGGREGATE:
               return createAggregateNode(item, root.@type, null);
         }
			return null;
		}

      /**
      * Create inventory node.
      */
		public function createInventoryNode(item:Object, type:String, parentNode:Node = null):Node {
			if (!(item is PcAgencyVo)) {
				return null;
			}
		    var node:Node = new Node();
			node.type = LoadingTreeNodeFactory.NODETYPE_INVENTORY;
		    if (parentNode) {
		       node.parentNode = parentNode;
		       node.info = parentNode.info;
		    }
		    node.entity = item;
		    node.children = new ArrayCollection();
		    return node;
		}

      /**
      * Create aggregate node.
      */
		public function createAggregateNode(item:Object, type:String, parentNode:Node = null):Node {
         var child:XML = getNodeXMLFromCollection(type);

         if (child) {
            var node:Node = Node.convertXMLToNode(child);
            if (parentNode) {
               node.parentNode = parentNode;
               node.info = parentNode.info;
            }
            var number:Number = 0;
            
            if (item is int) {
               if (int(item) <= 0) {
                  node.children = null;
               }
               else {
                  node.childrenAmout = int(item);
                  node.children = null;
                  node.initialized = false;
               }
            } else {
               if (node.useRollup)
                  node.children = null;
               node.entity = item;
            }
         }

         return node;
		}

      /**
      * Create leaf node.
      */
		public function createLeafNode(item:Object, type:String, parentNode:Node):Node {
			if (!(item is PcAgencyVo)) {
				return null;
			}
			var node:Node = new Node();
			node.type = NODETYPE_LEAF;
			node.entity = item;
			node.parentNode = parentNode;
			node.info = parentNode != null ? parentNode.info : null;
			node.children = null;
			return node;
		}

      /**
      * Create LoadingNode.
      */
      public function createLoadingTreeNode():LoadingNode {
         return new LoadingNode();
      }

      /**
      * Create ErrorNode.
      */
      public function createErrorTreeNode(errorMsg:String):ErrorNode {
         return new ErrorNode(errorMsg);
      }
	}
}
