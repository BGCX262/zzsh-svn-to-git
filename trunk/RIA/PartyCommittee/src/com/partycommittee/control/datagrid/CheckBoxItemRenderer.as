package com.partycommittee.control.datagrid {
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   import mx.controls.AdvancedDataGrid;
   import mx.controls.CheckBox;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.IDataRenderer;
   import mx.core.UIComponent;
   
   public class CheckBoxItemRenderer extends UIComponent 
      implements IDataRenderer, 
      IDropInListItemRenderer, 
      IListItemRenderer, 
      ISelectable {
      public function CheckBoxItemRenderer() {
         super();
      }
      
      private var chkBoxDG:AdvancedDataGrid;
      
      protected var checkBox:CheckBox;
      protected var checkBoxMask:Sprite;
      
      private var _data:Object;
      private var dataChanged:Boolean = false;
      
      public function get data():Object {
         return _data;
      }
      
      public function set data(value:Object):void {
         _data = value;
         dataChanged = true;
         invalidateProperties();
      }
      
      private var _selectable:Boolean = true;
      public function get selectable():Boolean {
         return _selectable;
      }

      public function set selectable(value:Boolean):void {
         _selectable = value;
         invalidateDisplayList();
      }

      
      private var _listData:BaseListData;
      private var listDataChanged:Boolean = false;
      
      public function get listData():BaseListData {
         return _listData;
      }
      
      public function set listData(value:BaseListData):void {
         _listData = value;
         if(_listData) {
            chkBoxDG = AdvancedDataGrid(_listData.owner);
         }
         listDataChanged = true;
         invalidateProperties();
      }
      
      override protected function createChildren():void {
         super.createChildren();
         if(!checkBox) {
            checkBox = new CheckBox();
            if(chkBoxDG) {
               this.checkBox.selected = chkBoxDG.isItemSelected(this.data);               
            }
            addChild(checkBox);
         }
         if(!checkBoxMask) {
            checkBoxMask = new Sprite();
            addChild(checkBoxMask);
         }
      }
      
      override public function validateNow():void {
         super.validateNow();
         if(this.checkBox && chkBoxDG) {
            this.checkBox.selected = chkBoxDG.isItemSelected(this.data);
         }
      }

      override protected function measure():void {
         super.measure();
         this.measuredWidth = this.checkBox.getExplicitOrMeasuredWidth();
         this.measuredHeight = this.checkBox.getExplicitOrMeasuredHeight();
         if (this.chkBoxDG) {
            this.measuredHeight = chkBoxDG.rowHeight;
         }
      }
      
      override protected function commitProperties():void {
         super.commitProperties();
         if(this.checkBox && chkBoxDG) {
            this.checkBox.selected = chkBoxDG.isItemSelected(this.data);
         }
      }
      
      override protected function updateDisplayList(w:Number, h:Number):void {
         super.updateDisplayList(w, h);
         if(this.checkBox && chkBoxDG) {
            this.checkBox.selected = chkBoxDG.isItemSelected(this.data);
         }
         var checkBoxWidth:Number = checkBox.getExplicitOrMeasuredWidth();
         var checkBoxHeight:Number = checkBox.getExplicitOrMeasuredHeight();
         var checkBoxX:Number = (w - checkBoxWidth) / 2;
         var checkBoxY:Number = (h - checkBoxHeight) / 2;
         checkBox.setActualSize(checkBoxWidth, checkBoxHeight);
         checkBox.move(checkBoxX, checkBoxY);
         
         var g:Graphics = checkBoxMask.graphics;
         g.clear();
         var maskAlpha:Number = _selectable ? 0 : 0.6;
         g.beginFill(0xFFFFFF, maskAlpha);
         g.drawRect(0, 0, w, h);
         g.endFill();
      }
   }
}
