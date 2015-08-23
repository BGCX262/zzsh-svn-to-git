package com.partycommittee.vo
{
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcWorkPlanVo")]
	public class PcWorkPlanVo {
		public function PcWorkPlanVo() {
		}
		
		public var id:Number;
		public var agencyId:Number;
		public var agencyName:String;
		public var typeId:Number;
		public var year:Number;
		public var quarter:Number;
		public var statusId:Number;
		public var active:Number;
		
		public var workPlanContent:PcWorkPlanContentVo;
	}
}