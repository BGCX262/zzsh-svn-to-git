package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.partycommittee.persistence.po.PcUser;

public class PcUserVo implements Serializable {
	private static final long serialVersionUID = -8851610779875472544L;
	
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
	
	private List<PcAgencyVo> agencyList;
	private List<Integer> roles;
	
	
	public List<Integer> getRoles() {
		return roles;
	}

	public void setRoles(List<Integer> roles) {
		this.roles = roles;
	}

	public List<PcAgencyVo> getAgencyList() {
		return agencyList;
	}

	public void setAgencyList(List<PcAgencyVo> agencyList) {
		this.agencyList = agencyList;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getLastlogintime() {
		return lastlogintime;
	}

	public void setLastlogintime(Date lastlogintime) {
		this.lastlogintime = lastlogintime;
	}
	
	public String getPrivilege() {
		return this.privilege;
	}
	
	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}
	
	public Integer getEnableReport() {
		return enableReport;
	}
	public void setEnableReport(Integer enableReport) {
		this.enableReport = enableReport;
	}
	
	public Integer getAgencyCodeId() {
		return agencyCodeId;
	}

	public void setAgencyCodeId(Integer agencyCodeId) {
		this.agencyCodeId = agencyCodeId;
	}

	public static PcUserVo fromPCUser(PcUser user) {
		PcUserVo pcUserVo = new PcUserVo();
		pcUserVo.setId(user.getId());
		pcUserVo.setUsername(user.getUsername());
		pcUserVo.setPassword(user.getPassword());
		pcUserVo.setEmail(user.getEmail());
		pcUserVo.setPhone(user.getPhone());
		pcUserVo.setStatus(user.getStatus());
		pcUserVo.setComment(user.getComment());
		pcUserVo.setLastlogintime(user.getLastlogintime());
		pcUserVo.setPrivilege(user.getPrivilege());
		pcUserVo.setEnableReport(user.getEnableReport());
		pcUserVo.setAgencyCodeId(user.getAgencyCodeId());
		return pcUserVo;
	}
	
	public static PcUser toPCUser(PcUserVo pcUserVo) {
		PcUser pcUser = new PcUser();
		pcUser.setId(pcUserVo.getId());
		pcUser.setUsername(pcUserVo.getUsername());
		pcUser.setPassword(pcUserVo.getPassword());
		pcUser.setEmail(pcUserVo.getEmail());
		pcUser.setPhone(pcUserVo.getPhone());
		pcUser.setStatus(pcUserVo.getStatus());
		pcUser.setComment(pcUserVo.getComment());
		pcUser.setLastlogintime(pcUserVo.getLastlogintime());
		pcUser.setPrivilege(pcUserVo.getPrivilege());
		pcUser.setEnableReport(pcUserVo.getEnableReport());
		pcUser.setAgencyCodeId(pcUserVo.getAgencyCodeId());
		return pcUser;
	}

}
