package com.partycommittee.control.datagrid {
   import mx.controls.AdvancedDataGrid;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.ClassFactory;
   import mx.core.IFactory;
   import mx.core.mx_internal;
   
   [Event(name="selectChanged", type="flash.events.Event")]
   
   public class CheckBoxAdvancedDataGrid extends AdvancedDataGrid {
      public function CheckBoxAdvancedDataGrid() {
         this.allowMultipleSelection = true;
         super();
      }
      
      private var _userColumns:Array;

      private var _checkBoxHeaderItemRenderer:IFactory;
      /**
       *  The class factory that will be used to create the header of checkbox column.
       */
      public function get checkBoxHeaderItemRenderer():IFactory {
         return _checkBoxHeaderItemRenderer;
      }
      public function set checkBoxHeaderItemRenderer(value:IFactory):void {
         _checkBoxHeaderItemRenderer = value;
         this.columns = _userColumns;
      }

      public var headerCheckBoxEnabled:Boolean = true;
      /**
       *  The <code>get columns()</code> method will be used in AdvancedDataGrid to do
       *  the layout related calculation, override it will break its inertal machanism.
       *  To avoid this, we provide a new method to return all the columns except the
       *  checkbox column.
       *  
       */
      public function get userColumns():Array {
         return _userColumns;
      }
      
      /**
       *  To make this CheckBoxAdvancedDataGrid more easy to use, we provide an internal
       *  <code>CheckBoxDataGridColumn</code> and added into the <code>columns</code> user
       *  already provided.
       */
      
      override public function set columns(value:Array):void {
         _userColumns = value;
         var columns:Array = value.concat();
         var chkBoxClmn:CheckBoxDataGridColumn = new CheckBoxDataGridColumn();
         chkBoxClmn.headerRenderer = checkBoxHeaderItemRenderer;
         columns.splice(0, 0, chkBoxClmn);
         super.columns = columns;
      }
      
      /**
       *  To make the selection more convenient, we allow user to make multi-selection
       *  without holding the CTRL key.
       */
      override protected function selectItem(item:IListItemRenderer, 
                                             shiftKey:Boolean, 
                                             ctrlKey:Boolean, 
                                             transition:Boolean=true):Boolean {
         return super.selectItem(item, shiftKey, true, transition);
      }
      
      /**
       *  Since we've had a checkbox column to indicate the items selection, we won't
       *  need to draw the selection highlight anymore.
       */
      override protected function drawItem(item:IListItemRenderer, 
                                           selected:Boolean=false, 
                                           highlighted:Boolean=false, 
                                           caret:Boolean=false, 
                                           transition:Boolean=false):void {
         super.drawItem(item, false, highlighted, caret, transition);
      }
   }
}
