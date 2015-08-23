package com.partycommittee.control.datagrid {
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   import mx.controls.CheckBox;
   import mx.core.UIComponent;
   import mx.states.State;
   
   [Event(name="selectNone")]
   [Event(name="selectAll")]
   [Event(name="selectPartial")]
   
   public class TriStatesCheckBox extends UIComponent {
      
      public static const SELECT_NONE:String = "selectNone";
      public static const SELECT_ALL:String = "selectAll";
      public static const SELECT_PARTIAL:String = "selectPartial";
      
      public function TriStatesCheckBox() {
         super();
         this.states = [];
         var unchecked:State = new State();
         unchecked.name = SELECT_NONE;
         this.states.push(unchecked);
         var fullyChecked:State = new State();
         fullyChecked.name = SELECT_ALL;
         this.states.push(fullyChecked);
         var partialChecked:State = new State();
         partialChecked.name = SELECT_PARTIAL;
         this.states.push(partialChecked);
         
         this.currentState = SELECT_NONE;
         
         addEventListener(MouseEvent.CLICK, clickHandler);
      }
      
      protected var checkBox:CheckBox;
      protected var partialSelectionMask:Sprite;
      
      override public function set currentState(value:String):void {
         super.currentState = value;
         invalidateProperties();
         invalidateDisplayList();
      }
      
      override protected function createChildren():void {
         super.createChildren();
         if(!checkBox) {
            checkBox = new CheckBox();
            addChild(checkBox);
         }
         if(!partialSelectionMask) {
            partialSelectionMask = new Sprite();
            addChild(partialSelectionMask);
         }
      }
      
      override protected function commitProperties():void {
         super.commitProperties();
         this.checkBox.selected = this.currentState != SELECT_NONE;
         this.checkBox.enabled = this.currentState != SELECT_PARTIAL;
      }
      
      override protected function updateDisplayList(w:Number, h:Number):void {
         super.updateDisplayList(w, h);
         this.checkBox.setActualSize(this.checkBox.getExplicitOrMeasuredWidth(),
                                     this.checkBox.getExplicitOrMeasuredHeight());
         this.checkBox.move(0, 0);
         var g:Graphics = this.partialSelectionMask.graphics;
         g.clear();
         var maskAlpha:Number = 0;
         var maskColor:Number = 0xCCCCCC;
         g.beginFill(maskColor, maskAlpha);
         g.drawRect(0, 0, w, h);
         g.endFill();
      }
      
      private function clickHandler(event:MouseEvent):void {
         switch(this.currentState) {
            case SELECT_NONE:
            case SELECT_PARTIAL:
               currentState = SELECT_ALL;
               break;
            case SELECT_ALL:
               currentState = SELECT_NONE;
               break;
         }
         dispatchEvent(new Event(currentState));
      }
      
      override protected function measure():void {
         super.measure();
         this.measuredWidth = this.checkBox.measuredWidth;
         this.measuredHeight = this.checkBox.measuredHeight;
      }
   }
}
