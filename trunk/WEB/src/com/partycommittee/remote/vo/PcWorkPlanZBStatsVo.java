package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcStats;

public class PcWorkPlanZBStatsVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964607L;

	private String p_name;

	private String dw_name;
	
	private String ej_or_dzz_name;
	
	private String name;

	private String setup_datetime;
	
	//年度计划
	private Double reported_rate;
	
	private Integer agency_goodjob;
	
	private Double return_rate;
	
	private Double delay_rate;
	
	private Double eva_rate;
	
	private Double eva_1_rate;
	
	private Double eva_2_rate;
	
	private Double eva_3_rate;
	
	private Double eva_4_rate;

	public String getP_name() {
		return p_name;
	}

	public String getDw_name() {
		return dw_name;
	}

	public String getEj_or_dzz_name() {
		return ej_or_dzz_name;
	}

	public String getName() {
		return name;
	}

	public String getSetup_datetime() {
		return setup_datetime;
	}

	public Double getReported_rate() {
		return reported_rate;
	}

	public Integer getAgency_goodjob() {
		return agency_goodjob;
	}

	public Double getReturn_rate() {
		return return_rate;
	}

	public Double getDelay_rate() {
		return delay_rate;
	}

	public Double getEva_rate() {
		return eva_rate;
	}

	public Double getEva_1_rate() {
		return eva_1_rate;
	}

	public Double getEva_2_rate() {
		return eva_2_rate;
	}

	public Double getEva_3_rate() {
		return eva_3_rate;
	}

	public Double getEva_4_rate() {
		return eva_4_rate;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public void setDw_name(String dw_name) {
		this.dw_name = dw_name;
	}

	public void setEj_or_dzz_name(String ej_or_dzz_name) {
		this.ej_or_dzz_name = ej_or_dzz_name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setSetup_datetime(String setup_datetime) {
		this.setup_datetime = setup_datetime;
	}

	public void setReported_rate(Double reported_rate) {
		this.reported_rate = reported_rate;
	}

	public void setAgency_goodjob(Integer agency_goodjob) {
		this.agency_goodjob = agency_goodjob;
	}

	public void setReturn_rate(Double return_rate) {
		this.return_rate = return_rate;
	}

	public void setDelay_rate(Double delay_rate) {
		this.delay_rate = delay_rate;
	}

	public void setEva_rate(Double eva_rate) {
		this.eva_rate = eva_rate;
	}

	public void setEva_1_rate(Double eva_1_rate) {
		this.eva_1_rate = eva_1_rate;
	}

	public void setEva_2_rate(Double eva_2_rate) {
		this.eva_2_rate = eva_2_rate;
	}

	public void setEva_3_rate(Double eva_3_rate) {
		this.eva_3_rate = eva_3_rate;
	}

	public void setEva_4_rate(Double eva_4_rate) {
		this.eva_4_rate = eva_4_rate;
	}
	
}
