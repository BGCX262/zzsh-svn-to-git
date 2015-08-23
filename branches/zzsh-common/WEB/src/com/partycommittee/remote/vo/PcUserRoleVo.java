package com.partycommittee.remote.vo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.partycommittee.persistence.po.PcUserRole;

public class PcUserRoleVo implements Serializable {
	private static final long serialVersionUID = -3609023388156250129L;
	
	private Integer id;
	private Long userId;
	private Integer roleId;

	public Integer getId() {
		return this.id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	
	public static PcUserRole toPcUserRole(PcUserRoleVo pevo) {
		PcUserRole vo = new PcUserRole();
		vo.setId(pevo.getId());
		vo.setUserId(pevo.getUserId());
		vo.setRoleId(pevo.getRoleId());
		return vo;
	}
	
	public static PcUserRoleVo fromPcUserRole(PcUserRole pevo) {
		PcUserRoleVo vo = new PcUserRoleVo();
		vo.setId(pevo.getId());
		vo.setUserId(pevo.getUserId());
		vo.setRoleId(pevo.getRoleId());
		return vo;
	}
}
