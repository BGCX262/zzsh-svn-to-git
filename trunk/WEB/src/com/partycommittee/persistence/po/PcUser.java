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

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "pc_user")
public class PcUser implements java.io.Serializable {
	private static final long serialVersionUID = -6681204449740579597L;
	
	/** default constructor */
	public PcUser() {
	}
	
	private Long id;
	private String username;
	private String password;
	private String email;
	private String phone;
	private Integer status;
	private String comment;
	private Date lastlogintime;
	private String privilege;
	private Integer enableReport;
	private Integer agencyCodeId;
	
	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "username", unique = true, nullable = false, length = 50)
	public String getUsername() {
		return this.username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password", nullable = false)
	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name = "email")
	public String getEmail() {
		return this.email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	@Column(name = "phone")
	public String getPhone() {
		return this.phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "lastlogintime", length = 23)
	public Date getLastlogintime() {
		return this.lastlogintime;
	}
	public void setLastlogintime(Date lastlogintime) {
		this.lastlogintime = lastlogintime;
	}

	@Column(name = "status")
	public Integer getStatus() {
		return this.status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	@Column(name = "comment")
	public String getComment() {
		return this.comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@Column(name = "privilege")
	public String getPrivilege() {
		return this.privilege;
	}
	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}
	
	@Column(name = "enable_report")
	public Integer getEnableReport() {
		return enableReport;
	}
	public void setEnableReport(Integer enableReport) {
		this.enableReport = enableReport;
	}
	
	@Column(name = "agency_code_id")
	public Integer getAgencyCodeId() {
		return agencyCodeId;
	}
	public void setAgencyCodeId(Integer agencyCodeId) {
		this.agencyCodeId = agencyCodeId;
	}

}