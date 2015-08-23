package com.partycommittee.events
{
	import mx.collections.ArrayCollection;
	
	public class PcParentStatEvent extends BaseEvent {
		public static const PCPARENT_EVENT:String = "com.partycommittee.events.PcParentStatEvent";
		
		public static const GET_LIST_STAT_BY_PARENT:String = "getListStatByParentId";		
		private var _agencyId:Number;
		private var _year:Number;
		private var _quarter:Number;
		private var _month:Number;
		private var _kind:String;

		public function get quarter():Number
		{
			return _quarter;
		}

		public function set quarter(value:Number):void
		{
			_quarter = value;
		}

		public function get year():Number
		{
			return _year;
		}

		public function set year(value:Number):void
		{
			_year = value;
		}
		
		public function get month():Number
		{
			return _month;
		}
		
		public function set month(value:Number):void
		{
			_month = value;
		}
		

		public function get agencyId():Number
		{
			return _agencyId;
		}

		public function set agencyId(value:Number):void
		{
			_agencyId = value;
		}

		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcParentStatEvent(kind:String = "getListStatByParentId") {
			super(PCPARENT_EVENT);
			this.kind = kind;
		}
	}
}