package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcAgencyVo;
	import com.partycommittee.vo.PcMemberVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class PcMemberProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcMember";
		
		public function PcMemberProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getMemberListByAgencyId(agencyId:Number):void {
			service.getMemberListByAgencyId(agencyId);
		}
		
		public function getWyCountByAgencyId(agencyId:Number):void {
			service.getWyCountByAgencyId(agencyId);
		}		
		
		public function getMemberListPageByAgencyId(agencyId:Number, page:PageHelperVo):void {
			service.getMemberListPageByAgencyId(agencyId, page);
		}
		
		public function createMember(member:PcMemberVo):void {
			service.createMember(member);
		}
		
		public function deleteMembers(memberList:ArrayCollection):void {
			service.deleteMembers(memberList);
		}
		
		public function updateMember(member:PcMemberVo):void {
			service.updateMember(member);
		}
		
		public function getDutyCodeList():void {
			service.getDutyCodeList();
		}		
		
		public function exportToExcel(agencyId:Number):void {
			service.exportToexcel(agencyId);
		}
		
	}
}