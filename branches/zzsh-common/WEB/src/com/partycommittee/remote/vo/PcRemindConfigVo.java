package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.partycommittee.persistence.po.PcRemindConfig;;

public class PcRemindConfigVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;

	private Integer typeId;
	
	private Integer value;

	private Integer startYear;

	private Integer startQuarter;	

	private Integer startMonth;

	private Integer startDay;	

	private Integer endYear;

	private Integer endQuarter;	

	private Integer endMonth;

	private Integer endDay;	
	
	private Integer delayDay;	

	public PcRemindConfigVo() {
		
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
	
	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
	
	public Integer getStartYear() {
		return startYear;
	}

	public void setStartYear(Integer startYear) {
		this.startYear = startYear;
	}

	public Integer getStartQuarter() {
		return startQuarter;
	}

	public void setStartQuarter(Integer startQuarter) {
		this.startQuarter = startQuarter;
	}

	public Integer getStartMonth() {
		return startMonth;
	}

	public void setStartMonth(Integer startMonth) {
		this.startMonth = startMonth;
	}

	public Integer getStartDay() {
		return startDay;
	}

	public void setStartDay(Integer startDay) {
		this.startDay = startDay;
	}
	
	public Integer getEndYear() {
		return endYear;
	}

	public void setEndYear(Integer endYear) {
		this.endYear = endYear;
	}

	public Integer getEndQuarter() {
		return endQuarter;
	}

	public void setEndQuarter(Integer endQuarter) {
		this.endQuarter = endQuarter;
	}

	public Integer getEndMonth() {
		return endMonth;
	}

	public void setEndMonth(Integer endMonth) {
		this.endMonth = endMonth;
	}

	public Integer getEndDay() {
		return endDay;
	}

	public void setEndDay(Integer endDay) {
		this.endDay = endDay;
	}	
	
    public Integer getDelayDay() {
		return delayDay;
	}

	public void setDelayDay(Integer delayDay) {
		this.delayDay = delayDay;
	}		
	
	public static PcRemindConfigVo fromPcRemindLock(PcRemindConfig pevo) {
		PcRemindConfigVo vo = new PcRemindConfigVo();
		vo.setId(pevo.getId());
		vo.setTypeId(pevo.getTypeId());
		vo.setValue(pevo.getValue());
		vo.setStartYear(pevo.getStartYear());
		vo.setStartQuarter(pevo.getStartQuarter());
		vo.setStartMonth(pevo.getStartMonth());
		vo.setStartDay(pevo.getStartDay());
		vo.setEndYear(pevo.getEndYear());
		vo.setEndQuarter(pevo.getEndQuarter());
		vo.setEndMonth(pevo.getEndMonth());
		vo.setEndDay(pevo.getEndDay());
		vo.setDelayDay(pevo.getDelayDay());
		return vo;
	}
	
	public static PcRemindConfig toPcRemindLock(PcRemindConfigVo pevo) {
		PcRemindConfig vo = new PcRemindConfig();
		vo.setId(pevo.getId());
		vo.setTypeId(pevo.getTypeId());
		vo.setValue(pevo.getValue());
		vo.setStartYear(pevo.getStartYear());
		vo.setStartQuarter(pevo.getStartQuarter());
		vo.setStartMonth(pevo.getStartMonth());
		vo.setStartDay(pevo.getStartDay());
		vo.setEndYear(pevo.getEndYear());
		vo.setEndQuarter(pevo.getEndQuarter());
		vo.setEndMonth(pevo.getEndMonth());
		vo.setEndDay(pevo.getEndDay());
		vo.setDelayDay(pevo.getDelayDay());
		return vo;
	}
}
