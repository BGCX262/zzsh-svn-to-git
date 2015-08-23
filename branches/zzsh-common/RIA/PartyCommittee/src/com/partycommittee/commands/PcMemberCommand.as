package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcAgencyEvent;
	import com.partycommittee.events.PcMemberEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcMemberProxy;
	import com.partycommittee.util.CRUDEventType;
	
	import mx.rpc.IResponder;
	
	public class PcMemberCommand extends BaseCommand implements IResponder {
		public function PcMemberCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var pcMemberEvent:PcMemberEvent = event as PcMemberEvent;
			var pcMemberProxy:PcMemberProxy = getProxy();
			switch (pcMemberEvent.kind) {
				case CRUDEventType.CREATE:
					pcMemberProxy.createMember(pcMemberEvent.member);
					break;
				case CRUDEventType.DELETE:
					pcMemberProxy.deleteMembers(pcMemberEvent.memberList);
					break;
				case CRUDEventType.UPDATE:
					pcMemberProxy.updateMember(pcMemberEvent.member);
					break;
				case PcMemberEvent.GET_MEMBERS_BY_AGENCYID:
					pcMemberProxy.getMemberListByAgencyId(pcMemberEvent.agencyId);
//					pcMemberProxy.getMemberListPageByAgencyId(pcMemberEvent.agencyId, pcMemberEvent.page);
					break;
				case PcMemberEvent.EXPORT_MEMBERS_TO_EXCEL:
					pcMemberProxy.exportToExcel(pcMemberEvent.agencyId);
					break;
				case PcMemberEvent.GET_DUTY_CODE:
					pcMemberProxy.getDutyCodeList();
					break;				
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pcMemberEvent:PcMemberEvent = event as PcMemberEvent;
			switch (pcMemberEvent.kind) {
				case CRUDEventType.CREATE:
					break;
				case CRUDEventType.DELETE:
					break;
				case CRUDEventType.UPDATE:
					break;
				case PcMemberEvent.GET_MEMBERS_BY_AGENCYID:
					break;
				default:
					break;
			}
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcMemberProxy {
			return new PcMemberProxy(this);
		}
	}
}