package com.partycommittee.remote.vo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.partycommittee.persistence.po.PcDutyCode;

public class PcLicenseVo implements Serializable {
	private static final long serialVersionUID = -3609023388156250129L;
	
	private String productno;
	private Integer locknodw;
	private Integer locknozb;
	private String firstdate;
	private Integer leftdays;
	private String tips;
	

	public String getProductno() {
		return productno;
	}
	public void setProductno(String productno) {
		this.productno = productno;
	}

	public Integer getLocknodw() {
		return locknodw;
	}
	public void setLocknodw(Integer locknodw) {
		this.locknodw = locknodw;
	}
	public Integer getLocknozb() {
		return locknozb;
	}
	public void setLocknozb(Integer locknozb) {
		this.locknozb = locknozb;
	}
	public String getFirstdate() {
		return firstdate;
	}
	public void setFirstdate(String firstdate) {
		this.firstdate = firstdate;
	}
	public Integer getLeftdays() {
		return leftdays;
	}
	public void setLeftdays(Integer leftdays) {
		this.leftdays = leftdays;
	}
	
	public String getTips() {
		return tips;
	}
	public void setTips(String tips) {
		this.tips = tips;
	}	

}
