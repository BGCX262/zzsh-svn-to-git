package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcLicenseEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcLicenseProxy;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class PcLicenseCommand extends BaseCommand implements IResponder {
		public function PcLicenseCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var evt:PcLicenseEvent = event as PcLicenseEvent;
			var proxy:PcLicenseProxy = getProxy();
			
			switch (evt.kind) {
				case PcLicenseEvent.GET_LICENSE:
					proxy.getLicense();
					break;	
				case PcLicenseEvent.SET_LICENSE:
					proxy.setLicenseInfo(evt.enstr, evt.licensetips);
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
		
		protected function getProxy():PcLicenseProxy {
			return new PcLicenseProxy(this);
		}
	}
}