package com.partycommittee.vo
{
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcRemindConfigVo")]
	public class PcRemindConfigVo {
		public function PcRemindConfigVo() {
			
		}
		
		public var id:Number;
		
		public var typeId:Number;
		
		public var value:Number;
		
		public var startYear:Number;
		
		public var startQuarter:Number;
		
		public var startMonth:Number;
		
		public var startDay:Number;
		
		public var endYear:Number;
		
		public var endQuarter:Number;
		
		public var endMonth:Number;
		
		public var endDay:Number;
		
		public var delayDay:Number;	
		
	}
}