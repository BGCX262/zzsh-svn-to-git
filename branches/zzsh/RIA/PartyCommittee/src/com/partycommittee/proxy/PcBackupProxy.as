package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcBackupVo;
	import com.partycommittee.vo.PcBulletinVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class PcBackupProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcBackup";
		
		public function PcBackupProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getBackups(page:PageHelperVo):void {
			service.getBackups(page);
		}
		
		public function createBackup():void {
			service.createBackup();
		}
		
		public function deleteBackup(id:Number):void {
			service.deleteBackup(id);
		}

	}
}