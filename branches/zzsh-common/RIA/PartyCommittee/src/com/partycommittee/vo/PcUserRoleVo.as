package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcUserRoleVo")]
	public class PcUserRoleVo {
		public function PcUserRoleVo() {
		}
		
		public var id:Number;
		public var userId:Number;
		public var roleId:Number;
	}
}