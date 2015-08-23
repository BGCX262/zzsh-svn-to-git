package com.partycommittee.control.datagrid {
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   import mx.controls.AdvancedDataGrid;
   import mx.controls.LinkButton;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   
   public class LinkButtonItemRenderer extends LinkButton 
                                       implements IDropInListItemRenderer, 
                                                  IListItemRenderer {
      public static const LINK_BUTTON_ITEM_CLICK:String = "linkButtonItemClick";

      public function LinkButtonItemRenderer() {
         super();
         setStyle("paddingLeft", 4);
         setStyle("paddingRight", 4);
         setStyle("textAlign", "left");
         setStyle("paddingBottom", 5);
      }

      protected var dataGrid:AdvancedDataGrid;
      protected var column:LinkButtonDataGridColumn;

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
               var dataField:String = _listData.dataField;
               if (data.hasOwnProperty(dataField)) {
                  this.label = data[dataField] as String;
               }

               var colIndex:int = _listData.columnIndex;
               if (dataGrid && colIndex != -1) {
                  column = dataGrid.columns[colIndex] as LinkButtonDataGridColumn;
               }
            }
         }
      }
      
      override protected function clickHandler(event:MouseEvent):void {
         super.clickHandler(event);
         if (column && column.linkClickFunction != null) {
            column.linkClickFunction.call();
         }
         else if (dataGrid) {
            dataGrid.dispatchEvent(new Event(LINK_BUTTON_ITEM_CLICK));
         }
      }
   }
}