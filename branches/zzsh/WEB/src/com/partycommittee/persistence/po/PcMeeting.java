package com.partycommittee.persistence.po;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "pc_meeting")
public class PcMeeting implements Serializable {
	private static final long serialVersionUID = -8668025942858634518L;
	
	private Integer id;
	private Integer agencyId;
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
	
	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "agency_id")
	public Integer getAgencyId() {
		return agencyId;
	}
	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}
	
	@Column(name = "type_id")
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	
	@Column(name = "year")
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	
	@Column(name = "quarter")
	public Integer getQuarter() {
		return quarter;
	}
	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}
	
	@Column(name = "month")
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	
	@Column(name = "week")
	public Integer getWeek() {
		return week;
	}
	public void setWeek(Integer week) {
		this.week = week;
	}
	
	@Column(name = "moderator")
	public String getModerator() {
		return moderator;
	}
	public void setModerator(String moderator) {
		this.moderator = moderator;
	}
	
	@Column(name = "theme")
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	
	@Column(name = "attend")
	public Integer getAttend() {
		return attend;
	}
	public void setAttend(Integer attend) {
		this.attend = attend;
	}
	
	@Column(name = "asence")
	public Integer getAsence() {
		return asence;
	}
	public void setAsence(Integer asence) {
		this.asence = asence;
	}
	
	@Column(name = "status_id")
	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	
	@Column(name = "active")
	public Integer getActive() {
		return active;
	}
	public void setActive(Integer active) {
		this.active = active;
	}
	
	@Column(name = "comment")
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "meeting_datetime")
	public Date getMeetingDatetime() {
		return meetingDatetime;
	}
	public void setMeetingDatetime(Date meetingDatetime) {
		this.meetingDatetime = meetingDatetime;
	}
	
	@Column(name = "meeting_name")
	public String getMeetingName() {
		return meetingName;
	}
	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}
}
