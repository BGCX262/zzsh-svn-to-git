package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcStatEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcStatProxy;
	
	import mx.rpc.IResponder;
	
	public class PcStatCommand extends BaseCommand implements IResponder {
		public function PcStatCommand() {
			
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcStatEvent = event as PcStatEvent;
			var proxy:PcStatProxy = getProxy();
			switch (evt.kind) {
				case PcStatEvent.GET_AGENCY_STATS_BY_ID :
					proxy.getAgencyStatById(evt.agencyId, evt.year, evt.endMonth);
					break;
				case PcStatEvent.GET_WORKPLAN_STATS_BY_ID:
					proxy.getWorkPlanStatsById(evt.agencyId, evt.year, evt.startMonth, evt.endMonth);
					break;
				case PcStatEvent.GET_WORKPLAN_ZBSTATS_BY_ID:
					proxy.getWorkPlanZBStatsById(evt.agencyId, evt.year, evt.startMonth, evt.endMonth);
					break;				
				case PcStatEvent.GET_MEETING_STATS_BY_ID:
					proxy.getMeetingStatsById(evt.agencyId, evt.year, evt.startMonth, evt.endMonth);
					break;	
				case PcStatEvent.GET_MEETING_ZBSTATS_BY_ID:
					proxy.getMeetingZBStatsById(evt.agencyId, evt.year, evt.startMonth, evt.endMonth);
					break;					
				case PcStatEvent.GET_ZB_STAT_BY_ID:
					proxy.getZbStatsById(evt.agencyId, evt.year, evt.startMonth, evt.endMonth);
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
		
		protected function getProxy():PcStatProxy {
			return new PcStatProxy(this);
		}
	}
}