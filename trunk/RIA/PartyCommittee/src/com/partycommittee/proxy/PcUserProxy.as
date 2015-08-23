package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcUserVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class PcUserProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcUser";
		
		public function PcUserProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function checkUserOnly(user:PcUserVo):void {
			service.checkUserOnly(user);
		}		
		
		public function createPcUser(user:PcUserVo):void {
			service.createPcUser(user);
		}
		
		public function deletePcUsers(userList:ArrayCollection):void {
			service.deletePcUsers(userList);
		}
		
		public function updatePcUser(user:PcUserVo):void {
			service.updatePcUser(user);
		}
		
		public function getPcUserList():void {
			service.getPcUserList();
		}
		
		public function getPcUserListByPage(page:PageHelperVo, agencyId:Number = 0):void {
			service.getPcUserListByPage(page, agencyId);
		}
		
		public function getPcUserListByPageAndParentId(page:PageHelperVo, agencyId:Number = 0):void {
			service.getPcUserListByPageAndParentId(page, agencyId);
		}
		
		public function login(username:String, password:String):void {
			service.login(username, password);
		}
		
		public function userLogOut():void {
			service.userLogOut();
		}
		
		public function getLoginUser():void {
			service.getLoginUser();
		}
		
		public function getRoleList():void {
			service.getRoleList();
		}
	
	}
}