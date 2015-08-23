package com.partycommittee.vo
{
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcRemindVo")]
	public class PcRemindVo {
		public function PcRemindVo() {
		}
		
		public var id:Number;
		public var agencyId:Number;
		public var typeId:Number;
		public var year:Number;
		public var quarter:Number;
		public var statusId:Number;
		public var name:String;
		public var parentName:String;
		public var parentId:Number;
		public var codeId:Number;
		public var ext:String;		
		
	}
}