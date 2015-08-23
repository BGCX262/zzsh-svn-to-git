package com.partycommittee.vo.page
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.helper.PageHelperVo")]
	public class PageHelperVo {
		public function PageHelperVo() {
		}
		
		public var recordCount:Number;
		public var pageCount:Number;
		public var pageIndex:Number = 1;
		public var pageSize:Number = 30;
	}
}