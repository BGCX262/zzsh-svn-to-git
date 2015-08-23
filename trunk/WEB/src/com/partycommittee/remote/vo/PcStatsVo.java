package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcStats;

public class PcStatsVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964607L;

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
	
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getReported() {
		return reported;
	}

	public void setReported(Integer reported) {
		this.reported = reported;
	}

	public Double getReportedRate() {
		return reportedRate;
	}

	public void setReportedRate(Double reportedRate) {
		this.reportedRate = reportedRate;
	}

	public Integer getEva() {
		return eva;
	}

	public void setEva(Integer eva) {
		this.eva = eva;
	}

	public Double getEvaRate() {
		return evaRate;
	}

	public void setEvaRate(Double evaRate) {
		this.evaRate = evaRate;
	}

	public Integer getAttend() {
		return attend;
	}

	public void setAttend(Integer attend) {
		this.attend = attend;
	}

	public Integer getAsence() {
		return asence;
	}

	public void setAsence(Integer asence) {
		this.asence = asence;
	}
	
	public Double getAttendRate() {
		return attendRate;
	}

	public void setAttendRate(Double attendRate) {
		this.attendRate = attendRate;
	}
	
	public Integer getAgencyGoodjob() {
		return agencyGoodjob;
	}

	public void setAgencyGoodjob(Integer agencyGoodjob) {
		this.agencyGoodjob = agencyGoodjob;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}	
	
	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public Integer getTotalSuccess() {
		return totalSuccess;
	}

	public void setTotalSuccess(Integer totalSuccess) {
		this.totalSuccess = totalSuccess;
	}

	public Integer getTotalReturn() {
		return totalReturn;
	}

	public void setTotalReturn(Integer totalReturn) {
		this.totalReturn = totalReturn;
	}

	public Integer getTotalDelay() {
		return totalDelay;
	}

	public void setTotalDelay(Integer totalDelay) {
		this.totalDelay = totalDelay;
	}

	public Double getReturnRate() {
		return returnRate;
	}

	public void setReturnRate(Double returnRate) {
		this.returnRate = returnRate;
	}

	public Double getDelayRate() {
		return delayRate;
	}

	public void setDelayRate(Double delayRate) {
		this.delayRate = delayRate;
	}
	
	public Integer getEva1() {
		return eva1;
	}

	public void setEva1(Integer eva1) {
		this.eva1 = eva1;
	}

	public Integer getEva2() {
		return eva2;
	}

	public void setEva2(Integer eva2) {
		this.eva2 = eva2;
	}

	public Integer getEva3() {
		return eva3;
	}

	public void setEva3(Integer eva3) {
		this.eva3 = eva3;
	}

	public Integer getEva4() {
		return eva4;
	}

	public void setEva4(Integer eva4) {
		this.eva4 = eva4;
	}

	public Double getEva1Rate() {
		return eva1Rate;
	}

	public void setEva1Rate(Double eva1Rate) {
		this.eva1Rate = eva1Rate;
	}

	public Double getEva2Rate() {
		return eva2Rate;
	}

	public void setEva2Rate(Double eva2Rate) {
		this.eva2Rate = eva2Rate;
	}

	public Double getEva3Rate() {
		return eva3Rate;
	}

	public void setEva3Rate(Double eva3Rate) {
		this.eva3Rate = eva3Rate;
	}

	public Double getEva4Rate() {
		return eva4Rate;
	}

	public void setEva4Rate(Double eva4Rate) {
		this.eva4Rate = eva4Rate;
	}	
	
	public static PcStatsVo fromPcStats(PcStats pevo) {
		PcStatsVo vo = new PcStatsVo();
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setId(pevo.getId());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setQuarter(pevo.getQuarter());
		vo.setTypeId(pevo.getTypeId());
		vo.setYear(pevo.getYear());
		vo.setMonth(pevo.getMonth());
		
		vo.setTotal(pevo.getTotal());
		vo.setTotalSuccess(pevo.getTotalSuccess());
		vo.setTotalReturn(pevo.getTotalReturn());
		vo.setTotalDelay(pevo.getTotalDelay());
		vo.setReported(pevo.getReported());
		vo.setReportedRate(pevo.getReportedRate());
		vo.setReturnRate(pevo.getReturnRate());
		vo.setDelayRate(pevo.getDelayRate());
		vo.setAttend(pevo.getAttend());
		vo.setAsence(pevo.getAsence());
		vo.setAttendRate(pevo.getAttendRate());

		vo.setEva(pevo.getEva());
		vo.setEvaRate(pevo.getEvaRate());
		vo.setEva1(pevo.getEva1());
		vo.setEva2(pevo.getEva2());
		vo.setEva3(pevo.getEva3());
		vo.setEva4(pevo.getEva4());
		vo.setEva1Rate(pevo.getEva1Rate());
		vo.setEva2Rate(pevo.getEva2Rate());
		vo.setEva3Rate(pevo.getEva3Rate());
		vo.setEva4Rate(pevo.getEva4Rate());

		vo.setAgencyGoodjob(pevo.getAgencyGoodjob());
		return vo;
	}
	
	public static PcStats toPcStats(PcStatsVo pevo) {
		PcStats vo = new PcStats();
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setId(pevo.getId());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setQuarter(pevo.getQuarter());
		vo.setTypeId(pevo.getTypeId());
		vo.setYear(pevo.getYear());
		vo.setMonth(pevo.getMonth());
		
		vo.setTotal(pevo.getTotal());
		vo.setTotalSuccess(pevo.getTotalSuccess());
		vo.setTotalReturn(pevo.getTotalReturn());
		vo.setTotalDelay(pevo.getTotalDelay());
		vo.setReported(pevo.getReported());
		vo.setReportedRate(pevo.getReportedRate());
		vo.setReturnRate(pevo.getReturnRate());
		vo.setDelayRate(pevo.getDelayRate());
		vo.setAttend(pevo.getAttend());
		vo.setAsence(pevo.getAsence());
		vo.setAttendRate(pevo.getAttendRate());

		vo.setEva(pevo.getEva());
		vo.setEvaRate(pevo.getEvaRate());
		vo.setEva1(pevo.getEva1());
		vo.setEva2(pevo.getEva2());
		vo.setEva3(pevo.getEva3());
		vo.setEva4(pevo.getEva4());
		vo.setEva1Rate(pevo.getEva1Rate());
		vo.setEva2Rate(pevo.getEva2Rate());
		vo.setEva3Rate(pevo.getEva3Rate());
		vo.setEva4Rate(pevo.getEva4Rate());

		vo.setAgencyGoodjob(pevo.getAgencyGoodjob());
		return vo;
	}
}
