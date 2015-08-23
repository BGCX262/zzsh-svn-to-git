package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcRemindLockVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class PcParentStatProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcParentStat";
		
		public function PcParentStatProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getListStatByParentId(agencyId:Number, year:Number, quarter:Number):void {
			service.getListStatByParentId(agencyId, year, quarter);
		}
	}
}