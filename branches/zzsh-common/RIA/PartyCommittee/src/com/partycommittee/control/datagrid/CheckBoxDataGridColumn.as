package com.partycommittee.control.datagrid {
   
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.IFactory;
   
   public class CheckBoxDataGridColumn extends AdvancedDataGridColumn {
      public function CheckBoxDataGridColumn(columnName:String=null)
      {
         super(columnName);
         this.itemRenderer = new ClassFactory(CheckBoxItemRenderer);
         this.headerRenderer = new ClassFactory(CheckBoxHeaderRenderer);
         this.sortable = false;
         this.resizable = false;
         this.draggable = false;
         this.width = 24;
      }
      
      override public function set headerRenderer(value:IFactory):void {
         super.headerRenderer = (value == null) ? new ClassFactory(CheckBoxHeaderRenderer) : value;
      }
   }
}
