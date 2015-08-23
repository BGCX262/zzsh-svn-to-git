package com.partycommittee.events
{
	import com.partycommittee.vo.PcRemindConfigVo;
	
	import mx.collections.ArrayCollection;
	
	public class PcRemindConfigEvent extends BaseEvent {
		public static const PCREMINDCONFIG_EVENT:String = "com.partycommittee.events.PcRemindConfigEvent";
		
		public static const GET_REMIND_CONFIG_LIST:String = "getRemindConfigList";
		public static const UPDATE_REMIND_CONFIG:String = "updateRemindConfig";

		private var _kind:String;
		private var _items:Array;
		
		public function get items():Array
		{
			return _items;
		}

		public function set items(value:Array):void
		{
			_items = value;
		}

		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcRemindConfigEvent(kind:String = "getRemindConfigList") {
			super(PCREMINDCONFIG_EVENT);
			this.kind = kind;
		}
	}
}