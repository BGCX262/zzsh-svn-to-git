package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcRemindLockVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class PcRemindLockProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcRemindLock";
		
		public function PcRemindLockProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}

		public function getRemindLockByFilters(filters:Array, page:PageHelperVo):void {
			service.getRemindLockByFilters(filters, page);
		}
		
		public function updateItem(item:PcRemindLockVo):void {
			service.updateRemindLock(item);
		}		
		
		public function getRemindLockById(agencyId:Number, year:Number, quarter:Number, month:Number, typeId:Number):void {
			service.getRemindLockById(agencyId, year, quarter, month, typeId);
		}
	}
}