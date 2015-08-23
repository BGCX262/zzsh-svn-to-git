package com.partycommittee.control.datagrid {
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.IFactory;

   public class LabelDataGridColumn extends AdvancedDataGridColumn {
      public function LabelDataGridColumn(columnName:String=null)
      {
         super(columnName);
         this.itemRenderer = new ClassFactory(LabelItemRenderer);
         this.headerRenderer = new ClassFactory(LabelHeaderRenderer);
      }

      override public function set headerRenderer(value:IFactory):void {
         super.headerRenderer = (value == null) ? new ClassFactory(LabelHeaderRenderer) : value;
      }
   }
}