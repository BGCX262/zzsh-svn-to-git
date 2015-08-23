package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;	
	import mx.rpc.IResponder;
	
	public class PcRemindConfigProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcRemindConfig";
		
		public function PcRemindConfigProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}

		public function getRemindConfigLists():void {
			service.getRemindConfigLists();
		}
		
		public function updateItems(items:Array):void {
			service.updateItems(items);
		}		

	}
}