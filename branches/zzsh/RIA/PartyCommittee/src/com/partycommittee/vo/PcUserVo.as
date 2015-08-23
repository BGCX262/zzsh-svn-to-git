package com.partycommittee.vo 
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcUserVo")]
	public class PcUserVo {
      
		public function PcUserVo() {
		}
      
		public var id:int;
		public var username:String;
		public var password:String;
		public var email:String;
        public var phone:String;
		public var status:Number;
		public var lastlogintime:Date;
		public var description:String;
		public var privilege:String;
		public var comment:String;
		public var enableReport:Number;
		public var agencyCodeId:Number;
		
		public var agencyList:ArrayCollection;
		public var roles:ArrayCollection;
	}
}