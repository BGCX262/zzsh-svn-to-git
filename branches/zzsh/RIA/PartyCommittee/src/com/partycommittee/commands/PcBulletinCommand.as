package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcBulletinEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcBulletinProxy;
	import com.partycommittee.util.CRUDEventType;
	
	import mx.rpc.IResponder;
	
	public class PcBulletinCommand extends BaseCommand implements IResponder {
		public function PcBulletinCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var pcBulletinEvent:PcBulletinEvent = event as PcBulletinEvent;
			var pcBulletinProxy:PcBulletinProxy = getProxy();
			switch (pcBulletinEvent.kind) {
				case CRUDEventType.CREATE:
					pcBulletinProxy.createBulletin(pcBulletinEvent.bulletin);
					break;
				case CRUDEventType.DELETE:
					pcBulletinProxy.deleteBulletin(pcBulletinEvent.bulletin.id);
					break;
				case CRUDEventType.UPDATE:
					pcBulletinProxy.updateBulletin(pcBulletinEvent.bulletin);
					break;
				case PcBulletinEvent.GET_BULLETIN_LIST:
					pcBulletinProxy.getBulletins(pcBulletinEvent.page);
					break;			
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pcBulletinEvent:PcBulletinEvent = event as PcBulletinEvent;
			switch (pcBulletinEvent.kind) {
				case CRUDEventType.CREATE:
					break;
				case CRUDEventType.DELETE:
					break;
				case CRUDEventType.UPDATE:
					break;
				case PcBulletinEvent.GET_BULLETIN_LIST:
					break;
				default:
					break;
			}
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcBulletinProxy {
			return new PcBulletinProxy(this);
		}
	}
}