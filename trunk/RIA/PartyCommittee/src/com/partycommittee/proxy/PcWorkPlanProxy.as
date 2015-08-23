package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcWorkPlanContentVo;
	import com.partycommittee.vo.PcWorkPlanVo;
	
	import mx.rpc.IResponder;
	
	public class PcWorkPlanProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcWorkPlan";
		
		public function PcWorkPlanProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function createWorkPlan(workPlan:PcWorkPlanVo):void {
			service.createWorkPlan(workPlan);
		}
		
		public function createWorkPlanAndSubmit(workPlan:PcWorkPlanVo):void {
			service.createWorkPlanAndSubmit(workPlan);
		}
		
		public function updateWorkPlan(workPlan:PcWorkPlanVo):void {
			service.updateWorkPlan(workPlan);
		}
		
		public function updateWorkPlanAndSubmit(workPlan:PcWorkPlanVo):void {
			service.updateWorkPlanAndSubmit(workPlan);
		}
		
		public function getWorkPlanYearly(agencyId:Number, year:Number):void {
			service.getWorkPlanYearly(agencyId, year);
		}
		
		public function getWorkPlanYearlySummary(agencyId:Number, year:Number):void {
			service.getWorkPlanYearlySummary(agencyId, year);
		}
		
		public function getWorkPlanQuarter(agencyId:Number, year:Number, quarter:Number):void {
			service.getWorkPlanQuarter(agencyId, year, quarter);
		}
		
		public function getWorkPlanQuarterSummary(agencyId:Number, year:Number, quarter:Number):void {
			service.getWorkPlanQuarterSummary(agencyId, year, quarter);
		}		
		
		public function getWorkPlanListQuarter(agencyId:Number, year:Number):void {
			service.getWorkPlanListQuarter(agencyId, year);
		}
		
		public function getResultListQuarter(agencyId:Number, year:Number):void {
			service.getResultListQuarter(agencyId, year);
		}
		
		public function submitWorkPlan(workPlan:PcWorkPlanVo):void {
			service.submitWorkPlan(workPlan);
		}
		
		public function getCommitWorkplanListByParentId(parentId:Number, year:Number, filters:Array):void {
			service.getCommitWorkplanListByParentId(parentId, year, filters);
		}

		public function saveContentWrokplan(workPlanId:Number,  statusId:Number, content:PcWorkPlanContentVo):void {
			service.saveContentWrokplan(workPlanId, statusId, content);
		}		
		
		public function getContentInfo(workPlanId:Number, type:Number):void {
			service.getContentInfo(workPlanId, type);
		}
				
		public function getAlertInfo(agencyId:Number, year:Number, quarter:Number):void {
			service.getAlertInfo(agencyId, year, quarter);
		}
		
		public function getWorkplanComment(workplan:PcWorkPlanVo):void {
			service.getWorkplanComment(workplan);
		}
		
		public function updateWorkPlanStatus(workPlanId:Number, statusId:Number):void {
			service.updateWorkPlanStatus(workPlanId, statusId);
		}	
		
		public function deleteWorkPlan(workPlanId:Number):void {
			service.deleteWorkPlan(workPlanId);
		}	
	}
}