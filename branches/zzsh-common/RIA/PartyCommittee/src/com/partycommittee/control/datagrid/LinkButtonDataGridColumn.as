package com.partycommittee.control.datagrid {
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.core.ClassFactory;
   
   public class LinkButtonDataGridColumn extends AdvancedDataGridColumn {
      public function LinkButtonDataGridColumn(columnName:String=null) {
         super(columnName);
         this.itemRenderer = new ClassFactory(LinkButtonItemRenderer);
      }

      public var linkClickFunction:Function;
   }
}