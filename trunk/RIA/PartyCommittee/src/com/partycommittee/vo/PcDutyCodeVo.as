package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcDutyCodeVo")]
	public class PcDutyCodeVo {
		public function PcDutyCodeVo() {
		}
		
		public var id:Number;
		public var code:String;
		public var description:String;
	}
}