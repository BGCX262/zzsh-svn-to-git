package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcStats;

public class PcMeetingZBStatsVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964607L;

	private String p_name;

	private String dw_name;
	
	private String ej_or_dzz_name;
	
	private String name;

	private String setup_datetime;
	
	private Double zwh_attend_rate;
	
	private Double zwh_reported_rate;
	
	private Integer zwh_total;
	
	private Integer zwh_total_return;
	
	private Integer zwh_total_delay;
	
	private Double zwh_eva_rate;
	
	private Double zwh_eva_1_rate;
	
	private Double zwh_eva_2_rate;
	
	private Double zwh_eva_3_rate;
	
	private Double zwh_eva_4_rate;
	
	private Double dydh_attend_rate;
	
	private Double dydh_reported_rate;
	
	private Integer dydh_total;
	
	private Integer dydh_total_return;
	
	private Integer dydh_total_delay;
	
	private Double dydh_eva_rate;
	
	private Double dydh_eva_1_rate;
	
	private Double dydh_eva_2_rate;
	
	private Double dydh_eva_3_rate;
	
	private Double dydh_eva_4_rate;	
	
	private Double mzshh_attend_rate;
	
	private Double mzshh_reported_rate;
	
	private Integer mzshh_total;
	
	private Integer mzshh_total_return;
	
	private Integer mzshh_total_delay;
	
	private Double mzshh_eva_rate;
	
	private Double mzshh_eva_1_rate;
	
	private Double mzshh_eva_2_rate;
	
	private Double mzshh_eva_3_rate;
	
	private Double mzshh_eva_4_rate;		

	private Double dk_attend_rate;
	
	private Double dk_reported_rate;
	
	private Integer dk_total;
	
	private Integer dk_total_return;
	
	private Integer dk_total_delay;
	
	private Double dk_eva_rate;
	
	private Double dk_eva_1_rate;
	
	private Double dk_eva_2_rate;
	
	private Double dk_eva_3_rate;
	
	private Double dk_eva_4_rate;	
	
	private Double qt_attend_rate;
	
	private Integer qt_total;
	
	private Integer qt_total_return;
	
	private Integer qt_total_delay;
	
	private Double qt_eva_rate;
	
	private Double qt_eva_1_rate;
	
	private Double qt_eva_2_rate;
	
	private Double qt_eva_3_rate;
	
	private Double qt_eva_4_rate;

	public String getP_name() {
		return this.p_name;
	}

	public void setP_name(String pName) {
		this.p_name = pName;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSetup_datetime() {
		return this.setup_datetime;
	}

	public void setSetup_datetime(String setupDatetime) {
		this.setup_datetime = setupDatetime;
	}

	public Double getZwh_attend_rate() {
		return this.zwh_attend_rate;
	}

	public void setZwh_attend_rate(Double zwhAttendRate) {
		this.zwh_attend_rate = zwhAttendRate;
	}

	public Double getZwh_reported_rate() {
		return this.zwh_reported_rate;
	}

	public void setZwh_reported_rate(Double zwhReportedRate) {
		this.zwh_reported_rate = zwhReportedRate;
	}

	public Integer getZwh_total() {
		return this.zwh_total;
	}

	public void setZwh_total(Integer zwhTotal) {
		this.zwh_total = zwhTotal;
	}

	public Integer getZwh_total_return() {
		return this.zwh_total_return;
	}

	public void setZwh_total_return(Integer zwhTotalReturn) {
		this.zwh_total_return = zwhTotalReturn;
	}

	public Integer getZwh_total_delay() {
		return this.zwh_total_delay;
	}

	public void setZwh_total_delay(Integer zwhTotalDelay) {
		this.zwh_total_delay = zwhTotalDelay;
	}

	public Double getZwh_eva_rate() {
		return this.zwh_eva_rate;
	}

	public void setZwh_eva_rate(Double zwhEvaRate) {
		this.zwh_eva_rate = zwhEvaRate;
	}

	public Double getZwh_eva_1_rate() {
		return this.zwh_eva_1_rate;
	}

	public void setZwh_eva_1_rate(Double zwhEva_1Rate) {
		this.zwh_eva_1_rate = zwhEva_1Rate;
	}

	public Double getZwh_eva_2_rate() {
		return this.zwh_eva_2_rate;
	}

	public void setZwh_eva_2_rate(Double zwhEva_2Rate) {
		this.zwh_eva_2_rate = zwhEva_2Rate;
	}

	public Double getZwh_eva_3_rate() {
		return this.zwh_eva_3_rate;
	}

	public void setZwh_eva_3_rate(Double zwhEva_3Rate) {
		this.zwh_eva_3_rate = zwhEva_3Rate;
	}

	public Double getZwh_eva_4_rate() {
		return this.zwh_eva_4_rate;
	}

	public void setZwh_eva_4_rate(Double zwhEva_4Rate) {
		this.zwh_eva_4_rate = zwhEva_4Rate;
	}

	public Double getDydh_attend_rate() {
		return this.dydh_attend_rate;
	}

	public void setDydh_attend_rate(Double dydhAttendRate) {
		this.dydh_attend_rate = dydhAttendRate;
	}

	public Double getDydh_reported_rate() {
		return this.dydh_reported_rate;
	}

	public void setDydh_reported_rate(Double dydhReportedRate) {
		this.dydh_reported_rate = dydhReportedRate;
	}

	public Integer getDydh_total() {
		return this.dydh_total;
	}

	public void setDydh_total(Integer dydhTotal) {
		this.dydh_total = dydhTotal;
	}

	public Integer getDydh_total_return() {
		return this.dydh_total_return;
	}

	public void setDydh_total_return(Integer dydhTotalReturn) {
		this.dydh_total_return = dydhTotalReturn;
	}

	public Integer getDydh_total_delay() {
		return this.dydh_total_delay;
	}

	public void setDydh_total_delay(Integer dydhTotalDelay) {
		this.dydh_total_delay = dydhTotalDelay;
	}

	public Double getDydh_eva_rate() {
		return this.dydh_eva_rate;
	}

	public void setDydh_eva_rate(Double dydhEvaRate) {
		this.dydh_eva_rate = dydhEvaRate;
	}

	public Double getDydh_eva_1_rate() {
		return this.dydh_eva_1_rate;
	}

	public void setDydh_eva_1_rate(Double dydhEva_1Rate) {
		this.dydh_eva_1_rate = dydhEva_1Rate;
	}

	public Double getDydh_eva_2_rate() {
		return this.dydh_eva_2_rate;
	}

	public void setDydh_eva_2_rate(Double dydhEva_2Rate) {
		this.dydh_eva_2_rate = dydhEva_2Rate;
	}

	public Double getDydh_eva_3_rate() {
		return this.dydh_eva_3_rate;
	}

	public void setDydh_eva_3_rate(Double dydhEva_3Rate) {
		this.dydh_eva_3_rate = dydhEva_3Rate;
	}

	public Double getDydh_eva_4_rate() {
		return this.dydh_eva_4_rate;
	}

	public void setDydh_eva_4_rate(Double dydhEva_4Rate) {
		this.dydh_eva_4_rate = dydhEva_4Rate;
	}

	public Double getMzshh_attend_rate() {
		return this.mzshh_attend_rate;
	}

	public void setMzshh_attend_rate(Double mzshhAttendRate) {
		this.mzshh_attend_rate = mzshhAttendRate;
	}

	public Double getMzshh_reported_rate() {
		return this.mzshh_reported_rate;
	}

	public void setMzshh_reported_rate(Double mzshhReportedRate) {
		this.mzshh_reported_rate = mzshhReportedRate;
	}

	public Integer getMzshh_total() {
		return this.mzshh_total;
	}

	public void setMzshh_total(Integer mzshhTotal) {
		this.mzshh_total = mzshhTotal;
	}

	public Integer getMzshh_total_return() {
		return this.mzshh_total_return;
	}

	public void setMzshh_total_return(Integer mzshhTotalReturn) {
		this.mzshh_total_return = mzshhTotalReturn;
	}

	public Integer getMzshh_total_delay() {
		return this.mzshh_total_delay;
	}

	public void setMzshh_total_delay(Integer mzshhTotalDelay) {
		this.mzshh_total_delay = mzshhTotalDelay;
	}

	public Double getMzshh_eva_rate() {
		return this.mzshh_eva_rate;
	}

	public void setMzshh_eva_rate(Double mzshhEvaRate) {
		this.mzshh_eva_rate = mzshhEvaRate;
	}

	public Double getMzshh_eva_1_rate() {
		return this.mzshh_eva_1_rate;
	}

	public void setMzshh_eva_1_rate(Double mzshhEva_1Rate) {
		this.mzshh_eva_1_rate = mzshhEva_1Rate;
	}

	public Double getMzshh_eva_2_rate() {
		return this.mzshh_eva_2_rate;
	}

	public void setMzshh_eva_2_rate(Double mzshhEva_2Rate) {
		this.mzshh_eva_2_rate = mzshhEva_2Rate;
	}

	public Double getMzshh_eva_3_rate() {
		return this.mzshh_eva_3_rate;
	}

	public void setMzshh_eva_3_rate(Double mzshhEva_3Rate) {
		this.mzshh_eva_3_rate = mzshhEva_3Rate;
	}

	public Double getMzshh_eva_4_rate() {
		return this.mzshh_eva_4_rate;
	}

	public void setMzshh_eva_4_rate(Double mzshhEva_4Rate) {
		this.mzshh_eva_4_rate = mzshhEva_4Rate;
	}

	public Double getDk_attend_rate() {
		return this.dk_attend_rate;
	}

	public void setDk_attend_rate(Double dkAttendRate) {
		this.dk_attend_rate = dkAttendRate;
	}

	public Double getDk_reported_rate() {
		return this.dk_reported_rate;
	}

	public void setDk_reported_rate(Double dkReportedRate) {
		this.dk_reported_rate = dkReportedRate;
	}

	public Integer getDk_total() {
		return this.dk_total;
	}

	public void setDk_total(Integer dkTotal) {
		this.dk_total = dkTotal;
	}

	public Integer getDk_total_return() {
		return this.dk_total_return;
	}

	public void setDk_total_return(Integer dkTotalReturn) {
		this.dk_total_return = dkTotalReturn;
	}

	public Integer getDk_total_delay() {
		return this.dk_total_delay;
	}

	public void setDk_total_delay(Integer dkTotalDelay) {
		this.dk_total_delay = dkTotalDelay;
	}

	public Double getDk_eva_rate() {
		return this.dk_eva_rate;
	}

	public void setDk_eva_rate(Double dkEvaRate) {
		this.dk_eva_rate = dkEvaRate;
	}

	public Double getDk_eva_1_rate() {
		return this.dk_eva_1_rate;
	}

	public void setDk_eva_1_rate(Double dkEva_1Rate) {
		this.dk_eva_1_rate = dkEva_1Rate;
	}

	public Double getDk_eva_2_rate() {
		return this.dk_eva_2_rate;
	}

	public void setDk_eva_2_rate(Double dkEva_2Rate) {
		this.dk_eva_2_rate = dkEva_2Rate;
	}

	public Double getDk_eva_3_rate() {
		return this.dk_eva_3_rate;
	}

	public void setDk_eva_3_rate(Double dkEva_3Rate) {
		this.dk_eva_3_rate = dkEva_3Rate;
	}

	public Double getDk_eva_4_rate() {
		return this.dk_eva_4_rate;
	}

	public void setDk_eva_4_rate(Double dkEva_4Rate) {
		this.dk_eva_4_rate = dkEva_4Rate;
	}

	public Double getQt_attend_rate() {
		return this.qt_attend_rate;
	}

	public void setQt_attend_rate(Double qtAttendRate) {
		this.qt_attend_rate = qtAttendRate;
	}

	public Integer getQt_total() {
		return this.qt_total;
	}

	public void setQt_total(Integer qtTotal) {
		this.qt_total = qtTotal;
	}

	public Integer getQt_total_return() {
		return this.qt_total_return;
	}

	public void setQt_total_return(Integer qtTotalReturn) {
		this.qt_total_return = qtTotalReturn;
	}

	public Integer getQt_total_delay() {
		return this.qt_total_delay;
	}

	public void setQt_total_delay(Integer qtTotalDelay) {
		this.qt_total_delay = qtTotalDelay;
	}

	public Double getQt_eva_rate() {
		return this.qt_eva_rate;
	}

	public void setQt_eva_rate(Double qtEvaRate) {
		this.qt_eva_rate = qtEvaRate;
	}

	public Double getQt_eva_1_rate() {
		return this.qt_eva_1_rate;
	}

	public void setQt_eva_1_rate(Double qtEva_1Rate) {
		this.qt_eva_1_rate = qtEva_1Rate;
	}

	public Double getQt_eva_2_rate() {
		return this.qt_eva_2_rate;
	}

	public void setQt_eva_2_rate(Double qtEva_2Rate) {
		this.qt_eva_2_rate = qtEva_2Rate;
	}

	public Double getQt_eva_3_rate() {
		return this.qt_eva_3_rate;
	}

	public void setQt_eva_3_rate(Double qtEva_3Rate) {
		this.qt_eva_3_rate = qtEva_3Rate;
	}

	public Double getQt_eva_4_rate() {
		return this.qt_eva_4_rate;
	}

	public void setQt_eva_4_rate(Double qtEva_4Rate) {
		this.qt_eva_4_rate = qtEva_4Rate;
	}

	public String getDw_name() {
		return dw_name;
	}

	public void setDw_name(String dwName) {
		this.dw_name = dwName;
	}

	public String getEj_or_dzz_name() {
		return ej_or_dzz_name;
	}

	public void setEj_or_dzz_name(String ejOrDzzName) {
		this.ej_or_dzz_name = ejOrDzzName;
	}		
	

}
