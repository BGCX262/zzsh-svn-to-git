package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcWorkPlanEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcWorkPlanProxy;
	import com.partycommittee.util.CRUDEventType;
	
	import mx.rpc.IResponder;
	
	public class PcWorkPlanCommand extends BaseCommand implements IResponder {
		public function PcWorkPlanCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var pcWorkPlanEvt:PcWorkPlanEvent = event as PcWorkPlanEvent;
			var proxy:PcWorkPlanProxy = getProxy();
			switch (pcWorkPlanEvt.kind) {
				case CRUDEventType.UPDATE:
					proxy.updateWorkPlan(pcWorkPlanEvt.workPlan);
					break;
				case PcWorkPlanEvent.GET_WORKPLAN_YEARLY:
					proxy.getWorkPlanYearly(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year);
					break;
				case PcWorkPlanEvent.GET_WORKPLAN_YEARLY_SUMMARY:
					proxy.getWorkPlanYearlySummary(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year);
					break;
				case CRUDEventType.CREATE:
					proxy.createWorkPlan(pcWorkPlanEvt.workPlan);
					break;
				case PcWorkPlanEvent.GET_COMMIT_CHILDREN_WORKPLAN:
					proxy.getCommitWorkplanListByParentId(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year, pcWorkPlanEvt.filters);
					break;
				case PcWorkPlanEvent.GET_WORKPLAN_QUARTER:
					proxy.getWorkPlanQuarter(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year, pcWorkPlanEvt.quarter);
					break;
				case PcWorkPlanEvent.GET_WORKPLAN_QUARTER_SUMMARY:
					proxy.getWorkPlanQuarterSummary(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year, pcWorkPlanEvt.quarter);
					break;				
				case PcWorkPlanEvent.GET_WORKPLAN_QUARTER_LIST:
					proxy.getWorkPlanListQuarter(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year);
					break;
				case PcWorkPlanEvent.GET_WORKPLAN_QUARTER_RESULT_LIST:
					proxy.getResultListQuarter(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year);
					break;
				case PcWorkPlanEvent.SUBMIT_WORKPLAN:
					proxy.submitWorkPlan(pcWorkPlanEvt.workPlan);
					break;
				
				case PcWorkPlanEvent.SAVE_CONTENT_WORKPLAN:
					proxy.saveContentWrokplan(pcWorkPlanEvt.workPlan.id, pcWorkPlanEvt.workPlan.statusId, pcWorkPlanEvt.workPlanContent);
					break;
				case PcWorkPlanEvent.GET_CONTENT_INFO:
					proxy.getContentInfo(pcWorkPlanEvt.workPlan.id, pcWorkPlanEvt.contentType);
					break;				
				case PcWorkPlanEvent.GET_ALERT_INFO:
					proxy.getAlertInfo(pcWorkPlanEvt.agency.id, pcWorkPlanEvt.year, pcWorkPlanEvt.quarter);
					break;
				case PcWorkPlanEvent.RETURN_WORKPLAN:
					proxy.updateWorkPlanStatus(pcWorkPlanEvt.workPlan.id, pcWorkPlanEvt.workPlan.statusId);
					break;	
				case PcWorkPlanEvent.DELETE_WORKPLAN:
					proxy.deleteWorkPlan(pcWorkPlanEvt.workPlan.id);
					break;			
				case PcWorkPlanEvent.EXPORT_WORKPLAN_TO_DOC:
					proxy.exportWorkPlanToDoc(pcWorkPlanEvt.workPlan.id);
					break;
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcWorkPlanProxy {
			return new PcWorkPlanProxy(this);
		}
	}
}