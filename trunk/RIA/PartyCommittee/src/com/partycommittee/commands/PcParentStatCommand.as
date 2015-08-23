package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcParentStatEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcParentStatProxy;

	import mx.rpc.IResponder;
	
	public class PcParentStatCommand extends BaseCommand implements IResponder {
		public function PcParentStatCommand() {
			
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcParentStatEvent = event as PcParentStatEvent;
			var proxy:PcParentStatProxy = getProxy();
			switch (evt.kind) {
				case PcParentStatEvent.GET_LIST_STAT_BY_PARENT :
					proxy.getListStatByParentId(evt.agencyId, evt.year, evt.quarter);
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
		
		protected function getProxy():PcParentStatProxy {
			return new PcParentStatProxy(this);
		}
	}
}