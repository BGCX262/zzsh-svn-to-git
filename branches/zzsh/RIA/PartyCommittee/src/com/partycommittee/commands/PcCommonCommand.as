package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcCommonEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcCommonProxy;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class PcCommonCommand extends BaseCommand implements IResponder {
		public function PcCommonCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcCommonEvent = event as PcCommonEvent;
			var proxy:PcCommonProxy = getProxy();
			
			switch (evt.kind) {
				case PcCommonEvent.GET_MILLISECONDS:
					proxy.getMilliseconds();
					break;				
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcCommonProxy {
			return new PcCommonProxy(this);
		}
	}
}