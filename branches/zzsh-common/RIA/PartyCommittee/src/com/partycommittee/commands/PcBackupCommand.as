package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcBackupEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcBackupProxy;
	import com.partycommittee.util.CRUDEventType;
	
	import mx.rpc.IResponder;
	
	public class PcBackupCommand extends BaseCommand implements IResponder {
		public function PcBackupCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var pcBackupEvent:PcBackupEvent = event as PcBackupEvent;
			var pcBackupProxy:PcBackupProxy = getProxy();
			switch (pcBackupEvent.kind) {
				case CRUDEventType.CREATE:
					pcBackupProxy.createBackup();
					break;
				case CRUDEventType.DELETE:
					pcBackupProxy.deleteBackup(pcBackupEvent.backup.id);
					break;
				case PcBackupEvent.GET_BACKUP_LIST:
					pcBackupProxy.getBackups(pcBackupEvent.page);
					break;			
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pcBackupEvent:PcBackupEvent = event as PcBackupEvent;
			switch (pcBackupEvent.kind) {
				case CRUDEventType.CREATE:
					break;
				case CRUDEventType.DELETE:
					break;
				case PcBackupEvent.GET_BACKUP_LIST:
					break;
				default:
					break;
			}
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcBackupProxy {
			return new PcBackupProxy(this);
		}
	}
}