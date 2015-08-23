package com.partycommittee.vo
{
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcMeetingVo")]
	public class PcMeetingVo {
		public function PcMeetingVo() {
		}
		
		public var id:Number;
		public var agencyId:Number;
		public var agencyName:String;
		public var typeId:Number;
		public var year:Number;
		public var quarter:Number;
		public var month:Number;
		public var week:Number;
		public var moderator:String;
		public var theme:String;
		public var attend:Number;
		public var asence:Number;
		public var statusId:Number;
		public var active:Number;
		public var comment:String;
		public var meetingDatetime:Date;
		public var meetingName:String;
		
		public var asenceMemberIds:String;
		
		public var content:PcMeetingContentVo;
	}
}