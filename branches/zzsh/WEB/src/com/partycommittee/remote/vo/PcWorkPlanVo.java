package com.partycommittee.remote.vo;

import java.io.Serializable;

import com.partycommittee.persistence.po.PcWorkPlan;

public class PcWorkPlanVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;
	private Integer agencyId;
	private String  agencyName;
	private Integer typeId;
	private Integer year;
	private Integer quarter;
	private Integer statusId;
	private Integer active;
	
	private PcWorkPlanContentVo workPlanContent;

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

	public PcWorkPlanContentVo getWorkPlanContent() {
		return workPlanContent;
	}

	public void setWorkPlanContent(PcWorkPlanContentVo workPlanContent) {
		this.workPlanContent = workPlanContent;
	}
	
	public static PcWorkPlanVo fromPcWorkPlan(PcWorkPlan workPlan) {
		PcWorkPlanVo workPlanVo = new PcWorkPlanVo();
		workPlanVo.setActive(workPlan.getActive());
		workPlanVo.setTypeId(workPlan.getTypeId());
		workPlanVo.setId(workPlan.getId());
		workPlanVo.setAgencyId(workPlan.getAgencyId());
		workPlanVo.setQuarter(workPlan.getQuarter());
		workPlanVo.setStatusId(workPlan.getStatusId());
		workPlanVo.setYear(workPlan.getYear());
		return workPlanVo;
	}
	
	public static PcWorkPlan toPcWorkPlan(PcWorkPlanVo workPlanVo) {
		PcWorkPlan workPlan = new PcWorkPlan();
		workPlan.setActive(workPlanVo.getActive());
		workPlan.setTypeId(workPlanVo.getTypeId());
		workPlan.setAgencyId(workPlanVo.getAgencyId());
		workPlan.setId(workPlanVo.getId());
		workPlan.setQuarter(workPlanVo.getQuarter());
		workPlan.setStatusId(workPlanVo.getStatusId());
		workPlan.setYear(workPlanVo.getYear());
		return workPlan;
	}
}
