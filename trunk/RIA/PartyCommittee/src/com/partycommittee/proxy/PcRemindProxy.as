package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcWorkPlanContentVo;
	import com.partycommittee.vo.PcWorkPlanVo;
	
	import mx.rpc.IResponder;
	
	public class PcRemindProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcRemind";
		
		public function PcRemindProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		

		public function getRealRemindById(agencyId:Number, year:Number, quarter:Number):void {
			service.getRealRemindById(agencyId, year, quarter);
		}
		
		public function getListRemindStatById(agencyId:Number, year:Number, quarter:Number):void {
			service.getListRemindStatById(agencyId, year, quarter);
		}		
		
		public function getListRemindStatByParentIdForAdmin(agencyId:Number, year:Number, quarter:Number):void {
			service.getListRemindStatByParentIdForAdmin(agencyId, year, quarter);
		}	
		
		public function getListRemindNoCommitByParentId(agencyId:Number, year:Number, quarter:Number, tid:Number):void {
			service.getListRemindNoCommitByParentId(agencyId, year, quarter, tid);
		}		
		
		public function getListRemindByParentId(agencyId:Number, year:Number, quarter:Number, tid:Number, sid:Number):void {
			service.getListRemindByParentId(agencyId, year, quarter, tid, sid);
		}		
		
	

	}
}