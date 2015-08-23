package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcRoleVo")]
	public class PcRoleVo {
		public function PcRoleVo() {
		}
		
		public var id:Number;
		public var role:String;
		public var name:String;
		public var enable:Number;
	}
}