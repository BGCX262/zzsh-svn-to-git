package com.partycommittee.persistence.po;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Date;


/**
 * The persistent class for the pc_remind_stat database table.
 * 
 */
@Entity
@Table(name="pc_parent_stat")
public class PcParentStat implements Serializable {
	private static final long serialVersionUID = 485572770721967499L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private Integer agencyId;

	private Integer codeId;

	private String name;
	
	private String code;

	private Integer parentId;

	private Integer quarter;

	private Integer typeId;

	private Integer year;

	private Integer total;
	
	private Integer reported;
	
	private Integer delay;

	private Double reportedRate;
	
	private Integer eva;
	
	private Double evaRate;
	
	private Integer attend;
	
	private Integer asence;
	
	private Double  attendRate;
	
	private Integer pCount;
	
	private Integer zbNum;

	private Integer zbsjNum;

	private Integer agencyNum;
	
	private Integer agencyGoodjob;
	
	public PcParentStat() {
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

	@Column(name = "agency_id")
	public Integer getAgencyId() {
		return this.agencyId;
	}

	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}

	@Column(name = "code_id")
	public Integer getCodeId() {
		return this.codeId;
	}

	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "parent_id")
	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Column(name = "quarter")
	public Integer getQuarter() {
		return this.quarter;
	}

	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}

	@Column(name = "type_id")
	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	@Column(name = "year")
	public Integer getYear() {
		return this.year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}
	
	@Column(name = "total")
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	@Column(name = "reported")
	public Integer getReported() {
		return reported;
	}

	public void setReported(Integer reported) {
		this.reported = reported;
	}

	@Column(name = "delay")
	public Integer getDelay() {
		return delay;
	}

	public void setDelay(Integer delay) {
		this.delay = delay;
	}

	@Column(name = "reported_rate")
	public Double getReportedRate() {
		return reportedRate;
	}

	public void setReportedRate(Double reportedRate) {
		this.reportedRate = reportedRate;
	}

	@Column(name = "eva")
	public Integer getEva() {
		return eva;
	}

	public void setEva(Integer eva) {
		this.eva = eva;
	}

	@Column(name = "eva_rate")
	public Double getEvaRate() {
		return evaRate;
	}

	public void setEvaRate(Double evaRate) {
		this.evaRate = evaRate;
	}
	
	@Column(name = "attend")
	public Integer getAttend() {
		return attend;
	}

	public void setAttend(Integer attend) {
		this.attend = attend;
	}

	@Column(name = "asence")
	public Integer getAsence() {
		return asence;
	}

	public void setAsence(Integer asence) {
		this.asence = asence;
	}
	
	@Column(name = "attend_rate")
	public Double getAttendRate() {
		return attendRate;
	}

	public void setAttendRate(Double attendRate) {
		this.attendRate = attendRate;
	}
	
	@Column(name = "p_count")
	public Integer getpCount() {
		return pCount;
	}

	public void setpCount(Integer pCount) {
		this.pCount = pCount;
	}


	@Column(name = "zb_num")
	public Integer getZbNum() {
		return zbNum;
	}

	public void setZbNum(Integer zbNum) {
		this.zbNum = zbNum;
	}
	
	@Column(name = "agency_num")
    public Integer getAgencyNum() {
		return agencyNum;
	}

	public void setAgencyNum(Integer agencyNum) {
		this.agencyNum = agencyNum;
	}
	
	@Column(name = "agency_goodjob")
	public Integer getAgencyGoodjob() {
		return agencyGoodjob;
	}

	public void setAgencyGoodjob(Integer agencyGoodjob) {
		this.agencyGoodjob = agencyGoodjob;
	}
	
	@Column(name = "zbsj_num")
	public Integer getZbsjNum() {
		return zbsjNum;
	}

	public void setZbsjNum(Integer zbsjNum) {
		this.zbsjNum = zbsjNum;
	}
	
	
	@Column(name = "code")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}	

}