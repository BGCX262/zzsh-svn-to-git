package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcAgencyVo;
	
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class PcAgencyProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcAgency";
		
		public function PcAgencyProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getRootAgencyByUserId(id:Number):void {
			service.getRootAgencyByUserId(id);
		}
		
		public function getChildren(agencyId:Number):void {
			service.getChildren(agencyId);
		}
		
		public function getChildrenOnlyParent(agencyId:Number):void {
			service.getChildrenOnlyParent(agencyId);
		}		
		
		public function getAgencyInfo(agencyId:Number):void {
			service.getAgencyInfo(agencyId);
		}
		
		public function getParentAgency(agencyId:Number):void {
			service.getParentAgency(agencyId);
		}
		
		public function createAgency(agency:PcAgencyVo):void {
			service.createAgency(agency);
		}
		
		public function deleteAgency(agency:PcAgencyVo):void {
			service.deleteAgency(agency);
		}
		
		public function updateAgency(agency:PcAgencyVo):void {
			service.updateAgency(agency);
		}

		public function moveAgency(agency:PcAgencyVo):void {
			service.moveAgency(agency);
		}
		
		
	}
}