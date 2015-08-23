package com.partycommittee.proxy
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.partycommittee.vo.PcMeetingContentVo;
	import com.partycommittee.vo.PcMeetingVo;
	
	import mx.rpc.IResponder;
	
	public class PcMeetingProxy extends BaseProxy {
		public static const SERVICE_NAME:String = "pcMeeting";
		
		public function PcMeetingProxy(responder:IResponder) {
			service = ServiceLocator.getInstance().getRemoteObject(SERVICE_NAME);
			this.responder = responder;
		}

		public function getMeetingList(agencyId:Number, year:Number, meetingType:Number):void {
			service.getMeetingList(agencyId, year, meetingType);
		}		

		public function getMeetingContent(meetingId:Number):void {
			service.getMeetingContent(meetingId);
		}

		public function submitMeeting(meeting:PcMeetingVo):void {
			service.submitMeeting(meeting);
		}
		
		public function createMeeting(meeting:PcMeetingVo):void {
			service.createMeeting(meeting);
		}
		
		public function updateMeeting(meeting:PcMeetingVo):void {
			service.updateMeeting(meeting);
		}
		
		public function getCommitChildrenMeeting(agencyId:Number, year:Number, filters:Array):void {
			service.getCommitChildrenMeeting(agencyId, year, filters);
		}
		
		public function getContentInfo(meetingId:Number, meetingType:Number):void {
			service.getContentInfo(meetingId, meetingType);
		}		
		
		public function saveContentMeeting(meetingId:Number, statusId:Number, content:PcMeetingContentVo):void {
			service.saveContentMeeting(meetingId, statusId, content);
		}		
		
		public function getAlertInfo(agencyId:Number, year:Number, quarter:Number):void {
			service.getAlertInfo(agencyId, year, quarter);
		}
		
		public function getMeetingComment(meeting:PcMeetingVo):void {
			service.getMeetingComment(meeting);
		}
		
		public function updateMeetingStatus(meetingId:Number, statusId:Number):void {
			service.updateMeetingStatus(meetingId, statusId);
		}	
		
		public function deleteMeeting(meetingId:Number):void {
			service.deleteMeeting(meetingId);
		}	
		
		public function exportMeetingToDoc(meetingId:Number):void {
			service.exportMeetingToDoc(meetingId);
		}		
		
	}
}