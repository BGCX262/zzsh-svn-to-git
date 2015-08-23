package com.partycommittee.vo 
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="com.partycommittee.remote.vo.FilterVo")]
	public class FilterVo {
      
		public function FilterVo() {
			
		}
      
		public var id:String;
		public var data:String;
	}
}