package com.partycommittee.events
{
	import com.partycommittee.vo.PcRemindLockVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	
	public class PcRemindLockEvent extends BaseEvent {
		public static const PCREMINDLOCK_EVENT:String = "com.partycommittee.events.PcRemindLockEvent";
		
		public static const GET_REMIND_LOCK_BY_FILTERS:String = "getRemindLockByFilters";
		public static const UPDATE_REMIND_LOCK:String = "updateRemindLock";
		public static const GET_REMIND_LOCK_BY_ID:String = "getRemindLockById";
		
		private var _agencyId:Number;
		private var _year:Number;
		private var _quarter:Number;
		private var _month:Number;
		private var _typeId:Number
		
		private var _kind:String;
		
		private var _pcRemindLockVo:PcRemindLockVo;
		
		private var _filters:Array;
		
		private var _page:PageHelperVo;

		public function get typeId():Number
		{
			return _typeId;
		}

		public function set typeId(value:Number):void
		{
			_typeId = value;
		}

		public function get month():Number
		{
			return _month;
		}

		public function set month(value:Number):void
		{
			_month = value;
		}

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

		public function get agencyId():Number
		{
			return _agencyId;
		}

		public function set agencyId(value:Number):void
		{
			_agencyId = value;
		}

		public function get page():PageHelperVo {
			return this._page;
		}
		public function set page(value:PageHelperVo):void {
			this._page = value;
		}		
		
		public function get filters():Array
		{
			return _filters;
		}

		public function set filters(value:Array):void
		{
			_filters = value;
		}

		public function get pcRemindLockVo():PcRemindLockVo
		{
			return _pcRemindLockVo;
		}

		public function set pcRemindLockVo(value:PcRemindLockVo):void
		{
			_pcRemindLockVo = value;
		}

		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcRemindLockEvent(kind:String = "getRemindLockByFilters") {
			super(PCREMINDLOCK_EVENT);
			this.kind = kind;
		}
	}
}