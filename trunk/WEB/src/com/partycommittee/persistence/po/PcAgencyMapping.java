package com.partycommittee.persistence.po;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pc_agency_mapping")
public class PcAgencyMapping implements java.io.Serializable {
	private static final long serialVersionUID = 5320714048775733668L;

	/** default constructor */
	public PcAgencyMapping() {
	}
	
	private Integer id;
	private Integer userId;
	private Integer agencyId;
	private String comment;
	
	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer getId() {
		return this.id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "user_id")
	public Integer getUserId() {
		return this.userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	@Column(name = "agency_id")
	public Integer getAgencyId() {
		return this.agencyId;
	}
	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}
	
	@Column(name = "comment")
	public String getComment() {
		return this.comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

}