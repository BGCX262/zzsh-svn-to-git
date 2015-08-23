package com.partycommittee.events
{
	import mx.collections.ArrayCollection;
	
	public class PcStatEvent extends BaseEvent {
		public static const PCSTAT_EVENT:String = "com.partycommittee.events.PcStatEvent";
		
		public static const GET_AGENCY_STATS_BY_ID:String = "getAgencyStatSById";		
		public static const GET_WORKPLAN_STATS_BY_ID:String = "getWorkPlanStatSById";
		public static const GET_WORKPLAN_ZBSTATS_BY_ID:String = "getWorkPlanZBStatSById";
		public static const GET_MEETING_STATS_BY_ID:String = "getMeetingStatSById";
		public static const GET_MEETING_ZBSTATS_BY_ID:String = "getMeetingZBStatSById";
		public static const GET_ZB_STAT_BY_ID:String = "getZbStatById";
		private var _agencyId:Number;
		private var _year:Number;
		private var _quarter:Number;
		private var _startMonth:Number;
		private var _endMonth:Number;

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

		public function set year(value:Number):void
		{
			_year = value;
		}

		public function get startMonth():Number
		{
			return _startMonth;
		}
		
		public function set startMonth(value:Number):void
		{
			_startMonth = value;
		}
		
		public function get endMonth():Number
		{
			return _endMonth;
		}
		
		public function set endMonth(value:Number):void
		{
			_endMonth = value;
		}
		
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcStatEvent(kind:String = "getListStatByParentId") {
			super(PCSTAT_EVENT);
			this.kind = kind;
		}
	}
}