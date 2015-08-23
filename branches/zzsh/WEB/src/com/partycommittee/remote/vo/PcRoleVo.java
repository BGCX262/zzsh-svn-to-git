package com.partycommittee.remote.vo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.partycommittee.persistence.po.PcRole;

public class PcRoleVo implements Serializable {
	private static final long serialVersionUID = -3609023388156250129L;
	
	private Integer id;
	private String role;
	private String name;
	private Integer enable;

	
	public Integer getId() {
		return this.id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	

	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}	

	public Integer getEnable() {
		return enable;
	}
	public void setEnable(Integer enable) {
		this.enable = enable;
	}	
	
	public static PcRole toPcRole(PcRoleVo pevo) {
		PcRole vo = new PcRole();
		vo.setId(pevo.getId());
		vo.setRole(pevo.getRole());
		vo.setName(pevo.getName());
		vo.setEnable(pevo.getEnable());
		return vo;
	}
	
	public static PcRoleVo fromPcRole(PcRole pevo) {
		PcRoleVo vo = new PcRoleVo();
		vo.setId(pevo.getId());
		vo.setRole(pevo.getRole());
		vo.setName(pevo.getName());
		vo.setEnable(pevo.getEnable());
		return vo;
	}
}
