package com.partycommittee.control.datagrid {
   import flash.events.Event;

   import mx.controls.AdvancedDataGrid;
   import mx.controls.Label;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;

   public class LabelItemRenderer extends Label 
      implements IDropInListItemRenderer, IListItemRenderer {

      public function LabelItemRenderer() {
         super();
         setStyle("paddingLeft", 4);
         setStyle("paddingRight", 4);
         setStyle("textAlign", "left");
      }

      protected var dataGrid:AdvancedDataGrid;

      private var _listData:AdvancedDataGridListData;
      private var listDataChanged:Boolean = false;
      override public function get listData():BaseListData {
         return _listData;
      }
      override public function set listData(value:BaseListData):void {
         super.listData = value;
         _listData = value as AdvancedDataGridListData;
         if (_listData && _listData.owner) {
            dataGrid = _listData.owner as AdvancedDataGrid;
         }
         invalidateProperties();
      }

      private var dataChanged:Boolean = false;
      override public function set data(value:Object):void {
         super.data = value;
         dataChanged = true;
         invalidateProperties();
      }

      override protected function commitProperties():void {
         super.commitProperties();
         if (dataChanged || listDataChanged) {
            if (data && _listData) {
               this.text = _listData.label;
            }
         }
      }
   }
}
