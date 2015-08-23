package com.partycommittee.vo
{
	[RemoteClass(alias="com.partycommittee.remote.vo.PcMemberVo")]
	public class PcMemberVo {
		public function PcMemberVo() {
		}
		
		public var id:Number;
		public var agencyId:Number;
		public var postId:Number;
		public var name:String;
		public var sexId:Number;
		public var nationId:Number;
		public var birthday:Date;
		public var workday:Date;
		public var joinday:Date;
		public var eduId:Number;
		public var postday:Date;
		public var birthPlace:String;
		public var address:String;
		public var dutyId:Number;
		public var adminDuty:String;
		public var sort:Number;
		public var ext:String;
		public var active:Number;
		public var updatetime:Date;
		public var comment:String;
	}
}