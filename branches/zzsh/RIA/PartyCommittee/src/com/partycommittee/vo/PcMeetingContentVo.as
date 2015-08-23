package com.partycommittee.vo
{
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcMeetingContentVo")]
	public class PcMeetingContentVo {
		public function PcMeetingContentVo() {
		}
		
		public var id:Number;
		public var type:Number;
		public var meetingId:Number;
		public var memberId:Number;
		public var memberName:String;
		public var content:String;
		public var updatetime:Date;
	}
}