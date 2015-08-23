package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;
	
	public class PcLicenseProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcLicense";
		
		public function PcLicenseProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}
		
		public function getLicense():void {
			service.getLicense();
		}
		
		public function setLicenseInfo(enstr:String, licensetips:String):void {
			service.setLicenseInfo(enstr, licensetips);
		}		
	}
}