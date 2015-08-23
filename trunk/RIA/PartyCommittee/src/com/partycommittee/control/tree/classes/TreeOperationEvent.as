package com.partycommittee.control.tree.classes {
   import flash.events.Event;
   
   import mx.collections.ArrayCollection;

   public class TreeOperationEvent extends Event {
	  public static const NODE_CHANGED:String = "nodeChanged";
	  public static const CHILD_NODE_CHAGNED:String = "childNodeChanged";
	  
      public static const ADD_NODE:String = "addNode";
      public static const AGGREGATION_NODES:String = "aggregationNodes";
      public static const DELETE_NODE:String = "deleteNode";
      public static const REQUEST_INFO:String = "requestInfo";

      private var _item:Object;
      private var _parentNode:Node;
      private var _nodeType:String;
	  
	  private var _nodes:ArrayCollection;
	  public function get nodes():ArrayCollection {
	  	 return this._nodes;
	  }
	  public function set nodes(value:ArrayCollection):void {
	  	 this._nodes = value;
	  }

      public function get item():Object {
         return _item;
      }

      public function get parentNode():Node {
         return _parentNode;
      }

      public function get nodeType():String {
         return _nodeType;
      }

      public function TreeOperationEvent(type:String, item:Object = null, nodeType:String = null, parentNode:Node = null) {
         super(type, bubbles, cancelable);
         this._item = item;
         this._nodeType = nodeType;
         this._parentNode = parentNode;
      }
   }
}
