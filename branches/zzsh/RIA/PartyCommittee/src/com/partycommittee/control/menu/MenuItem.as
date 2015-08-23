package com.partycommittee.control.menu {
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mx.collections.ArrayList;
    import mx.collections.IList;

    public class MenuItem extends EventDispatcher {
        private var _label:String = null;
        private var _width:Number;
        private var _clickFunction:Function = null;
        private var _clickEventType:String;
        private var _enabled:Boolean = true;
        private var _enableFunction:Function = null;
        private var _visible:Boolean = true;
        private var _type:String;
        private var _icon:Class;
        private var _disableIcon:Class;
        private var _toggled:Boolean;
        private var _groupName:String;
        private var _privilege:String;
        private var _data:Object;
        private var _isDefault:Boolean = false;
        private var _children:Array = null;

        public function MenuItem() {
            super();
        }

        [Bindable("isDefaultChanged")]
        public function get isDefault():Boolean {
            return _isDefault;
        }
        public function set isDefault(value:Boolean):void {
            if (_isDefault != value) {
                _isDefault = value;
                dispatchEvent(new Event("isDefaultChanged"));
            }
        }

        [Bindable("labelChanged")]
        public function get label():String {
            return _label;
        }
        public function set label(value:String):void {
            if (_label == value) {
                return;
            }
            _label = value;
            dispatchEvent(new Event("labelChanged"));
        }


        [Bindable("menuWidthChanged")]
        public function get width():Number {
           return _width;
        }
        public function set width(value:Number):void {
           if (_width == value) {
              return;
           }
           _width = value;
           dispatchEvent(new Event("menuWidthChanged"));
        }

        [Bindable("clickEventTypeChanged")]
        public function get clickEventType():String {
            return _clickEventType;
        }
        public function set clickEventType(value:String):void {
            if (_clickEventType == value) {
                return;
            }
            _clickEventType = value;
            dispatchEvent(new Event("clickEventTypeChanged"));
        }

        [Bindable("clickFunctionChanged")]
        public function get clickFunction():Function {
            return _clickFunction;
        }
        public function set clickFunction(value:Function):void {
            if (_clickFunction == value) {
                return;
            }
            _clickFunction = value;
            dispatchEvent(new Event("clickFunctionChanged"));
        }

        [Bindable("enabledChanged")]
        [Bindable("privilegeChanged")]
        [Bindable("dataChanged")]
        public function get enabled():Boolean {
            var enabled:Boolean = true;
            if (privilege != null && data != null) {
                if (data is Array) {
                    var a:Array = data as Array;
                    for(var i:int = 0; i< a.length; i++) {
                        var object:Object = a[i];
                        enabled &&= true;
                    }
                } else {
                   enabled = true;
                }
            }

            var extendedEnable:Boolean = _enableFunction != null ? _enableFunction() : true;

            return _enabled && enabled && extendedEnable;
        }

        public function set enabled(value:Boolean):void {
            if (_enabled == value) {
                return;
            }
            _enabled = value;
            dispatchEvent(new Event("enabledChanged"));
        }

        [Bindable("enableFunctionChanged")]
        public function get enableFunction():Function {
            return _enableFunction;
        }
        public function set enableFunction(value:Function):void {
            if (_enableFunction == value) {
                return;
            }
            _enableFunction = value;
            dispatchEvent(new Event("enableFunctionChanged"));
        }

        [Bindable("typeChanged")]
        public function get type():String {
            return _type;
        }
        public function set type(value:String):void {
            if (_type == value) {
                return;
            }
            _type = value;
            dispatchEvent(new Event("typeChanged"));
        }

        [Bindable("iconChanged")]
        public function get icon():Class {
            return _icon;
        }
        public function set icon(value:Class):void {
            if (_icon == value) {
                return;
            }
            _icon = value;
            dispatchEvent(new Event("iconChanged"));
        }
        
        [Bindable("iconChanged")]
        public function get disableIcon():Class {
           return _disableIcon;
        }
        public function set disableIcon(value:Class):void {
           if (_disableIcon == value) {
              return;
           }
           _disableIcon = value;
           dispatchEvent(new Event("iconChanged"));
        }

        [Bindable("toggledChanged")]
        public function get toggled():Boolean {
            return _toggled;
        }
        public function set toggled(value:Boolean):void {
            if (_toggled == value) {
                return;
            }
            _toggled = value;
            dispatchEvent(new Event("toggledChanged"));
        }

        [Bindable("groupNameChanged")]
        public function get groupName():String {
            return _groupName;
        }
        public function set groupName(value:String):void {
            if (_groupName == value) {
                return;
            }
            _groupName = value;
            dispatchEvent(new Event("groupNameChanged"));
        }

        [Bindable("dataChanged")]
        /**
         * The spec object to check for privilege
         */
        public function get data():Object {
            return _data;
        }

        /**
         * @private
         */
        public function set data(value:Object):void {
            if (_data != value) {
                _data = value;
                dispatchEvent(new Event("dataChanged"));
            }
        }

        [Bindable("privilegeChanged")]
        /**
         * The privilege name which we lookup in data
         */
        public function get privilege():String {
            return _privilege;
        }

        /**
         * @private
         */
        public function set privilege(value:String):void {
            if (_privilege != value) {
                _privilege = value;
                dispatchEvent(new Event("privilegeChanged"));
            }
        }

        [Bindable]
        public var privilegeByEntity:IList = null;

        [Bindable("visibleChanged")]
        [Bindable("privilegeChanged")]
        /**
         * Whether this menu item is displayed.
         */
        public function get visible():Boolean {
            // TODO weijin: We need authorization manager to do this check
            var privilegeVisible:Boolean = true;
            return _visible && privilegeVisible;
        }

        /**
         * @private
         */
        public function set visible(value:Boolean):void {
            if (_visible != value) {
                _visible = value;
                dispatchEvent(new Event("visibleChanged"));
            }
        }

        [Bindable("childrenChanged")]
        /**
         * Support sub menu item
         */
        public function get children():Array {
           return _children;
        }

        public function set children(value:Array):void {
           if (value && _children != value) {
              _children = value;
              dispatchEvent(new Event("childrenChanged"));
           }
        }
    }
}
