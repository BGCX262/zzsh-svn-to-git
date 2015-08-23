package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcLicenseVo")]
	public class PcLicenseVo {
		public function PcLicenseVo() {
		}
		
		public var productno:String;
		public var locknodw:Number;
		public var locknozb:Number;
		public var firstdays:String;
		public var leftdays:Number;
		public var tips:String;
	}
}