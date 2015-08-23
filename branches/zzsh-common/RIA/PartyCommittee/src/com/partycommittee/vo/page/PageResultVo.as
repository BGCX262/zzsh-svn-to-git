package com.partycommittee.vo.page
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.helper.PageResultVo")]
	public class PageResultVo {
		public function PageResultVo() {
		}
		
		public var pageHelper:PageHelperVo;
		public var list:ArrayCollection;
	}
}