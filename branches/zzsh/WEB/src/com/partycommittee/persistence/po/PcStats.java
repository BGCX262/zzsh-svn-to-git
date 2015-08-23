package com.partycommittee.persistence.po;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Date;


/**
 * The persistent class for the pc_remind_stat database table.
 * 
 */
@Entity
@Table(name="pc_zzsh_stat")
public class PcStats implements Serializable {
	private static final long serialVersionUID = 485572770721967499L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private Integer agencyId;
	
	private String name;

	private Integer codeId;

	
	private String code;

	private Integer parentId;
	
	private Integer year;

	private Integer quarter;
	
	private Integer month;

	private Integer typeId;

	private Integer total;
	
	private Integer totalSuccess;
	
	private Integer totalReturn;
	
	private Integer totalDelay;
	
	private Integer reported;
	
	private Double reportedRate;
	
	private Double returnRate;
	
	private Double delayRate;
	
	private Integer attend;
	
	private Integer asence;
	
	private Double  attendRate;
	
	private Integer eva;
	
	private Double evaRate;
	
	private Integer eva1;
	
	private Integer eva2;
	
	private Integer eva3;
	
	private Integer eva4;
	
	private Double eva1Rate;
	
	private Double eva2Rate;
	
	private Double eva3Rate;

	private Double eva4Rate;
	
	private Integer agencyGoodjob;
	
	public PcStats() {
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
	

	@Column(name = "agency_goodjob")
	public Integer getAgencyGoodjob() {
		return agencyGoodjob;
	}

	public void setAgencyGoodjob(Integer agencyGoodjob) {
		this.agencyGoodjob = agencyGoodjob;
	}

	@Column(name = "code")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}	
	
	@Column(name = "month")
	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}


	@Column(name = "return_rate")
	public Double getReturnRate() {
		return returnRate;
	}

	public void setReturnRate(Double returnRate) {
		this.returnRate = returnRate;
	}

	@Column(name = "delay_rate")
	public Double getDelayRate() {
		return delayRate;
	}

	public void setDelayRate(Double delayRate) {
		this.delayRate = delayRate;
	}
	
	@Column(name = "eva_1")
	public Integer getEva1() {
		return eva1;
	}

	public void setEva1(Integer eva1) {
		this.eva1 = eva1;
	}

	@Column(name = "eva_2")
	public Integer getEva2() {
		return eva2;
	}

	public void setEva2(Integer eva2) {
		this.eva2 = eva2;
	}

	@Column(name = "eva_3")
	public Integer getEva3() {
		return eva3;
	}

	public void setEva3(Integer eva3) {
		this.eva3 = eva3;
	}

	@Column(name = "eva_4")
	public Integer getEva4() {
		return eva4;
	}

	public void setEva4(Integer eva4) {
		this.eva4 = eva4;
	}

	@Column(name = "eva_1_rate")
	public Double getEva1Rate() {
		return eva1Rate;
	}

	public void setEva1Rate(Double eva1Rate) {
		this.eva1Rate = eva1Rate;
	}

	@Column(name = "eva_2_rate")
	public Double getEva2Rate() {
		return eva2Rate;
	}

	public void setEva2Rate(Double eva2Rate) {
		this.eva2Rate = eva2Rate;
	}

	@Column(name = "eva_3_rate")
	public Double getEva3Rate() {
		return eva3Rate;
	}

	public void setEva3Rate(Double eva3Rate) {
		this.eva3Rate = eva3Rate;
	}

	@Column(name = "eva_4_rate")
	public Double getEva4Rate() {
		return eva4Rate;
	}

	public void setEva4Rate(Double eva4Rate) {
		this.eva4Rate = eva4Rate;
	}	
	
	@Column(name = "total_success")
	public Integer getTotalSuccess() {
		return totalSuccess;
	}

	public void setTotalSuccess(Integer totalSuccess) {
		this.totalSuccess = totalSuccess;
	}

	@Column(name = "total_return")
	public Integer getTotalReturn() {
		return totalReturn;
	}

	public void setTotalReturn(Integer totalReturn) {
		this.totalReturn = totalReturn;
	}

	@Column(name = "total_delay")
	public Integer getTotalDelay() {
		return totalDelay;
	}

	public void setTotalDelay(Integer totalDelay) {
		this.totalDelay = totalDelay;
	}
	

}