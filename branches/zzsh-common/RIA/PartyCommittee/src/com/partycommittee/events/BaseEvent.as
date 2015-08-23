package com.partycommittee.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class BaseEvent extends CairngormEvent {
		
		private var _successCallback:Function;
		public function get successCallback():Function {
			return this._successCallback;
		}
		public function set successCallback(value:Function):void {
			this._successCallback = value;
		}
		
		private var _failureCallback:Function;
		public function get failureCallback():Function {
			return this._failureCallback;
		}
		public function set failureCallback(value:Function):void {
			this._failureCallback = value;
		}
		
		public function BaseEvent(type:String) {
			super(type);
		}
	}
}