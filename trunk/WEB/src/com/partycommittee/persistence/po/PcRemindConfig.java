package com.partycommittee.persistence.po;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Date;


/**
 * The persistent class for the pc_remind database table.
 * 
 */
@Entity
@Table(name="pc_remind_config")
public class PcRemindConfig implements Serializable {
	private static final long serialVersionUID = 485572770621967501L;

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
	

	public PcRemindConfig() {
    	
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
	
	@Column(name = "type_id")
	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	@Column(name = "value")
	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
	
	@Column(name = "start_year")
	public Integer getStartYear() {
		return startYear;
	}

	public void setStartYear(Integer startYear) {
		this.startYear = startYear;
	}

	@Column(name = "start_quarter")
	public Integer getStartQuarter() {
		return startQuarter;
	}

	public void setStartQuarter(Integer startQuarter) {
		this.startQuarter = startQuarter;
	}

	@Column(name = "start_month")
	public Integer getStartMonth() {
		return startMonth;
	}

	public void setStartMonth(Integer startMonth) {
		this.startMonth = startMonth;
	}

	@Column(name = "start_day")
	public Integer getStartDay() {
		return startDay;
	}

	public void setStartDay(Integer startDay) {
		this.startDay = startDay;
	}
	
	@Column(name = "end_year")
	public Integer getEndYear() {
		return endYear;
	}

	public void setEndYear(Integer endYear) {
		this.endYear = endYear;
	}

	@Column(name = "end_quarter")	
	public Integer getEndQuarter() {
		return endQuarter;
	}

	public void setEndQuarter(Integer endQuarter) {
		this.endQuarter = endQuarter;
	}

	@Column(name = "end_month")	
	public Integer getEndMonth() {
		return endMonth;
	}

	public void setEndMonth(Integer endMonth) {
		this.endMonth = endMonth;
	}

	@Column(name = "end_day")	
	public Integer getEndDay() {
		return endDay;
	}

	public void setEndDay(Integer endDay) {
		this.endDay = endDay;
	}	
	
	@Column(name = "delay_day")	
    public Integer getDelayDay() {
		return delayDay;
	}

	public void setDelayDay(Integer delayDay) {
		this.delayDay = delayDay;
	}	
}