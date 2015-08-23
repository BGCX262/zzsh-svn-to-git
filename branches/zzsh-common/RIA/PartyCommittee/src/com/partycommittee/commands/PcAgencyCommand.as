package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcAgencyEvent;
	import com.partycommittee.manager.tree.TreeMgr;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcAgencyProxy;
	import com.partycommittee.util.CRUDEventType;
	import com.partycommittee.vo.PcAgencyVo;
	
	import mx.rpc.IResponder;
	
	public class PcAgencyCommand extends BaseCommand implements IResponder {
		public function PcAgencyCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var pcAgencyEvent:PcAgencyEvent = event as PcAgencyEvent;
			var pcAgencyProxy:PcAgencyProxy = getProxy();
			switch (pcAgencyEvent.kind) {
				case CRUDEventType.CREATE:
					pcAgencyProxy.createAgency(pcAgencyEvent.agency);
					break;
				case CRUDEventType.DELETE:
					pcAgencyProxy.deleteAgency(pcAgencyEvent.agency);
					break;
				case CRUDEventType.UPDATE:
					pcAgencyProxy.updateAgency(pcAgencyEvent.agency);
					break;
				case CRUDEventType.MOVE:
					pcAgencyProxy.moveAgency(pcAgencyEvent.agency);
					break;				
				case PcAgencyEvent.GET_ROOT_AGENCY_BY_USERID:
				case PcAgencyEvent.GET_ROOT_AGENCY_FOR_PRIVILEGE:
					pcAgencyProxy.getRootAgencyByUserId(pcAgencyEvent.userId);
					break;
				case PcAgencyEvent.GET_CHILDREN:
					pcAgencyProxy.getChildren(pcAgencyEvent.agency.id);
					break;
				case PcAgencyEvent.GET_CHILDREN_ONLY_PARENT:
					pcAgencyProxy.getChildrenOnlyParent(pcAgencyEvent.agency.id);
					break;				
				case PcAgencyEvent.GET_AGENCY_INFO:
					pcAgencyProxy.getAgencyInfo(pcAgencyEvent.agency.id);
					break;
				case PcAgencyEvent.GET_PARENT:
					pcAgencyProxy.getParentAgency(pcAgencyEvent.agency.id);
					break;
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pcAgencyEvent:PcAgencyEvent = event as PcAgencyEvent;
			switch (pcAgencyEvent.kind) {
				case CRUDEventType.CREATE:
					break;
				case CRUDEventType.DELETE:
					break;
				case CRUDEventType.UPDATE:
					break;
				case PcAgencyEvent.GET_ROOT_AGENCY_BY_USERID:
					if (data) {
						TreeMgr.getInstance().initRoot(data as PcAgencyVo);
					} else {
						onFailure();
					}
					break;
				case PcAgencyEvent.GET_ROOT_AGENCY_FOR_PRIVILEGE:
					break;
				case PcAgencyEvent.GET_CHILDREN:
					break;
				default:
					break;
			}
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcAgencyProxy {
			return new PcAgencyProxy(this);
		}
	}
}