package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcRemindLockVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class PcStatProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcStat";
		
		public function PcStatProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getAgencyStatById(agencyId:Number, year:Number, endMonth:Number):void {
			service.getAgencyStatById(agencyId, year, endMonth);
		}
		
		public function getWorkPlanStatsById(agencyId:Number, year:Number, startMonth:Number, endMonth:Number):void  {
			service.getWorkPlanStatsById(agencyId, year, startMonth, endMonth);
		}
		
		public function getWorkPlanZBStatsById(agencyId:Number, year:Number, startMonth:Number, endMonth:Number):void  {
			service.getWorkPlanZBStatsById(agencyId, year, startMonth, endMonth);
		}		
		
		public function getMeetingStatsById(agencyId:Number, year:Number, startMonth:Number, endMonth:Number):void {
			service.getMeetingStatsById(agencyId, year, startMonth, endMonth);
		}
		
		public function getMeetingZBStatsById(agencyId:Number, year:Number, startMonth:Number, endMonth:Number):void  {
			service.getMeetingZBStatsById(agencyId, year, startMonth, endMonth);
		}		
		
		public function getZbStatsById(agencyId:Number, year:Number, startMonth:Number, endMonth:Number):void  {
			service.getZbStatsById(agencyId, year, startMonth, endMonth);
		}		
	}
}