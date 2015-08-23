package com.partycommittee.control.tree.classes
{
   import flash.events.EventDispatcher;
   import flash.utils.getDefinitionByName;
   
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;

   /**
    * The node always as an item in LoadingTree.
    */
   [Bindable]
   public class Node extends EventDispatcher
   {
	   // check box selected
	   private var _ckSelected:Boolean;
	   public function set ckSelected(value:Boolean):void {
	       this._ckSelected = value;
	   }
	   public function get ckSelected():Boolean {
	   	   return this._ckSelected;
	   }
	   
      // Node type.
      private var _type:String;

      // Parent node type.
      private var _parentNode:Node;

      // If has const label.
      private var _hasConstLabel:Boolean = true;

      // Const lable.
      private var _constLabel:String;

      // Use labelField to display label.
      private var _labelField:String;

      // Icon class on tree's item.
      private var _icon:Class;

      // If the node is (inventory/aggregate/leaf)
      private var _nodeType:String;

      // If has entity type limit.
      private var _hasEntityType:Boolean = true;

      // Entity type.
      private var _entityType:String;

      // Entity object.
      private var _entity:Object;

      // Call dataservice to get children.
      private var _dataService:String;

      // The types of all children. Splice by ','.
      private var _childrenTypes:Array;

      // Children under the node.
      private var _children:ArrayCollection;

      // Pending children node for aggregation node which will not display in tree
      private var _pendingChildren:ArrayCollection;

      // If has been initialize. If have get children.
      private var _initialized:Boolean = false;

      // Whether could refresh.
      private var _enableRefresh:Boolean = true;

      // The amount of children.
      private var _childrenAmout:int = 0;

      // Can bring some other paticular info here.
      private var _info:Object = new Object();

      // Whether has contextMenu.
      private var _hasContextMenu:Boolean = true;

      // The info of contextMenu.
      private var _contextMenu:String;

      // Whether have navView.
      private var _hasNavView:Boolean;

      // navView.
      private var _navView:String;

      // Bind properties, splice by ',' in different properties.
      private var _bindProperties:Array;

      // Bind object. Singleton class.
      private var _bindObjCla:Class;

      // Bind object. Instance of class.
      private var _bindObj:EventDispatcher;

      // Bind method in which class.
      private var _bindExcClass:Class;

      // Bind method, should be a static method.
      private var _bindExcMethod:String;

      // Rollup flag
      private var _useRollup:Boolean;

      /**
      * Setting and getting methods.
      */
      public function set type(value:String):void {
         this._type = value;
      }

      public function get type():String {
         return this._type;
      }

      public function get parentNode():Node {
         return this._parentNode;
      }

      public function set parentNode(value:Node):void {
         this._parentNode = value;
      }

      public function get hasConstLabel():Boolean {
         return this._hasConstLabel && this._hasConstLabel != "";
      }

      public function set constLabel(value:String):void {
         this._constLabel = value;
      }

      public function get constLabel():String {
         return this._constLabel;
      }

      public function get name():String {
         return entity != null ? entity[labelField] : "";
      }

      public function set labelField(value:String):void {
         this._labelField = value;
      }

      public function get labelField():String {
         return this._labelField;
      }

      public function set initialized(value:Boolean):void {
         this._initialized = value;
      }

      public function get initialized():Boolean {
         return this._initialized;
      }

      public function set childrenAmout(value:int):void {
         this._childrenAmout = value;
      }

      public function get childrenAmout():int {
         return this._childrenAmout;
      }

      public function set nodeType(value:String):void {
         this._nodeType = value;
      }

      public function get nodeType():String {
         return this._nodeType;
      }

      public function get hasEntityType():Boolean {
         return this._entityType && this._entityType != "";
      }

      public function set entityType(value:String):void {
         this._entityType = value;
      }

      public function get entityType():String {
         return this._entityType;
      }

      public function set childrenTypes(value:Array):void {
         this._childrenTypes = value;
      }

      public function get childrenTypes():Array {
         return this._childrenTypes;
      }

      public function set entity(value:Object):void {
         this._entity = value;
      }

      public function get entity():Object {
         return this._entity;
      }

      public function set dataService(value:String):void {
         this._dataService = value;
      }

      public function get dataService():String {
         return this._dataService;
      }

      public function set children(value:ArrayCollection):void {
         this._children = value;
      }

      public function get children():ArrayCollection {
         return this._children;
      }

      public function set pendingChildren(value:ArrayCollection):void {
         this._pendingChildren = value;
      }

      public function get pendingChildren():ArrayCollection {
         return this._pendingChildren;
      }

      public function set enableRefresh(value:Boolean):void {
         this._enableRefresh = value;
      }

      public function get enableRefresh():Boolean {
         return this._enableRefresh;
      }

      public function set icon(value:Class):void {
         this._icon = value;
      }

      [Transient]
      public function get icon():Class {
         return this._icon;
      }

      public function set info(value:Object):void {
         this._info = value;
      }

      public function get info():Object {
         return this._info;
      }

      public function get hasContextMenu():Boolean {
         return this._contextMenu && this._contextMenu != "";
      }

      public function set contextMenu(value:String):void {
         this._contextMenu = value;
      }

      public function get contextMenu():String {
         return this._contextMenu;
      }

      public function get hasNavView():Boolean {
         return this._navView && this._navView != "";
      }

      public function set navView(value:String):void {
         this._navView = value;
      }

      public function get navView():String {
         return this._navView;
      }

      public function set bindProperties(value:Array):void {
         this._bindProperties = value;
      }

      public function get bindProperties():Array {
         return this._bindProperties;
      }

      public function set bindObj(value:EventDispatcher):void {
         this._bindObj = value;
         // Add eventlistener for PropertyChangeEvent.PROPERTY_CHANGE.
         _bindObj.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onBindObjectChanged);
      }

      public function get bindObj():EventDispatcher {
         return _bindObj;
      }

      public function set bindObjCla(value:Class):void {
         this._bindObjCla = value;
         if (_bindObjCla) {
            // The bind object must be a class extends EventDispatcher.
            bindObj = _bindObjCla["getInstance"].call() as EventDispatcher;
         }
      }

      public function get bindObjCla():Class {
         return this._bindObjCla;
      }

      public function set bindExcClass(value:Class):void {
         this._bindExcClass = value;
      }

      public function get bindExcClass():Class {
         return this._bindExcClass;
      }

      public function set bindExcMethod(value:String):void {
         this._bindExcMethod = value;
      }

      public function get bindExcMethod():String {
         return this._bindExcMethod;
      }

      public function set useRollup(value:Boolean):void {
         this._useRollup = value;
      }

      public function get useRollup():Boolean {
         return this._useRollup;
      }

      public function get path():String {
         var currentPath:String = type;
         if (entity) {
            if (entity.hasOwnProperty("id")) {
               currentPath += entity["id"];
            }
            else if (entity.hasOwnProperty("name")) {
               currentPath += entity["name"];
            }
            //For table entity
            else if (entity.hasOwnProperty("strTablename")) {
               currentPath += entity["strTablename"];
            }
            else {
               currentPath += entity.toString();
            }
         }
         if (parentNode) {
            return parentNode.path + currentPath;
         }
         return currentPath;
      }

      public static function convertXMLToNode(obj:XML):Node {
         var node:Node = new Node();
         node.type = obj.@type;
         node.initialized = String(obj.@init) == "true";
         node.constLabel = obj.@constlabel;
         node.labelField = obj.@labelfield;
         node.nodeType = obj.@nodetype;
         node.entityType = obj.@entitytype;
         node.dataService = obj.@dataservice;
         node.childrenTypes = String(obj.@childtypes).split(",");
         node.enableRefresh = obj.@enablerefresh;
         node.contextMenu = obj.@contextMenu;
         node.navView = obj.@navview;
         node.info = obj.@info;
         node.useRollup = obj.hasOwnProperty("@userollup") ? obj.@userollup : false;

         // For the relationship
         if (!obj.hasOwnProperty("@bindobject") || !obj.hasOwnProperty("@bindproperties") || !obj.hasOwnProperty("@bindfunction")) {
            return node;
         }

         //Make sure the bindProperties set is before bindObjCla
         node.bindProperties = String(obj.@bindproperties).split(",");

         var isBindObjSingleton:Boolean = false;
         if (obj.hasOwnProperty("@isSingleton") && String(obj.@isSingleton) == "true") {
            isBindObjSingleton = true;
         }
         if (obj.hasOwnProperty("@bindobject")) {
            if (isBindObjSingleton) {
               node.bindObjCla = getDefinitionByName(String(obj.@bindobject)) as Class;
            }
         }

         // The bind method's class and bind method should be splice with ':'.
         var bindExcClassStr:String = String(obj.@bindfunction).split(":")[0];
         var obj1:Object = getDefinitionByName(bindExcClassStr);
         node.bindExcClass = getDefinitionByName(bindExcClassStr) as Class;
         node.bindExcMethod = String(obj.@bindfunction).split(":")[1];

         return node;
      }

      /**
      * If the binding object's property changed, call the binding function.
      */
      private function onBindObjectChanged(event:PropertyChangeEvent):void {
         if (bindProperties.indexOf(event.property) != -1) {
            if (!bindExcClass || !bindExcMethod || bindExcMethod == "") {
               return;
            }
            bindExcClass[bindExcMethod].call(null, this, event.target[event.property], event.property);
         }
      }

      /**
      * For clone.
      */
      public function clone():Node {
         var node:Node = new Node();
         node._children = this._children;
         node._childrenAmout = this._childrenAmout;
         node._childrenTypes = this._childrenTypes;
         node._constLabel = this._constLabel;
         node._contextMenu = this._contextMenu;
         node._dataService = this._dataService;
         node._enableRefresh = this._enableRefresh;
         node._entity = this._entity;
         node._entityType = this._entityType;
         node._hasConstLabel = this._hasConstLabel;
         node._hasContextMenu = this._hasContextMenu;
         node._hasEntityType = this._hasEntityType;
         node._hasNavView = this._hasNavView;
         node._icon = this._icon;
         node._info = this._info;
         node._initialized = this._initialized;
         node._labelField = this._labelField;
         node._navView = this._navView;
         node._nodeType = this._nodeType;
         node._parentNode = this._parentNode;
         node._type = this._type;
         return node;
      }
   }
}
