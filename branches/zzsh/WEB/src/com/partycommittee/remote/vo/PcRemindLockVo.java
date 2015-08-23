package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.partycommittee.persistence.po.PcRemindLock;

public class PcRemindLockVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;

	private Integer agencyId;

	private Integer codeId;

	private String ext;

	private String name;
	
	private String code;

	private Integer parentId;

	private Integer quarter;
	
	private Integer month;

	private Integer statusId;

	private Integer typeId;

	private Integer year;
	
	private String delayDate;

	public PcRemindLockVo() {
		
    }

	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)	    
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAgencyId() {
		return this.agencyId;
	}

	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}

	public Integer getCodeId() {
		return this.codeId;
	}

	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}

	public String getExt() {
		return this.ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	public Integer getQuarter() {
		return this.quarter;
	}

	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}		

	public Integer getMonth() {
		return this.month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}
	
	public Integer getStatusId() {
		return this.statusId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}

	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getYear() {
		return this.year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

    public String getDelayDate() {
		return delayDate;
	}

	public void setDelayDate(String delayDate) {
		this.delayDate = delayDate;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}	
	
	public static PcRemindLockVo fromPcRemindLock(PcRemindLock pevo) {
		PcRemindLockVo vo = new PcRemindLockVo();
		vo.setId(pevo.getId());
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setExt(pevo.getExt());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setQuarter(pevo.getQuarter());
		vo.setMonth(pevo.getMonth());
		vo.setStatusId(pevo.getStatusId());
		vo.setTypeId(pevo.getTypeId());
		vo.setYear(pevo.getYear());
		vo.setDelayDate(pevo.getDelayDate());
		return vo;
	}
	
	public static PcRemindLock toPcRemindLock(PcRemindLockVo pevo) {
		PcRemindLock vo = new PcRemindLock();
		vo.setId(pevo.getId());
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setExt(pevo.getExt());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setQuarter(pevo.getQuarter());
		vo.setMonth(pevo.getMonth());
		vo.setStatusId(pevo.getStatusId());
		vo.setTypeId(pevo.getTypeId());
		vo.setYear(pevo.getYear());
		vo.setDelayDate(pevo.getDelayDate());
		return vo;
	}
}
