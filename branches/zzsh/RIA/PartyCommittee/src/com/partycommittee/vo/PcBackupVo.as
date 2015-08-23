package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcBackupVo")]
	public class PcBackupVo {
		public function PcBackupVo() {
		}
		
		public var id:Number;
		public var filename:String;
		public var backupTime:Date;
	}
}