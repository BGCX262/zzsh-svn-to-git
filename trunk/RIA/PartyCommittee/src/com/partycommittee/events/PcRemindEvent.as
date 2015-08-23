package com.partycommittee.events
{
	import com.partycommittee.vo.PcRemindVo;
	
	public class PcRemindEvent extends BaseEvent {
		public static const PCREMIND_EVENT:String = "com.partycommittee.events.PcRemindEvent";
		
		public static const GET_REAL_REMIND_BY_ID:String = "getRealRemindById";
		
		public static const GET_REMIND_STAT_BY_ID:String = "getRemindStatById";
		public static const GET_REMIND_NOCOMMIT_BY_PARENTID:String = "getRemindNoCommitByParentId";
		public static const GET_REMIND_BY_PARENTID:String = "getRemindByParentId";
		public static const GET_REMIND_STAT_BY_PARENTID:String = "getRemindStatByParentId";
		public static const GET_REMIND_STAT_BY_PARENTID_FOR_ADMIN:String = "getRemindStatByParentIdForAdmin";
		public static const GET_REMIND_STAT_BY_PARENTID_FOR_OTHER:String = "getRemindStatByParentIdForOTHER";

		private var _agencyId:Number;
		
		public function set agencyId(value:Number):void {
			this._agencyId = value;
		}
		public function get agencyId():Number {
			return this._agencyId;
		}
		
		private var _typeId:Number;
		
		public function get typeId():Number	{
			return _typeId;
		}
		
		private var _statusId:Number;
		
		public function get statusId():Number
		{
			return _statusId;
		}
		
		public function set statusId(value:Number):void
		{
			_statusId = value;
		}
		
		
		public function set typeId(value:Number):void {
			_typeId = value;
		}

		private var _year:Number;
		public function get year():Number {
			return this._year;
		}
		public function set year(value:Number):void {
			this._year = value;
		}
		
		private var _quarter:Number;
		public function get quarter():Number {
			return this._quarter;
		}
		public function set quarter(value:Number):void {
			this._quarter = value;
		}
		
		
		private var _kind:String;
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcRemindEvent(kind:String = "getRealRemindById") {
			super(PCREMIND_EVENT);
//			this.agencyId = agencyId;
//			this.year = year;
//			this.quarter = q;
			this.kind = kind;
		}
	}
}