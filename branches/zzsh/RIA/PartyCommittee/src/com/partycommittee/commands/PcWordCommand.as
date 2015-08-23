package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcWordEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcWordProxy;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class PcWordCommand extends BaseCommand implements IResponder {
		public function PcWordCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcWordEvent = event as PcWordEvent;
			var proxy:PcWordProxy = getProxy();

			switch (evt.kind) {
				case PcWordEvent.EXPORT_WORD_ALL:
					proxy.exportDocForAll(evt.agencyId, evt.year);
					break;
				
				case PcWordEvent.EXPORT_WORD_FOR_WORKPLAN:
					proxy.exportDocForWorkPlan(evt.zid);
					break;
				
				case PcWordEvent.EXPORT_WORD_FOR_MEETING:
					proxy.exportDocForMeeting(evt.zid);
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
		
		protected function getProxy():PcWordProxy {
			return new PcWordProxy(this);
		}
	}
}