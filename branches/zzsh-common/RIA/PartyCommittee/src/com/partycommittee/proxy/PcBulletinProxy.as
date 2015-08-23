package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcBulletinVo;
	import com.partycommittee.vo.page.PageHelperVo;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class PcBulletinProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcBulletin";
		
		public function PcBulletinProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getBulletins(page:PageHelperVo):void {
			service.getBulletins(page);
		}
		
		public function createBulletin(vo:PcBulletinVo):void {
			service.createBulletin(vo);
		}
		
		public function deleteBulletin(id:Number):void {
			service.deleteBulletin(id);
		}
		
		public function updateBulletin(vo:PcBulletinVo):void {
			service.updateBulletin(vo);
		}
		
		
	}
}