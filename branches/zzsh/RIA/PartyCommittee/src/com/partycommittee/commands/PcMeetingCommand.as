package com.partycommittee.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.partycommittee.events.PcMeetingEvent;
	import com.partycommittee.model.ModelLocator;
	import com.partycommittee.proxy.PcMeetingProxy;
	import com.partycommittee.util.CRUDEventType;
	import com.partycommittee.vo.PcMeetingVo;
	
	import mx.rpc.IResponder;
	
	public class PcMeetingCommand extends BaseCommand implements IResponder {
		public function PcMeetingCommand() {
		}
		
		override public function execute(event:CairngormEvent):void {
			super.execute(event);
			var pcMeetingEvt:PcMeetingEvent = event as PcMeetingEvent;
			var proxy:PcMeetingProxy = getProxy();
			var meeting:PcMeetingVo = pcMeetingEvt.meeting;
			switch (pcMeetingEvt.kind) {
				case PcMeetingEvent.GET_MEETING_LIST:
					proxy.getMeetingList(pcMeetingEvt.agency.id, pcMeetingEvt.year, pcMeetingEvt.meetingType);
					break;
				case PcMeetingEvent.GET_MEETING_CONTENT:
					proxy.getMeetingContent(meeting.id);
					break;
				case PcMeetingEvent.SUBMIT_MEETING:
					proxy.submitMeeting(meeting);
					break;
				case CRUDEventType.CREATE:
					proxy.createMeeting(meeting);
					break;
				case CRUDEventType.UPDATE:
					proxy.updateMeeting(meeting);
					break;
				case PcMeetingEvent.GET_COMMIT_CHILDREN_MEETING:
					proxy.getCommitChildrenMeeting(pcMeetingEvt.agency.id, pcMeetingEvt.year, pcMeetingEvt.filters );
					break;
				case PcMeetingEvent.GET_CONTENT_INFO:
					proxy.getContentInfo(pcMeetingEvt.meeting.id, pcMeetingEvt.meetingType);
					break;		
				case PcMeetingEvent.SAVE_CONTENT_MEETING:
					proxy.saveContentMeeting(pcMeetingEvt.meeting.id, pcMeetingEvt.meeting.statusId, pcMeetingEvt.meetingContent);
					break;									
				case PcMeetingEvent.GET_ALERT_INFO:
					proxy.getAlertInfo(pcMeetingEvt.agency.id, pcMeetingEvt.year, pcMeetingEvt.quarter);
					break;
				case PcMeetingEvent.GET_MEETING_COMMENT:
					proxy.getMeetingComment(pcMeetingEvt.meeting);
					break;
				case PcMeetingEvent.RETURN_MEETING:
					proxy.updateMeetingStatus(pcMeetingEvt.meeting.id, pcMeetingEvt.meeting.statusId);
					break;	
				case PcMeetingEvent.DELETE_MEETING:
					proxy.deleteMeeting(pcMeetingEvt.meeting.id);
					break;			
				default :
					break;
			}
		}
		
		public function result(data:Object):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pcMeetingEvt:PcMeetingEvent = event as PcMeetingEvent;
			switch (pcMeetingEvt.kind) {
				default:
					break;
			}
			onSuccess(data);
		}
		
		public function fault(info:Object):void {
			onFailure(info);
		}
		
		protected function getProxy():PcMeetingProxy {
			return new PcMeetingProxy(this);
		}
	}
}