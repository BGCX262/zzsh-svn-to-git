package com.partycommittee.control.menu {
   import flash.events.Event;

   public class EntityMenuItem extends MenuItem {
      public function EntityMenuItem() {
         super();
      }
      
      private var _entityPrivilege:String;
      [Bindable("entityPrivilegeChange")]
      public function get entityPrivilege():String {
         return _entityPrivilege;
      }

      public function set entityPrivilege(value:String):void {
         _entityPrivilege = value;
         dispatchEvent(new Event("entityPrivilegeChange"));
      }

      
   }
}