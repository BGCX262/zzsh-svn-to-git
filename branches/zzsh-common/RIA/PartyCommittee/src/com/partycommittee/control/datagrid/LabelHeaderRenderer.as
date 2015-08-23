package com.partycommittee.control.datagrid {
   import mx.controls.AdvancedDataGrid;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
   
   public class LabelHeaderRenderer extends AdvancedDataGridHeaderRenderer {
      public function LabelHeaderRenderer() {
         super();
      }
      
      override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
         var grid:AdvancedDataGrid = listData.owner as AdvancedDataGrid;
         if (grid.columns[listData.columnIndex] == null) {
            return ;
         }
         
         var truncate:Boolean = label.truncateToFit();
         if (truncate) {
            label.toolTip = (data as AdvancedDataGridColumn).headerText;
         } else {
            label.toolTip = null;
         }
         
         super.updateDisplayList(unscaledWidth, unscaledHeight);
      }
   }
}
