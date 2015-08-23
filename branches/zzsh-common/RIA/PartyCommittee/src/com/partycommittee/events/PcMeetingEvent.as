package com.partycommittee.events
{
	import com.partycommittee.vo.PcAgencyVo;
	import com.partycommittee.vo.PcMeetingContentVo;
	import com.partycommittee.vo.PcMeetingVo;
	
	public class PcMeetingEvent extends BaseEvent {
		public static const PCMEETING_EVENT:String = "com.partycommittee.events.PcMeetingEvent";
		
		public static const GET_MEETING_LIST:String = "getMeetingList";
		
		public static const GET_TEAM_LIST:String = "getTeamList";
		public static const GET_CONTENT_INFO:String = "getContentInfo";
		
		public static const GET_COMMIT_CHILDREN_MEETING:String = "getCommitChildrenMeeting";
		
		public static const GET_MEETING_CONTENT:String = "getMeetingContent";
		public static const SUBMIT_MEETING:String = "submitMeeting";
		
		public static const SAVE_CONTENT_MEETING:String = "saveContentMeeting";
		public static const RETURN_MEETING:String = "returnMeeting";
		
		public static const GET_MEETING_COMMENT:String = "getMeetingComment";
		public static const GET_ALERT_INFO:String = "getAlertInfo";
		public static const DELETE_MEETING:String = "deleteMeeting";
		
		public static const EXPORT_MEETING_TO_DOC:String = "exportMeetingToDoc";
		
		private var _agency:PcAgencyVo;

		public function set agency(value:PcAgencyVo):void {
			this._agency = value;
		}
		public function get agency():PcAgencyVo {
			return this._agency;
		}
		
		private var _meeting:PcMeetingVo;
		public function set meeting(value:PcMeetingVo):void {
			this._meeting = value;
		}
		public function get meeting():PcMeetingVo {
			return this._meeting;
		}
		
		private var _year:Number;
		public function set year(value:Number):void {
			this._year = value;
		}
		public function get year():Number {
			return this._year;
		}
		
		private var _quarter:Number;
		public function set quarter(value:Number):void {
			this._quarter = value;
		}
		public function get quarter():Number {
			return this._quarter;
		}
		
		private var _meetingContent:PcMeetingContentVo;
		public function set meetingContent(value:PcMeetingContentVo):void {
			this._meetingContent = value;
		}
		public function get meetingContent():PcMeetingContentVo {
			return this._meetingContent;
		}
		
		private var _kind:String;
		public function set kind(value:String):void {
			this._kind = value;
		}
		public function get kind():String {
			return this._kind;
		}
		
		private var _meetingType:Number;
		
		public function get meetingType():Number
		{
			return _meetingType;
		}
		
		public function set meetingType(value:Number):void
		{
			_meetingType = value;
		}
		
		private var _filters:Array;
		public function get filters():Array	{
			return _filters;
		}
		
		public function set filters(value:Array):void {
			_filters = value;
		}			
		
		public function PcMeetingEvent(kind:String = "READ", agency:PcAgencyVo = null) {
			super(PCMEETING_EVENT);
			this.agency = agency;
			this.kind = kind;
		}
	}
}