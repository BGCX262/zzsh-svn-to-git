package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class PcCommonProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcCommon";
		
		public function PcCommonProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getMilliseconds():void {
			service.getMilliseconds(new Date().time);
		}
	}
}