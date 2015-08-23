package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;
	
	public class PcWordProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcWord";
		
		public function PcWordProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
				
		public function exportDocForAll(agencyId:Number, year:Number):void {
			service.exportDocForAll(agencyId, year);
		}		
		
		public function exportDocForWorkPlan(workPlanId:Number):void {
			service.exportDocForWorkPlan(workPlanId);
		}			
		
		public function exportDocForMeeting(meetingId:Number):void {
			service.exportDocForMeeting(meetingId);
		}		
	}
}