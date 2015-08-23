package com.partycommittee.remote.vo;

import java.io.Serializable;

import com.partycommittee.persistence.po.PcAgencyRelation;

public class PcAgencyRelationVo implements Serializable {
	private static final long serialVersionUID = -3609023388156250129L;
	
	private Integer id;
	private Integer agencyId;
	private Integer parentId;
	private String comment;
	
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
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public static PcAgencyRelation toPcAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		PcAgencyRelation agencyRelation = new PcAgencyRelation();
		agencyRelation.setAgencyId(agencyRelationVo.getAgencyId());
		agencyRelation.setComment(agencyRelationVo.getComment());
		agencyRelation.setId(agencyRelationVo.getId());
		agencyRelation.setParentId(agencyRelationVo.getParentId());
		return agencyRelation;
	}
	
	public static PcAgencyRelationVo fromPcAgencyRelation(PcAgencyRelation agencyRelation) {
		PcAgencyRelationVo agencyRelationVo = new PcAgencyRelationVo();
		agencyRelationVo.setAgencyId(agencyRelation.getAgencyId());
		agencyRelationVo.setComment(agencyRelation.getComment());
		agencyRelationVo.setId(agencyRelation.getId());
		agencyRelationVo.setParentId(agencyRelation.getParentId());
		return agencyRelationVo;
	}
}
