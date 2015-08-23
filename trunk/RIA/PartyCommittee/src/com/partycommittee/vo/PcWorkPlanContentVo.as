package com.partycommittee.vo
{
	[RemoteClass(alias="com.partycommittee.remote.vo.PcWorkPlanContentVo")]
	public class PcWorkPlanContentVo {
		public function PcWorkPlanContentVo() {
		}
		
		public var id:Number;
		public var workplanId:Number;
		public var type:Number;
		public var memberName:String;
		public var content:String;
		public var updatetime:Date;
	}
}