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
	private Double yp_reported_rate;
	
	private Integer yp_agency_goodjob;
	
	private Double yp_return_rate;
	
	private Double yp_delay_rate;
	
	private Double yp_eva_rate;
	
	private Double yp_eva_1_rate;
	
	private Double yp_eva_2_rate;
	
	private Double yp_eva_3_rate;
	
	private Double yp_eva_4_rate;
	
	//季度计划
	private Double qp_reported_rate;
	
	private Integer qp_agency_goodjob;
	
	private Double qp_return_rate;
	
	private Double qp_delay_rate;
	
	private Double qp_eva_rate;
	
	private Double qp_eva_1_rate;
	
	private Double qp_eva_2_rate;
	
	private Double qp_eva_3_rate;
	
	private Double qp_eva_4_rate;	
	
	//季度执行情况
	private Double qs_reported_rate;
	
	private Integer qs_agency_goodjob;
	
	private Double qs_return_rate;
	
	private Double qs_delay_rate;
	
	private Double qs_eva_rate;
	
	private Double qs_eva_1_rate;
	
	private Double qs_eva_2_rate;
	
	private Double qs_eva_3_rate;
	
	private Double qs_eva_4_rate;		
	
	//年终总结 
	private Double ys_reported_rate;
	
	private Integer ys_agency_goodjob;
	
	private Double ys_return_rate;
	
	private Double ys_delay_rate;
	
	private Double ys_eva_rate;
	
	private Double ys_eva_1_rate;
	
	private Double ys_eva_2_rate;
	
	private Double ys_eva_3_rate;
	
	private Double ys_eva_4_rate;

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSetup_datetime() {
		return setup_datetime;
	}

	public void setSetup_datetime(String setup_datetime) {
		this.setup_datetime = setup_datetime;
	}

	public Double getYp_reported_rate() {
		return yp_reported_rate;
	}

	public void setYp_reported_rate(Double yp_reported_rate) {
		this.yp_reported_rate = yp_reported_rate;
	}

	public Integer getYp_agency_goodjob() {
		return yp_agency_goodjob;
	}

	public void setYp_agency_goodjob(Integer yp_agency_goodjob) {
		this.yp_agency_goodjob = yp_agency_goodjob;
	}

	public Double getYp_return_rate() {
		return yp_return_rate;
	}

	public void setYp_return_rate(Double yp_return_rate) {
		this.yp_return_rate = yp_return_rate;
	}

	public Double getYp_eva_rate() {
		return yp_eva_rate;
	}

	public void setYp_eva_rate(Double yp_eva_rate) {
		this.yp_eva_rate = yp_eva_rate;
	}

	public Double getYp_eva_1_rate() {
		return yp_eva_1_rate;
	}

	public void setYp_eva_1_rate(Double yp_eva_1_rate) {
		this.yp_eva_1_rate = yp_eva_1_rate;
	}

	public Double getYp_eva_2_rate() {
		return yp_eva_2_rate;
	}

	public void setYp_eva_2_rate(Double yp_eva_2_rate) {
		this.yp_eva_2_rate = yp_eva_2_rate;
	}

	public Double getYp_eva_3_rate() {
		return yp_eva_3_rate;
	}

	public void setYp_eva_3_rate(Double yp_eva_3_rate) {
		this.yp_eva_3_rate = yp_eva_3_rate;
	}

	public Double getYp_eva_4_rate() {
		return yp_eva_4_rate;
	}

	public void setYp_eva_4_rate(Double yp_eva_4_rate) {
		this.yp_eva_4_rate = yp_eva_4_rate;
	}

	public Double getQp_reported_rate() {
		return qp_reported_rate;
	}

	public void setQp_reported_rate(Double qp_reported_rate) {
		this.qp_reported_rate = qp_reported_rate;
	}

	public Integer getQp_agency_goodjob() {
		return qp_agency_goodjob;
	}

	public void setQp_agency_goodjob(Integer qp_agency_goodjob) {
		this.qp_agency_goodjob = qp_agency_goodjob;
	}

	public Double getQp_return_rate() {
		return qp_return_rate;
	}

	public void setQp_return_rate(Double qp_return_rate) {
		this.qp_return_rate = qp_return_rate;
	}

	public Double getQp_eva_rate() {
		return qp_eva_rate;
	}

	public void setQp_eva_rate(Double qp_eva_rate) {
		this.qp_eva_rate = qp_eva_rate;
	}

	public Double getQp_eva_1_rate() {
		return qp_eva_1_rate;
	}

	public void setQp_eva_1_rate(Double qp_eva_1_rate) {
		this.qp_eva_1_rate = qp_eva_1_rate;
	}

	public Double getQp_eva_2_rate() {
		return qp_eva_2_rate;
	}

	public void setQp_eva_2_rate(Double qp_eva_2_rate) {
		this.qp_eva_2_rate = qp_eva_2_rate;
	}

	public Double getQp_eva_3_rate() {
		return qp_eva_3_rate;
	}

	public void setQp_eva_3_rate(Double qp_eva_3_rate) {
		this.qp_eva_3_rate = qp_eva_3_rate;
	}

	public Double getQp_eva_4_rate() {
		return qp_eva_4_rate;
	}

	public void setQp_eva_4_rate(Double qp_eva_4_rate) {
		this.qp_eva_4_rate = qp_eva_4_rate;
	}

	public Double getQs_reported_rate() {
		return qs_reported_rate;
	}

	public void setQs_reported_rate(Double qs_reported_rate) {
		this.qs_reported_rate = qs_reported_rate;
	}

	public Integer getQs_agency_goodjob() {
		return qs_agency_goodjob;
	}

	public void setQs_agency_goodjob(Integer qs_agency_goodjob) {
		this.qs_agency_goodjob = qs_agency_goodjob;
	}

	public Double getQs_return_rate() {
		return qs_return_rate;
	}

	public void setQs_return_rate(Double qs_return_rate) {
		this.qs_return_rate = qs_return_rate;
	}

	public Double getQs_eva_rate() {
		return qs_eva_rate;
	}

	public void setQs_eva_rate(Double qs_eva_rate) {
		this.qs_eva_rate = qs_eva_rate;
	}

	public Double getQs_eva_1_rate() {
		return qs_eva_1_rate;
	}

	public void setQs_eva_1_rate(Double qs_eva_1_rate) {
		this.qs_eva_1_rate = qs_eva_1_rate;
	}

	public Double getQs_eva_2_rate() {
		return qs_eva_2_rate;
	}

	public void setQs_eva_2_rate(Double qs_eva_2_rate) {
		this.qs_eva_2_rate = qs_eva_2_rate;
	}

	public Double getQs_eva_3_rate() {
		return qs_eva_3_rate;
	}

	public void setQs_eva_3_rate(Double qs_eva_3_rate) {
		this.qs_eva_3_rate = qs_eva_3_rate;
	}

	public Double getQs_eva_4_rate() {
		return qs_eva_4_rate;
	}

	public void setQs_eva_4_rate(Double qs_eva_4_rate) {
		this.qs_eva_4_rate = qs_eva_4_rate;
	}

	public Double getYs_reported_rate() {
		return ys_reported_rate;
	}

	public void setYs_reported_rate(Double ys_reported_rate) {
		this.ys_reported_rate = ys_reported_rate;
	}

	public Integer getYs_agency_goodjob() {
		return ys_agency_goodjob;
	}

	public void setYs_agency_goodjob(Integer ys_agency_goodjob) {
		this.ys_agency_goodjob = ys_agency_goodjob;
	}

	public Double getYs_return_rate() {
		return ys_return_rate;
	}

	public void setYs_return_rate(Double ys_return_rate) {
		this.ys_return_rate = ys_return_rate;
	}

	public Double getYs_eva_rate() {
		return ys_eva_rate;
	}

	public void setYs_eva_rate(Double ys_eva_rate) {
		this.ys_eva_rate = ys_eva_rate;
	}

	public Double getYs_eva_1_rate() {
		return ys_eva_1_rate;
	}

	public void setYs_eva_1_rate(Double ys_eva_1_rate) {
		this.ys_eva_1_rate = ys_eva_1_rate;
	}

	public Double getYs_eva_2_rate() {
		return ys_eva_2_rate;
	}

	public void setYs_eva_2_rate(Double ys_eva_2_rate) {
		this.ys_eva_2_rate = ys_eva_2_rate;
	}

	public Double getYs_eva_3_rate() {
		return ys_eva_3_rate;
	}

	public void setYs_eva_3_rate(Double ys_eva_3_rate) {
		this.ys_eva_3_rate = ys_eva_3_rate;
	}

	public Double getYs_eva_4_rate() {
		return ys_eva_4_rate;
	}

	public void setYs_eva_4_rate(Double ys_eva_4_rate) {
		this.ys_eva_4_rate = ys_eva_4_rate;
	}

	public Double getYp_delay_rate() {
		return yp_delay_rate;
	}

	public void setYp_delay_rate(Double yp_delay_rate) {
		this.yp_delay_rate = yp_delay_rate;
	}

	public Double getQp_delay_rate() {
		return qp_delay_rate;
	}

	public void setQp_delay_rate(Double qp_delay_rate) {
		this.qp_delay_rate = qp_delay_rate;
	}

	public Double getQs_delay_rate() {
		return qs_delay_rate;
	}

	public void setQs_delay_rate(Double qs_delay_rate) {
		this.qs_delay_rate = qs_delay_rate;
	}

	public Double getYs_delay_rate() {
		return ys_delay_rate;
	}

	public void setYs_delay_rate(Double ys_delay_rate) {
		this.ys_delay_rate = ys_delay_rate;
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
