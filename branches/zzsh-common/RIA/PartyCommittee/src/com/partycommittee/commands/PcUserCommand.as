package com.partycommittee.commands
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.BaseEvent;
	import com.partycommittee.events.PcUserEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcUserProxy;
	import com.partycommittee.util.CRUDEventType;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.messaging.FlexClient;
	import mx.rpc.IResponder;
	import mx.utils.URLUtil;

	public class PcUserCommand extends BaseCommand implements IResponder {
		public function PcUserCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			var model:ModelLocator = ModelLocator.getInstance();
			super.execute(event);
			var pcUserEvent:PcUserEvent = event as PcUserEvent;
			var pcUserProxy:PcUserProxy = getProxy();
			switch (pcUserEvent.kind) {
				case CRUDEventType.CREATE:
					pcUserProxy.createPcUser(pcUserEvent.user);
					break;
				case CRUDEventType.DELETE:
					pcUserProxy.deletePcUsers(pcUserEvent.userList);
					break;
				case CRUDEventType.UPDATE:
					pcUserProxy.updatePcUser(pcUserEvent.user);
					break;
				case CRUDEventType.READ:
//					pcUserProxy.getPcUserList();
					if (pcUserEvent.agency.codeId == 6) {
						pcUserProxy.getPcUserListByPage(pcUserEvent.page);
					} else if (pcUserEvent.agency.codeId == 7 || pcUserEvent.agency.codeId == 8 || pcUserEvent.agency.codeId == 15) {
						pcUserProxy.getPcUserListByPageAndParentId(pcUserEvent.page, pcUserEvent.agency.id);
					} else {
						pcUserProxy.getPcUserListByPage(pcUserEvent.page, pcUserEvent.agency.id);
					}
//					if (pcUserEvent.agency) {
//						pcUserProxy.getPcUserListByPage(pcUserEvent.page, pcUserEvent.agency.id);
//					} else {
//						pcUserProxy.getPcUserListByPage(pcUserEvent.page);
//					}
					break;
				case PcUserEvent.LOGIN:
					pcUserProxy.login(pcUserEvent.user.username, pcUserEvent.user.password);
					break;
				case PcUserEvent.LOGOUT:
					pcUserProxy.userLogOut();
					break;
				case PcUserEvent.GET_SESSION:
					pcUserProxy.getLoginUser();
					break;
				case PcUserEvent.GET_ROLES:
					pcUserProxy.getRoleList();
					break;
				case PcUserEvent.CHECKONLY:
					pcUserProxy.checkUserOnly(pcUserEvent.user);
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pcUserEvent:PcUserEvent = event as PcUserEvent;
			switch (pcUserEvent.kind) {
				case CRUDEventType.CREATE:
					break;
				case CRUDEventType.DELETE:
					break;
				case CRUDEventType.UPDATE:
					break;
				case CRUDEventType.READ:
					break;
				case PcUserEvent.LOGIN:
					if (data) {
						navigateToURL(new URLRequest(model.INDEX_PAGE),"_top");
					} else {
						onFailure();
					}
					break;
				case PcUserEvent.LOGOUT:
					navigateToURL(new URLRequest(model.LOGIN_PAGE),"_top");
					break;
				case PcUserEvent.GET_SESSION:
					break;
				default:
					break;
			}
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcUserProxy {
			return new PcUserProxy(this);
		}
	}
}