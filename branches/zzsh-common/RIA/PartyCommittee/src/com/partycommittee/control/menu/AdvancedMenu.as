package com.partycommittee.control.menu {

   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mx.controls.IFlexContextMenu;
   import mx.controls.Menu;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.ClassFactory;
   import mx.core.FlexGlobals;
   import mx.core.UIComponent;
   import mx.events.InterManagerRequest;
   import mx.managers.ISystemManager;
   import mx.managers.IToolTipManagerClient;
   import mx.validators.IValidatorListener;

   [AccessibilityClass(implementation = "mx.accessibility.MenuAccImpl")]

   /**
    * The color of the separator line.
    *
    * @default 0x000000
    */
   [Style(name="separatorColor", type="uint", format="Color", inherit="yes")]

   /**
    * The thickness of the separator line.
    *
    * @default 1
    */
   [Style(name="separatorThickness", type="Number", format="Length", inherit="yes")]

   /**
    * The skin to apply to menu items which are designated as titles.
    *
    * @default menuTitleSkin
    */
   [Style(name = "menuTitleSkin", type = "Class", inherit = "no")]
   /**
    * The minimum height of a non-separator menu item.
    *
    * @default 10
    */
   [Style(name = "minRowHeight", type = "Number", inherit = "no")]
   /**
    * A <code>Menu</code> which supports data tips and error strings on menu
    * items. It also enables menu titles for data provider items which have
    * type "title". The <code>AdvancedMenu</code> also supports MXML
    * declarations in addition to supporting the <code>createMenu()</code> and
    * <code>popUpMenu</code> calls for the instantiation style used by
    * <code>Menu</code>.
    *
    * <p>
    * In addition to the display features of the <code>AdvancedMenu</code>, it
    * also implements <code>IFlexContextMenu</code>, allowing it to be
    * declaratively attached to a <code>UIComponent</code> as a context menu
    * using the <code>UIComponent#flexContextMenu</code> property. When
    * attached as a context menu, the menu will be displayed when a right-click
    * event is detected on the component. The <code>MouseEvent</code>'s default
    * behavior will also be canceled. The menu will also be displayed when
    * the menu key on Windows keyboards is pressed. This behavior does not
    * function in Internet Explorer since the menu key cannot be captured in
    * that browser.
    * </p>
    *
    * <p>
    * It is also possible to declare a <code>AdvancedMenu</code> instance in
    * MXML. In order to do this, the declaration must not insert the
    * <code>AdvancedMenu</code> into the <code>DisplayObject</code> hierarchy.
    * To keep it out of the hierarchy, you can wrap the
    * <code>AdvancedMenu</code> in a non-visual component.
    * </p>
    *
    * @example An example of how to declare an <code>AdvancdMenu</code> in MXML
    *          by wrapping it in a <code>Declarations</code> declaration.
    * <listing version="3.0">
    * &lt;vx:Declarations&gt;
    *     &lt;vx:AdvancedMenu id="menu" dataProvider="{data}" /&gt;
    * &lt;/vx:Declarations&gt;
    * </listing>
    *
    * @see http://opengrok.eng.vmware.com/source/xref/cloud-main/ui/ssui/ui-common-lib/src/main/flex/com/vmware/vcloud/controls/AdvancedMenu.as
    */
   public class AdvancedMenu extends Menu implements IFlexContextMenu {
      /**
       * The key-code for the menu key.
       *
       * @private
       */
      private static const MENU_KEY_CODE:int = 93;

      /**
       * The name of the field on each data item which stores the error string
       * for that item.
       *
       * @private
       */
      private var _errorStringField:String = "errorString";
      /**
       * A function to which each data item will be passed and which will
       * return the error string for that item.
       *
       * @private
       */
      private var _errorStringFunction:Function;
      /**
       * Indicates whether error strings will be displayed for items in this
       * <code>AdvancedMenu</code>.
       *
       * @private
       */
      private var _showErrorStrings:Boolean;

      /**
       * Constructs a new <code>AdvancedMenu</code> instance.
       */
      public function AdvancedMenu() {
         super();
         itemRenderer = new ClassFactory(AdvancedMenuItemRenderer);
         variableRowHeight = true;
         popUpMenu(this, DisplayObjectContainer(FlexGlobals.topLevelApplication), null);
      }

      /**
       * @inheritDoc
       */
      override public function createItemRenderer(data:Object):IListItemRenderer {
         var renderer:IListItemRenderer = super.createItemRenderer(data);
         if (renderer is IToolTipManagerClient && showDataTips && dataDescriptor.getType(data) != AdvancedMenuItemRenderer.SEPARATOR_TYPE) {
            IToolTipManagerClient(renderer).toolTip = itemToDataTip(data);
         }
         if (renderer is IValidatorListener && showErrorStrings) {
            IValidatorListener(renderer).errorString = itemToErrorString(data);
         }
         return renderer;
      }

      /**
       * Creates and returns an instance of the <code>AdvancedMenu</code>
       * class. The <code>AdvancedMenu</code> control's contents are
       * determined by the <code>mdp</code> argument. The
       * <code>AdvancedMenu</code> is placed in the parent container specified
       * with the <code>parent</code> argument.
       *
       * @param parent A container that the <code>PopUpManager</code> uses to
       *               place the <code>AdvancedMenu</code> in.
       * @param mdp The data provider for the <code>AdvancedMenu</code>
       *            control.
       * @param showRoot A <code>Boolean</code> flag which specifies whether
       *                 to display the root node of the data provider.
       *
       * @return An instance of the <code>AdvancedMenu</code> class.
       *
       * @see com.vmware.vcloud.common.controls.AdvancedMenu#popUpMenu()
       */
      public static function createMenu(parent:DisplayObjectContainer, mdp:Object, showRoot:Boolean = true):AdvancedMenu {
         var menu:AdvancedMenu = new AdvancedMenu();
         menu.tabEnabled = false;
         menu.owner = DisplayObjectContainer(FlexGlobals.topLevelApplication);
         menu.showRoot = showRoot;
         popUpMenu(menu, parent, mdp);
         return menu;
      }

      /**
       * Handles the pressing of the menu key on an associated component. If
       * the menu is attached to a <code>DisplayObject</code> it will display
       * the menu at the upper-left corner of that object. If the event
       * handler is attached to something else, it will default to the
       * upper-left corner of the application.
       *
       * @param event The <code>KeyboardEvent</code> with information on the
       *              key press.
       */
      private function handleMenuKey(event:KeyboardEvent):void {
         if (event.keyCode == MENU_KEY_CODE && !event.isDefaultPrevented()) {
            var displayCoordinates:Point;
            if (event.currentTarget is DisplayObject) {
               displayCoordinates = DisplayObject(event.currentTarget).localToGlobal(new Point(0, 0));
            } else {
               displayCoordinates = new Point(0, 0);
            }
            show(displayCoordinates.x, displayCoordinates.y);
            event.preventDefault();
         }
      }

      /**
       * Handles the right-click event on an associated component.
       *
       * @param event The <code>MouseEvent</code> with information on the
       *              right-click.
       *
       * @private
       */
      private function handleTargetClicked(event:MouseEvent):void {
         if (!event.isDefaultPrevented()) {
            var mouseCoordinates:Point = new Point(event.localX, event.localY);
            mouseCoordinates = DisplayObject(event.target).localToGlobal(mouseCoordinates);
            show(mouseCoordinates.x, mouseCoordinates.y);
            event.preventDefault();
         }
      }

      /**
       * Retrieves the error string for a specified data object.
       *
       * @param data The data object for which to retrieve the error string.
       *
       * @return The error string for <code>data</code>.
       */
      protected function itemToErrorString(data:Object):String {
         if (!data) {
            return "";
         }
         if (errorStringFunction != null) {
            return errorStringFunction(data);
         }
         if (data is XML) {
            try {
               if (data[errorStringField].length() != 0) {
                  return data[errorStringField];
               }
            } catch(e:Error) {
            }
         } else if (data is Object) {
            try {
               if (data[errorStringField]) {
                  return data[errorStringField];
               }
            } catch(e:Error) {
            }
         }
         return "";
      }

      /**
       * @inheritDoc
       */
      override protected function mouseEventToItemRenderer(event:MouseEvent):IListItemRenderer {
         var row:IListItemRenderer = super.mouseEventToItemRenderer(event);
         if (row && dataDescriptor.getType(row.data) == AdvancedMenuItemRenderer.TITLE_TYPE) {
            return null;
         } else {
            return row;
         }
      }

      /**
       * Sets the data provider and parent of an existing
       * <code>AdvancedMenu</code>.
       *
       * @param menu The <code>AdvancedMenu</code> control to popup.
       * @param parent A container that the <code>PopUpManager</code> uses to
       *               place the <code>AdvancedMenu</code> in.
       * @param mdp The data provider for the <code>AdvancedMenu</code>
       *            control.
       */
      public static function popUpMenu(menu:AdvancedMenu, parent:DisplayObjectContainer, mdp:Object):void {
         Menu.popUpMenu(menu, parent, mdp);
      }

      /**
       * @inheritDoc
       */
      public function setContextMenu(component:InteractiveObject):void {
//         if (component) {
//            component.addEventListener(AdvancedMouseEvent.RIGHT_MOUSE_DOWN, handleTargetClicked, false, -1, true);
//            component.addEventListener(KeyboardEvent.KEY_DOWN, handleMenuKey, false, -1, true);
//         }
      }

      /**
       * @inheritDoc
       */
      public function unsetContextMenu(component:InteractiveObject):void {
//         if (component) {
//            component.removeEventListener(AdvancedMouseEvent.RIGHT_MOUSE_DOWN, handleTargetClicked);
//            component.removeEventListener(KeyboardEvent.KEY_DOWN, handleMenuKey);
//         }
      }

      [Bindable("errorStringFieldChanged")]
      [Inspectable(category = "Data", defaultValue = "errorString")]
      /**
       * The name of the field on each data item which stores the error string
       * for that item.
       *
       * @default "errorString"
       */
      public function get errorStringField():String {
         return _errorStringField;
      }

      /**
       * @private
       */
      public function set errorStringField(value:String):void {
         if (_errorStringField != value) {
            _errorStringField = value;
            dispatchEvent(new Event("errorStringFieldChanged"));
            invalidateProperties();
         }
      }

      [Bindable("errorStringFunctionChanged")]
      [Inspectable(category = "Data")]
      /**
       * A function to which each data item will be passed and which will
       * return the error string for that item.
       *
       * @default undefined
       */
      public function get errorStringFunction():Function {
         return _errorStringFunction;
      }

      /**
       * @private
       */
      public function set errorStringFunction(value:Function):void {
         if (_errorStringFunction != value) {
            _errorStringFunction = value;
            dispatchEvent(new Event("errorStringFunctionChanged"));
            invalidateProperties();
         }
      }

      [Bindable("showErrorStringsChanged")]
      [Inspectable(category = "Data", defaultValue = "false")]
      /**
       * Indicates whether error strings will be displayed for items in this
       * <code>AdvancedMenu</code>.
       *
       * @default false
       */
      public function get showErrorStrings():Boolean {
         return _showErrorStrings;
      }

      /**
       * @private
       */
      public function set showErrorStrings(value:Boolean):void {
         if (_showErrorStrings != value) {
            _showErrorStrings = value;
            dispatchEvent(new Event("showErrorStringsChanged"));
            invalidateProperties();
         }
      }

      override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
         super.updateDisplayList(unscaledWidth, unscaledHeight);

         var newXY:Point = getPointToPreventCutOff(x, y, width, height, this);
         move(newXY.x, newXY.y);
      }

      private static function getPointToPreventCutOff(
            currX:Number, currY:Number, w:Number, h:Number, window:UIComponent,
            screenPaddingLeft:Number = 5, screenPaddingRight:Number = 5,
            screenPaddingTop:Number = 5, screenPaddingBottom:Number = 5):Point {

            var newXY:Point = new Point(currX, currY);
            if (!window) {
               return newXY;
            }

            //reset y if the menu will go below the application bottom and will not be visible
            var showAtX:Number = isNaN(newXY.x) ? 0 : newXY.x;
            var showAtY:Number = isNaN(newXY.y) ? 0 : newXY.y;

            //get the topLevel systemManager
            var sm:ISystemManager = window.systemManager.topLevelSystemManager;
            var sbRoot:DisplayObject = sm.getSandboxRoot();
            var interManagerScreenRect:Rectangle;

            //if the top level systemManagers are not the same then we will ask the
            //sbRoot to give its screen rectangle details
            if (sm !== sbRoot) {
               var interSMRequest:InterManagerRequest = new InterManagerRequest(
                  InterManagerRequest.SYSTEM_MANAGER_REQUEST,
                  false, false,
                  "getVisibleApplicationRect"
               );
               sbRoot.dispatchEvent(interSMRequest);
               interManagerScreenRect = Rectangle(interSMRequest.value);
            } else {
               interManagerScreenRect = sm.getVisibleApplicationRect();
            }

            //some math to decide what the new y should be
            var yMore:Number = showAtY + h - (interManagerScreenRect.bottom - screenPaddingTop);
            if (yMore > 0) {
               showAtY = showAtY - yMore;
               showAtY = showAtY < screenPaddingTop ? screenPaddingTop : showAtY;
            }
            newXY.y = showAtY;

            //some math to decide what the new x should be
            var xMore:Number = showAtX + w - (interManagerScreenRect.right - screenPaddingRight);
            if (xMore > 0) {
               showAtX = showAtX - xMore;
               showAtX = showAtX < screenPaddingLeft ? screenPaddingLeft : showAtX;
            }
            newXY.x = showAtX;

            return newXY;
         }

   }
}