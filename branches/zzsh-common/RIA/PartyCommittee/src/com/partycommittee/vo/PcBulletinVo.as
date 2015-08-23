package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcBulletinVo")]
	public class PcBulletinVo {
		public function PcBulletinVo() {
		}
		
		public var id:Number;
		public var title:String;
		public var content:String;
		public var member:String;
		public var isIndex:Number;
		public var setupDatetime:Date;
		public var pubTime;
		public var expireTime;
	}
}