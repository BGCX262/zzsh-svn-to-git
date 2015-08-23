package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcRemindLockEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcRemindLockProxy;

	import mx.rpc.IResponder;
	
	public class PcRemindLockCommand extends BaseCommand implements IResponder {
		public function PcRemindLockCommand() {
			
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcRemindLockEvent = event as PcRemindLockEvent;
			var proxy:PcRemindLockProxy = getProxy();
			switch (evt.kind) {
				case PcRemindLockEvent.GET_REMIND_LOCK_BY_FILTERS :
					proxy.getRemindLockByFilters(evt.filters, evt.page);
					break;
				case PcRemindLockEvent.UPDATE_REMIND_LOCK : 
					proxy.updateItem(evt.pcRemindLockVo);
					break;
				case PcRemindLockEvent.GET_REMIND_LOCK_BY_ID :
					proxy.getRemindLockById(evt.agencyId, evt.year, evt.quarter, evt.month, evt.typeId);
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
		
		protected function getProxy():PcRemindLockProxy {
			return new PcRemindLockProxy(this);
		}
	}
}