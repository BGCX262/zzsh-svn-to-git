package com.partycommittee.persistence.po;

import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pc_member")
public class PcMember implements java.io.Serializable {
	private static final long serialVersionUID = -5509274895612525964L;

	/** default constructor */
	public PcMember() {
	}
	
	private Integer id;
	private Integer agencyId;
	private Integer postId;
	private String name;
	private Integer sexId;
	private Integer nationId;
	private Date birthday;
	private Date workday;
	private Date joinday;
	private Date postday;
	private Integer eduId;
	private String birthPlace;
	private String address;
	private Integer dutyId;
	private String adminDuty;
	private String ext;
	private Integer active;
	private Date updatetime;
	private String comment;
	private Integer sort;
	
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
		return this.agencyId;
	}
	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}
	
	@Column(name = "post_id")
	public Integer getPostId() {
		return this.postId;
	}
	public void setPostId(Integer postId) {
		this.postId = postId;
	}
	
	@Column(name = "name")
	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name = "sex_id")
	public Integer getSexId() {
		return this.sexId;
	}
	public void setSexId(Integer sexId) {
		this.sexId = sexId;
	}
	
	@Column(name = "nation_id")
	public Integer getNationId() {
		return this.nationId;
	}
	public void setNationId(Integer nationId) {
		this.nationId = nationId;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "birthday", length = 23)
	public Date getBirthday() {
		return this.birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "workday", length = 23)
	public Date getWorkday() {
		return this.workday;
	}
	public void setWorkday(Date workday) {
		this.workday = workday;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "joinday", length = 23)
	public Date getJoinday() {
		return this.joinday;
	}
	public void setJoinday(Date joinday) {
		this.joinday = joinday;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "postday", length = 23)
	public Date getPostday() {
		return this.postday;
	}
	public void setPostday(Date postday) {
		this.postday = postday;
	}
	
	@Column(name = "edu_id")
	public Integer getEduId() {
		return this.eduId;
	}
	public void setEduId(Integer eduId) {
		this.eduId = eduId;
	}
	
	@Column(name = "birthplace")
	public String getBirthPlace() {
		return this.birthPlace;
	}
	public void setBirthPlace(String birthPlace) {
		this.birthPlace = birthPlace;
	}
	
	@Column(name = "address")
	public String getAddress() {
		return this.address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	@Column(name = "duty_id")
	public Integer getDutyId() {
		return this.dutyId;
	}
	public void setDutyId(Integer dutyId) {
		this.dutyId = dutyId;
	}
	
	@Column(name = "admin_duty")
	public String getAdminDuty() {
		return this.adminDuty;
	}
	public void setAdminDuty(String adminDuty) {
		this.adminDuty = adminDuty;
	}
	
	@Column(name = "ext")
	public String getExt() {
		return this.ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	
	@Column(name = "active")
	public Integer getActive() {
		return this.active;
	}
	public void setActive(Integer active) {
		this.active = active;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "updatetime", length = 23)
	public Date getUpdatetime() {
		return this.updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
	@Column(name = "comment")
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@Column(name = "sort")
	public Integer getSort() {
		return this.sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
}