package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;

import com.partycommittee.persistence.po.PcMeeting;

public class PcMeetingVo implements Serializable {
	private static final long serialVersionUID = -4158070788187357500L;
	
	private Integer id;
	private Integer agencyId;
	private String agencyName;
	private Integer typeId;
	private Integer year;
	private Integer quarter;
	private Integer month;
	private Integer week;
	private String moderator;
	private String theme;
	private Integer attend;
	private Integer asence;
	private Integer statusId;
	private Integer active;
	private String comment;
	private Date meetingDatetime;
	private String meetingName;
		
	public String getMeetingName() {
		return meetingName;
	}

	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}

	public Date getMeetingDatetime() {
		return meetingDatetime;
	}

	public void setMeetingDatetime(Date meetingDatetime) {
		this.meetingDatetime = meetingDatetime;
	}

	private String asenceMemberIds;
		
	private PcMeetingContentVo content;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAgencyId() {
		return agencyId;
	}

	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}
	
	public String getAgencyName() {
		return agencyName;
	}

	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getQuarter() {
		return quarter;
	}

	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}

	public Integer getWeek() {
		return week;
	}

	public void setWeek(Integer week) {
		this.week = week;
	}
	
	public Integer getMonth() {
		return month;
	}
	
	public void setMonth(Integer month) {
		this.month = month;
	}

	public String getModerator() {
		return moderator;
	}

	public void setModerator(String moderator) {
		this.moderator = moderator;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public Integer getAttend() {
		return attend;
	}

	public void setAttend(Integer attend) {
		this.attend = attend;
	}

	public Integer getAsence() {
		return asence;
	}

	public void setAsence(Integer asence) {
		this.asence = asence;
	}

	public Integer getStatusId() {
		return statusId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getAsenceMemberIds() {
		return asenceMemberIds;
	}

	public void setAsenceMemberIds(String asenceMemberIds) {
		this.asenceMemberIds = asenceMemberIds;
	}

	public PcMeetingContentVo getContent() {
		return content;
	}

	public void setContent(PcMeetingContentVo content) {
		this.content = content;
	}
	
	public static PcMeeting toPcMeeting(PcMeetingVo meetingVo) {
		PcMeeting meeting = new PcMeeting();
		meeting.setActive(meetingVo.getActive());
		meeting.setAgencyId(meetingVo.getAgencyId());
		meeting.setAsence(meetingVo.getAsence());
		meeting.setAttend(meetingVo.getAttend());
		meeting.setComment(meetingVo.getComment());
		meeting.setId(meetingVo.getId());
		meeting.setModerator(meetingVo.getModerator());
		meeting.setQuarter(meetingVo.getQuarter());
		meeting.setStatusId(meetingVo.getStatusId());
		meeting.setTheme(meetingVo.getTheme());
		meeting.setTypeId(meetingVo.getTypeId());
		meeting.setWeek(meetingVo.getWeek());
		meeting.setYear(meetingVo.getYear());
		meeting.setMeetingDatetime(meetingVo.getMeetingDatetime());
		meeting.setMeetingName(meetingVo.getMeetingName());
		meeting.setMonth(meetingVo.getMonth());
		return meeting;
	}
	
	public static PcMeetingVo fromPcMeeting(PcMeeting meeting) {
		PcMeetingVo meetingVo = new PcMeetingVo();
		meetingVo.setActive(meeting.getActive());
		meetingVo.setAgencyId(meeting.getAgencyId());
		meetingVo.setAsence(meeting.getAsence());
		meetingVo.setAttend(meeting.getAttend());
		meetingVo.setComment(meeting.getComment());
		meetingVo.setId(meeting.getId());
		meetingVo.setModerator(meeting.getModerator());
		meetingVo.setQuarter(meeting.getQuarter());
		meetingVo.setStatusId(meeting.getStatusId());
		meetingVo.setTheme(meeting.getTheme());
		meetingVo.setTypeId(meeting.getTypeId());
		meetingVo.setWeek(meeting.getWeek());
		meetingVo.setYear(meeting.getYear());
		meetingVo.setMeetingDatetime(meeting.getMeetingDatetime());
		meetingVo.setMeetingName(meeting.getMeetingName());
		meetingVo.setMonth(meeting.getMonth());
		return meetingVo;
	}
}
