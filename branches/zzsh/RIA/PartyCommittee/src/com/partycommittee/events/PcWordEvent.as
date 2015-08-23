package com.partycommittee.events
{
	import mx.collections.ArrayCollection;
	
	public class PcWordEvent extends BaseEvent {
		public static const PCWORD_EVENT:String = "com.partycommittee.events.PcWordEvent";
		
		public static const EXPORT_WORD_ALL:String = "exportWordAll";
		public static const EXPORT_WORD_FOR_WORKPLAN:String = "exportWordForWorkPlan";
		public static const EXPORT_WORD_FOR_MEETING:String = "exportWordForMeeting";
		
		private var _agencyId:Number;
		private var _year:Number;
		
		private var _zid:Number;
		
		
		private var _kind:String;
		
		
		public function get agencyId():Number
		{
			return _agencyId;
		}
		
		public function set agencyId(value:Number):void
		{
			_agencyId = value;
		}
		
		public function get year():Number
		{
			return _year;
		}
		
		public function set year(year:Number):void
		{
			_year = year;
		}		
		
		public function get zid():Number
		{
			return _zid;
		}
		
		public function set zid(value:Number):void
		{
			_zid = value;
		}		
		
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcWordEvent(kind:String = "exportWordAll") {
			super(PCWORD_EVENT);
			this.kind = kind;
		}
	}
}