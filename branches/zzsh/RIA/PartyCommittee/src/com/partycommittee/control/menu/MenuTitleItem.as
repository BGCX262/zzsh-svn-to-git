package com.partycommittee.control.menu {
   import flash.events.Event;
   import flash.events.EventDispatcher;

   [Manifest("cx-manifest")]
   
   public class MenuTitleItem extends MenuItem {

      private var _gridName:String;
      private var _numberSelected:int;
      private var _getObjNameFunction:Function = null;

      public function MenuTitleItem() {
         type = "title"
         super();
      }

      [Bindable("labelChanged")]
      public override function get label():String {
         if (super.label != null) {
            return super.label;
         }
      }

      public function set gridName(value:String):void {
         if (_gridName == value) {
            return;
         }
         _gridName = value;
         dispatchEvent(new Event("labelChanged"));
      }

      public function set numberSelected(value:int):void {
         if (_numberSelected == value) {
            return;
         }
         _numberSelected = value;
         dispatchEvent(new Event("labelChanged"));
      }

      [Bindable("getObjNameFunctionChanged")]
      public function get getObjNameFunction():Function {
         return _getObjNameFunction;
      }
      public function set getObjNameFunction(value:Function):void {
         if (_getObjNameFunction == value) {
            return;
         }
         _getObjNameFunction = value;
         dispatchEvent(new Event("getObjNameFunctionChanged"));
      }

   }
}