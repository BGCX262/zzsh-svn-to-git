package com.partycommittee.control.menu {
   import flash.display.DisplayObject;
   
   import mx.containers.HBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.LinkBar;
   import mx.controls.Menu;
   import mx.controls.menuClasses.IMenuDataDescriptor;
   import mx.controls.menuClasses.MenuItemRenderer;

   /**
    * The skin to apply to menu items which are designated as titles.
    */
   [Style(name = "menuTitleSkin", type = "Class", inherited = "yes")]
   
   /**
    * The style name of the text when showing no actions item.
    */
   [Style(name = "noActionsStyleName", type = "String", inherited = "yes")]
   
   public class AdvancedMenuItemRenderer extends MenuItemRenderer {
      private var _titleContainer:HBox;
      private var _titleLabel:Label;
      private var _titleImage:Image;

      /**
       * The data provider type for separators.
       */
      public static const SEPARATOR_TYPE:String = "separator";
      /**
       * The data provider type for menu titles.
       */
      public static const TITLE_TYPE:String = "title";
      /**
       * The data provider type for no-action itme.
       */
      public static const NO_ACTIONS_TYPE:String = "noActions";

      private var _isTitleData:Boolean;
      private var _containsTitleContainer:Boolean;
      /**
       * Constructs a new <code>AdvancedMenuItemRenderer</code>.
       */
      public function AdvancedMenuItemRenderer() {
         super();
      }

      private var _dataIsDirty:Boolean;
      override public function set data(value:Object):void {
         super.data = value;
         _dataIsDirty = true;
         invalidateProperties();
      }

      override protected function commitProperties():void {
         super.commitProperties();

         if (_dataIsDirty && data) {
            var dataDescriptor:IMenuDataDescriptor =
               Menu(listData.owner).dataDescriptor;
            
            var isEnabled:Boolean = dataDescriptor.isEnabled(data);
            var type:String = dataDescriptor.getType(data);
            
            if (type.toLowerCase() == NO_ACTIONS_TYPE.toLowerCase()) {
               label.styleName = getStyle("noActionsStyleName");
            }
            else {
               label.styleName = this.styleName;
            }
            
            _isTitleData = data && TITLE_TYPE == type;
            // The super.commitProperties() call expects icon to be a child of this
            // renderer and will fail if it is not. This hack avoids the error.
            if (icon) {
               addChild(DisplayObject(icon));
            }

            if (_isTitleData) {
               if (!_titleContainer) {
                  createTitleContainer();
               }

               if (branchIcon) {
                  removeChild(DisplayObject(branchIcon));
                  branchIcon = null;
               }

               if (icon) {
                  _titleImage.source = icon;
               }

               if(label) {
                  label.visible = false;
               }

               if (data.label) {
                  _titleLabel.text = data.label;
               }

               addTitleContainer();

            } else {
               removeTitleContainer();
            }

            _dataIsDirty = false;
         }
      }

      /**
       * @inheritDoc
       */
      override protected function measure():void {
         super.measure();

         if (_containsTitleContainer) {
            measuredHeight = Math.max(measuredHeight, _titleContainer ? _titleContainer.measuredHeight : 0);
         }
      }

      /**
       * @inheritDoc
       */
      override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
         super.updateDisplayList(unscaledWidth, unscaledHeight);

         if (_isTitleData && _containsTitleContainer) {
            _titleContainer.setActualSize(unscaledWidth, unscaledHeight);

            var padLeft:Number = _titleContainer.getStyle("paddingLeft");
            var padRight:Number = _titleContainer.getStyle("paddingRight");
            var hGap:Number = _titleContainer.getStyle("horizontalGap");
            var titleTextFieldWidth:Number = _titleContainer.width - _titleImage.width - padLeft - padRight - hGap;
            _titleLabel.setActualSize(titleTextFieldWidth, _titleLabel.getExplicitOrMeasuredHeight());
            _titleLabel.maxWidth = titleTextFieldWidth;
         }

         label.setColor(getStyle("color"));
      }

      protected function removeTitleContainer():void {
         if (_containsTitleContainer) {
            removeChild(_titleContainer);
            _containsTitleContainer = false;
         }
      }

      protected function addTitleContainer():void {
         if (!_containsTitleContainer) {
            addChild(_titleContainer);
            _titleContainer.styleName = "menuTitleSkin";
            _containsTitleContainer = true;
         }
      }

      private function createTitleContainer():void {
         _titleContainer = new HBox();
         _titleContainer.x = 0;
         _titleContainer.y = 0;
         _titleContainer.horizontalScrollPolicy = "off";
         _titleContainer.verticalScrollPolicy = "off";

         _titleImage = new Image();
         _titleContainer.addChild(_titleImage);

         _titleLabel = new Label();
         _titleLabel.truncateToFit = true;
         _titleLabel.minWidth = 0;
         _titleContainer.addChild(_titleLabel);
      }
   }
}