package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcRemindConfigEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcRemindConfigProxy;
	
	
	import mx.rpc.IResponder;
	
	public class PcRemindConfigCommand extends BaseCommand implements IResponder {
		public function PcRemindConfigCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcRemindConfigEvent = event as PcRemindConfigEvent;
			var proxy:PcRemindConfigProxy = getProxy();
			switch (evt.kind) {
				case PcRemindConfigEvent.GET_REMIND_CONFIG_LIST :
					proxy.getRemindConfigLists();
					break;
				case PcRemindConfigEvent.UPDATE_REMIND_CONFIG : 
					proxy.updateItems(evt.items);
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
		
		protected function getProxy():PcRemindConfigProxy {
			return new PcRemindConfigProxy(this);
		}
	}
}