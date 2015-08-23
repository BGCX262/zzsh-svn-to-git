package com.partycommittee.events
{
	import com.partycommittee.control.tree.classes.Node;
	import com.partycommittee.vo.PcAgencyVo;

	public class PcAgencyEvent extends BaseEvent {
		public static const PCAGENCY_EVENT:String = "com.partycommittee.events.PcAgencyEvent";
		
		public static const GET_ROOT_AGENCY_FOR_PRIVILEGE:String = "getRootAgencyForPrivilege";
		public static const GET_ROOT_AGENCY_BY_USERID:String = "getRootAgencyByUserId";
		public static const GET_ROOT_HISTORY_AGENCY_BY_USERID:String = "getRootHistoryAgencyByUserId";
		public static const GET_CHILDREN:String = "getChildren";
		public static const GET_CHILDREN_REVERT:String = "getChildrenRevert";
		public static const GET_CHILDREN_ONLY_PARENT:String = "getChildrenOnlyParent";
		public static const GET_PARENT:String = "getParent";
		public static const GET_AGENCY_INFO:String = "getAgencyInfo";
		public static const DO_REVERT:String = "doRevert";
		public static const GET_AGENCY_COUNT:String = "getAgencyCount";
		public static const GET_AGENCY_DW_COUNT:String = "getAgencyDwCount";
		
		private var _agency:PcAgencyVo;
		public function set agency(value:PcAgencyVo):void {
			this._agency = value;
		}
		public function get agency():PcAgencyVo {
			return this._agency;
		}
		
		private var _userId:Number;
		public function set userId(value:Number):void {
			this._userId = value;
		}
		public function get userId():Number {
			return this._userId;
		}
		
		private var _node:Node;
		public function set node(node:Node):void {
			this._node = node;
		}
		public function get node():Node {
			return this._node;
		}
		
		private var _kind:String;
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		public function PcAgencyEvent(kind:String = "READ", agency:PcAgencyVo = null, userId:Number = 0) {
			super(PCAGENCY_EVENT);
			this.agency = agency;
			this.userId = userId;
			this.kind = kind;
		}
	}
}