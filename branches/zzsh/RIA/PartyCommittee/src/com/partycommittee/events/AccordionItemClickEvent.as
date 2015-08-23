package com.partycommittee.events
{
	import flash.events.Event;

	public class AccordionItemClickEvent extends Event {
		public static const ITEM_CLICK:String = "com.partycommittee.events.AccordionItemClick.ItemClick";
		
		private var _item:Object;
		public function set item(value:Object):void {
			this._item = value;
		}
		public function get item():Object {
			return this._item;
		}
		
		public function AccordionItemClickEvent(type:String, item:Object) {
			super(type, true);
			this._item = item;
		}
	}
}