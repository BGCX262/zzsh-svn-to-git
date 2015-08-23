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
	
	private Double attend_rate;
	
	private Double reported_rate;
	
	private Integer total;
	
	private Integer total_return;
	
	private Integer total_delay;
	
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

	public Double getAttend_rate() {
		return attend_rate;
	}

	public Double getReported_rate() {
		return reported_rate;
	}

	public Integer getTotal() {
		return total;
	}

	public Integer getTotal_return() {
		return total_return;
	}

	public Integer getTotal_delay() {
		return total_delay;
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

	public void setAttend_rate(Double attend_rate) {
		this.attend_rate = attend_rate;
	}

	public void setReported_rate(Double reported_rate) {
		this.reported_rate = reported_rate;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public void setTotal_return(Integer total_return) {
		this.total_return = total_return;
	}

	public void setTotal_delay(Integer total_delay) {
		this.total_delay = total_delay;
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
