package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcAgencyInfoVo")]
	public class PcAgencyInfoVo {
		public function PcAgencyInfoVo() {
		}
		
		public var teamNumber:Number;
		public var memberNumber:Number;
		public var dutyMemberList:ArrayCollection;
	}
}