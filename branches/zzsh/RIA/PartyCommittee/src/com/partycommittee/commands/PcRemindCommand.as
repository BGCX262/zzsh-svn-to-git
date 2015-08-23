package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcRemindEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcRemindProxy;

	
	import mx.rpc.IResponder;
	
	public class PcRemindCommand extends BaseCommand implements IResponder {
		public function PcRemindCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcRemindEvent = event as PcRemindEvent;
			var proxy:PcRemindProxy = getProxy();
			switch (evt.kind) {
				case PcRemindEvent.GET_REAL_REMIND_BY_ID :
					proxy.getRealRemindById(evt.agencyId, evt.year, evt.quarter);
					break;
				case PcRemindEvent.GET_REMIND_STAT_BY_ID : 
					proxy.getListRemindStatById(evt.agencyId, evt.year, evt.quarter);
					break;		
				case PcRemindEvent.GET_REMIND_STAT_BY_PARENTID_FOR_ADMIN : 
					proxy.getListRemindStatByParentIdForAdmin(evt.agencyId, evt.year, evt.quarter);
					break;
				case PcRemindEvent.GET_REMIND_NOCOMMIT_BY_PARENTID :
					proxy.getListRemindNoCommitByParentId(evt.agencyId, evt.year, evt.quarter, evt.typeId);
					break;
				case PcRemindEvent.GET_REMIND_BY_PARENTID :
					proxy.getListRemindByParentId(evt.agencyId, evt.year, evt.quarter, evt.typeId, evt.statusId);
					break;				
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcRemindProxy {
			return new PcRemindProxy(this);
		}
	}
}