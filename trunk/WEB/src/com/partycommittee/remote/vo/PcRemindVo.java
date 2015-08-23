package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcRemind;

public class PcRemindVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;

	private Integer agencyId;

	private Integer codeId;

	private String ext;

	private String name;
	
	private String code;

	private Integer parentId;
	
	private String parentName;

	private Integer quarter;

	private Integer statusId;

	private Integer typeId;

	private Integer year;	
	
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

	public Integer getCodeId() {
		return codeId;
	}

	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}

	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public static PcRemindVo fromPcRemind(PcRemind pevo) {
		PcRemindVo vo = new PcRemindVo();
		vo.setId(pevo.getId());
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setExt(pevo.getExt());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setParentName(pevo.getParentName());
		vo.setQuarter(pevo.getQuarter());
		vo.setStatusId(pevo.getStatusId());
		vo.setTypeId(pevo.getTypeId());
		vo.setYear(pevo.getYear());

		return vo;
	}
	
	public static PcRemind toPcRemind(PcRemindVo pevo) {
		PcRemind vo = new PcRemind();
		vo.setId(pevo.getId());
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setExt(pevo.getExt());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setParentName(pevo.getParentName());
		vo.setQuarter(pevo.getQuarter());
		vo.setStatusId(pevo.getStatusId());
		vo.setTypeId(pevo.getTypeId());
		vo.setYear(pevo.getYear());
		return vo;
	}
}
