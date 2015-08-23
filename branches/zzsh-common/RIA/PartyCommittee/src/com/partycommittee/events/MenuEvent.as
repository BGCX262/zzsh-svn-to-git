package com.partycommittee.events
{
	import flash.events.Event;

	public class MenuEvent extends Event {
		public static const ITEM_CLICK:String = "com.partycommittee.events.MenuEvent.itemClick";
		
		private var _item:Object;
		public function get item():Object{
			return this._item;
		}
		
		public function MenuEvent(type:String, item:Object) {
			super(type, true);
			this._item = item;
		}
	}
}