package com.partycommittee.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.util.CRUDEventType;
	import com.partycommittee.vo.PcMemberVo;
	import com.partycommittee.vo.PcUserVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	
	public class PcMemberEvent extends BaseEvent {
		public static const PCMEMBER_EVENT:String = "com.partycommittee.events.PcMemberEvent";
		
		public static const GET_MEMBERS_BY_AGENCYID:String = "getMemberListByAgencyId";
		public static const GET_MEMBERS_COUNT_BY_AGENCYID:String = "getMemberCountByAgencyId";
		public static const GET_WY_COUNT_BY_AGENCYID:String = "getWyCountByAgencyId";
		public static const EXPORT_MEMBERS_TO_EXCEL:String = "exportMemberListToExcel";
		public static const GET_DUTY_CODE:String = "getDutyCode";
		
		private var _member:PcMemberVo;
		public function set member(value:PcMemberVo):void {
			this._member = value;
		}
		public function get member():PcMemberVo {
			return this._member;
		}
		
		private var _memberList:ArrayCollection;
		public function set memberList(value:ArrayCollection):void {
			this._memberList = value;
		}
		public function get memberList():ArrayCollection {
			return this._memberList;
		}
		
		private var _agencyId:Number;
		public function set agencyId(value:Number):void {
			this._agencyId = value;
		}
		public function get agencyId():Number {
			return this._agencyId;
		}
		
		private var _page:PageHelperVo;
		public function get page():PageHelperVo {
			return this._page;
		}
		public function set page(value:PageHelperVo):void {
			this._page = value;
		}
		
		private var _kind:String;
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcMemberEvent(kind:String = "READ", 
									  member:PcMemberVo = null, 
									  agencyId:Number = 0, 
									  memberList:ArrayCollection = null) {
			super(PCMEMBER_EVENT);
			this.member = member;
			this.agencyId = agencyId;
			this.memberList = memberList;
			this.kind = kind;
		}
	}
}