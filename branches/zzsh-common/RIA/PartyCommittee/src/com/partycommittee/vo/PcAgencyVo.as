package com.partycommittee.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.PcAgencyVo")]
	public class PcAgencyVo {
		public function PcAgencyVo() {
		}
		
		public var id:Number;
		public var parentId:Number;
		public var name:String;
		public var code:String;
		public var codeId:Number;
		public var number:Number;
		public var memberId:Number;
		public var member:PcMemberVo;
		public var tel:String;
		public var comment:String;
		public var setupDatetime:Date;
		public var createDatetime:Date;
		public var invalidDatetime:int;
		public var pcount:int; //'党小组数',
		public var zbnum:int;  //'支部人数',
		public var zbsj:String; //'支部书记',
		public var zbfsj:String; //'支部副书记',
		public var zzwy:String; //'组织委员',
		public var xcwy:String; //'宣传委员',
		public var jjwy:String; //'纪检委员',
		public var qnwy:String; //'青年委员',
		public var ghwy:String; //'工会委员',
		public var fnwy:String; //'妇女委员',
		public var ext:String = 'beijing';//'saas扩展字段',
		
		public var children:ArrayCollection = new ArrayCollection();
	}
}