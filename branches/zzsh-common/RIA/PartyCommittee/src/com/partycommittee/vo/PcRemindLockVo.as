package com.partycommittee.vo
{
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcRemindLockVo")]
	public class PcRemindLockVo {
		public function PcRemindLockVo() {
			
		}
		
		public var id:Number;
		
		public var agencyId:Number;
		
		public var typeId:Number;
		
		public var codeId:Number;
		
		public var ext:String;
		
		public var code:String;
		
		public var name:String;	
		
		public var year:Number;
		
		public var quarter:uint;
		
		public var month:uint;
		
		public var statusId:Number;
		
		public var parentId:Number;
		
		public var delayDate:String;
	}
}