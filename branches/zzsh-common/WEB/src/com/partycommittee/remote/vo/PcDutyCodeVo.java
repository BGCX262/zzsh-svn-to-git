package com.partycommittee.remote.vo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.partycommittee.persistence.po.PcDutyCode;

public class PcDutyCodeVo implements Serializable {
	private static final long serialVersionUID = -3609023388156250129L;
	
	private Integer id;
	private String code;
	private String description;

	
	public Integer getId() {
		return this.id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public static PcDutyCode toPcDutyCode(PcDutyCodeVo pevo) {
		PcDutyCode vo = new PcDutyCode();
		vo.setId(pevo.getId());
		vo.setCode(pevo.getCode());
		vo.setDescription(pevo.getDescription());
		return vo;
	}
	
	public static PcDutyCodeVo fromPcRole(PcDutyCode pevo) {
		PcDutyCodeVo vo = new PcDutyCodeVo();
		vo.setId(pevo.getId());
		vo.setCode(pevo.getCode());
		vo.setDescription(pevo.getDescription());
		return vo;
	}
}
