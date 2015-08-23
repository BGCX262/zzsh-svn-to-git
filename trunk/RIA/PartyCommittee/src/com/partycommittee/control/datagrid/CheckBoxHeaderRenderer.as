package com.partycommittee.control.datagrid {
   
   import com.partycommittee.control.datagrid.TriStatesCheckBox;
   
   import flash.events.Event;
   
   import mx.collections.ICollectionView;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
   import mx.controls.listClasses.BaseListData;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   
   public class CheckBoxHeaderRenderer extends AdvancedDataGridHeaderRenderer {
      public function CheckBoxHeaderRenderer()
      {
         super();
      }
      
      protected var checkBox:TriStatesCheckBox;
      
      private var chkBoxDg:AdvancedDataGrid;
      
      public static const SELECT_CHANGED:String = "selectChanged";
      
      override public function set listData(value:BaseListData):void {
         super.listData = value;
         chkBoxDg = AdvancedDataGrid(value.owner);
         chkBoxDg.addEventListener(ListEvent.ITEM_CLICK, chkBoxDg_selectionChangeHandler);
         chkBoxDg.addEventListener(FlexEvent.VALUE_COMMIT, chkBoxDg_selectionChangeHandler);
      }
      
      override protected function createChildren():void {
         super.createChildren();
         if(label) {
            label.visible = false;
         }
         if(!checkBox) {
            checkBox = new TriStatesCheckBox();
            checkBox.addEventListener(TriStatesCheckBox.SELECT_ALL, checkBox_selectAllHandler);
            checkBox.addEventListener(TriStatesCheckBox.SELECT_NONE, checkBox_selectNoneHandler);
            this.addChild(checkBox);
         }
      }
      
      override protected function measure():void {
         var chkBoxWidth:Number = this.checkBox.measuredWidth;
         var chkBoxHeight:Number = this.checkBox.measuredHeight;
         var paddingLeft:int   = getStyle("paddingLeft");
         var paddingRight:int  = getStyle("paddingRight");
         var paddingTop:int    = getStyle("paddingTop");
         var paddingBottom:int = getStyle("paddingBottom");
         this.measuredWidth = chkBoxWidth + paddingLeft + paddingRight;
         this.measuredHeight = chkBoxHeight + paddingTop + paddingBottom;
      }
      
      override protected function updateDisplayList(w:Number, h:Number):void {
         super.updateDisplayList(w, h);
         var chkBoxWidth:Number = this.checkBox.getExplicitOrMeasuredWidth();
         var chkBoxHeight:Number = this.checkBox.getExplicitOrMeasuredHeight();
         var chkBoxX:Number = (w - chkBoxWidth) / 2;
         var chkBoxY:Number = (h - chkBoxHeight) / 2;
         this.checkBox.setActualSize(chkBoxWidth, chkBoxHeight);
         this.checkBox.move(chkBoxX, chkBoxY);
         
         graphics.clear();
      }
      
      private function chkBoxDg_selectionChangeHandler(event:Event):void {
         if(!chkBoxDg || !chkBoxDg.dataProvider) {
            return;
         }
         var selectedItems:Array = chkBoxDg.selectedItems;
         var dataProviderLength:Number = ICollectionView(chkBoxDg.dataProvider).length;
         if(!selectedItems || selectedItems.length == 0) {
            this.checkBox.currentState = TriStatesCheckBox.SELECT_NONE;
            return;
         }
         if(selectedItems.length == dataProviderLength) {
            this.checkBox.currentState = TriStatesCheckBox.SELECT_ALL;
            return;
         }
         this.checkBox.currentState = TriStatesCheckBox.SELECT_PARTIAL;
      }
      
      private function checkBox_selectAllHandler(event:Event):void {
         var items:Array = [];
         for each(var obj:Object in chkBoxDg.dataProvider) {
            items.push(obj);   
         }
         if (chkBoxDg.dataProvider && ICollectionView(chkBoxDg.dataProvider).length > 0) {
            chkBoxDg.selectedItems = items;
         }
         chkBoxDg.dispatchEvent(new Event(SELECT_CHANGED));
      }
      
      private function checkBox_selectNoneHandler(event:Event):void {
         if (chkBoxDg.dataProvider && ICollectionView(chkBoxDg.dataProvider).length > 0) {
            chkBoxDg.selectedItems = [];
         }
         chkBoxDg.dispatchEvent(new Event(SELECT_CHANGED));
      }
   }
}
