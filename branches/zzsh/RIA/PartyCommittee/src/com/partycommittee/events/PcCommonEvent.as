package com.partycommittee.events
{
	import com.partycommittee.control.tree.classes.Node;


	public class PcCommonEvent extends BaseEvent {
		public static const PCCOMMON_EVENT:String = "com.partycommittee.events.PcCommonEvent";
		
		public static const GET_MILLISECONDS:String = "getMilliseconds";

		
		private var _kind:String;
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcCommonEvent(kind:String = "") {
			super(PCCOMMON_EVENT);
			this.kind = kind;
		}
	}
}