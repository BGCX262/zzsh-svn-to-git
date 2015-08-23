package com.partycommittee.remote.vo;

import java.io.Serializable;

import com.partycommittee.persistence.po.PcAgencyMapping;

public class PcAgencyMappingVo implements Serializable {
	private static final long serialVersionUID = -8999956772237440214L;
	
	private Integer id;
	private Integer userId;
	private Integer agencyId;
	private String comment;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getAgencyId() {
		return agencyId;
	}
	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public static PcAgencyMapping toPcAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		PcAgencyMapping agencyMapping = new PcAgencyMapping();
		agencyMapping.setAgencyId(agencyMappingVo.getAgencyId());
		agencyMapping.setComment(agencyMappingVo.getComment());
		agencyMapping.setId(agencyMappingVo.getId());
		agencyMapping.setUserId(agencyMappingVo.getUserId());
		return agencyMapping;
	}
	
	public static PcAgencyMappingVo fromPcAgencyMapping(PcAgencyMapping agencyMapping) {
		PcAgencyMappingVo agencyMappingVo = new PcAgencyMappingVo();
		agencyMappingVo.setAgencyId(agencyMapping.getAgencyId());
		agencyMappingVo.setComment(agencyMapping.getComment());
		agencyMappingVo.setId(agencyMapping.getId());
		agencyMappingVo.setUserId(agencyMapping.getUserId());
		return agencyMappingVo;
	}
}
