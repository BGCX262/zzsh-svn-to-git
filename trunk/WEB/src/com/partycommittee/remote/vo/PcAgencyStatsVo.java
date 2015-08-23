package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;

import com.partycommittee.persistence.po.PcAgencyStats;

public class PcAgencyStatsVo implements Serializable {
	private static final long serialVersionUID = -1190776206070964606L;

	private Integer id;

	private Integer agencyId;

	private Integer codeId;

	private String name;
	
	private String code;

	private Integer parentId;

	private Integer zzNum;
	private Integer jcNum;	
	private Integer ejdwNum;
	private Integer dzjNum;
	private Integer dzbNum;
	private Integer more2yearNum;
	private Integer less7Num;
	private Integer noFsjZbwyNum;
	private Integer dxzNum;
	private Integer dyNum;
	private Integer zbsjNum;
	private Integer zbfsjNum;
	private Integer zzwyNum;
	private Integer xcwyNum;
	private Integer jjwyNum;
	private Integer qnwyNum;
	private Integer ghwyNum;
	private Integer fnwyNum;
	private Integer bmwyNum;
	private Date updatetime;	

	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAgencyId() {
		return agencyId;
	}

	public void setAgencyId(Integer agencyId) {
		this.agencyId = agencyId;
	}

	public Integer getCodeId() {
		return codeId;
	}

	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
		
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	public Integer getZzNum() {
		return zzNum;
	}

	public void setZzNum(Integer zzNum) {
		this.zzNum = zzNum;
	}

	public Integer getJcNum() {
		return jcNum;
	}

	public void setJcNum(Integer jcNum) {
		this.jcNum = jcNum;
	}	
	
	public Integer getEjdwNum() {
		return ejdwNum;
	}

	public void setEjdwNum(Integer ejdwNum) {
		this.ejdwNum = ejdwNum;
	}

	public Integer getDzjNum() {
		return dzjNum;
	}

	public void setDzjNum(Integer dzjNum) {
		this.dzjNum = dzjNum;
	}

	public Integer getDzbNum() {
		return dzbNum;
	}

	public void setDzbNum(Integer dzbNum) {
		this.dzbNum = dzbNum;
	}

	public Integer getMore2yearNum() {
		return more2yearNum;
	}

	public void setMore2yearNum(Integer more2yearNum) {
		this.more2yearNum = more2yearNum;
	}

	public Integer getLess7Num() {
		return less7Num;
	}

	public void setLess7Num(Integer less7Num) {
		this.less7Num = less7Num;
	}

	public Integer getNoFsjZbwyNum() {
		return noFsjZbwyNum;
	}

	public void setNoFsjZbwyNum(Integer noFsjZbwyNum) {
		this.noFsjZbwyNum = noFsjZbwyNum;
	}
	
	public Integer getDxzNum() {
		return dxzNum;
	}

	public void setDxzNum(Integer dxzNum) {
		this.dxzNum = dxzNum;
	}

	public Integer getDyNum() {
		return dyNum;
	}

	public void setDyNum(Integer dyNum) {
		this.dyNum = dyNum;
	}

	public Integer getZbsjNum() {
		return zbsjNum;
	}

	public void setZbsjNum(Integer zbsjNum) {
		this.zbsjNum = zbsjNum;
	}

	public Integer getZbfsjNum() {
		return zbfsjNum;
	}

	public void setZbfsjNum(Integer zbfsjNum) {
		this.zbfsjNum = zbfsjNum;
	}

	public Integer getZzwyNum() {
		return zzwyNum;
	}

	public void setZzwyNum(Integer zzwyNum) {
		this.zzwyNum = zzwyNum;
	}

	public Integer getXcwyNum() {
		return xcwyNum;
	}

	
	public void setXcwyNum(Integer xcwyNum) {
		this.xcwyNum = xcwyNum;
	}

	public Integer getJjwyNum() {
		return jjwyNum;
	}

	
	public void setJjwyNum(Integer jjwyNum) {
		this.jjwyNum = jjwyNum;
	}

	public Integer getQnwyNum() {
		return qnwyNum;
	}

	
	public void setQnwyNum(Integer qnwyNum) {
		this.qnwyNum = qnwyNum;
	}

	public Integer getGhwyNum() {
		return ghwyNum;
	}

	
	public void setGhwyNum(Integer ghwyNum) {
		this.ghwyNum = ghwyNum;
	}

	public Integer getFnwyNum() {
		return fnwyNum;
	}

	
	public void setFnwyNum(Integer fnwyNum) {
		this.fnwyNum = fnwyNum;
	}

	public Integer getBmwyNum() {
		return bmwyNum;
	}

	public void setBmwyNum(Integer bmwyNum) {
		this.bmwyNum = bmwyNum;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}		
	
	
	public static PcAgencyStatsVo fromPcAgencyStats(PcAgencyStats pevo) {
		PcAgencyStatsVo vo = new PcAgencyStatsVo();
		vo.setAgencyId(pevo.getAgencyId());
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setId(pevo.getId());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setZzNum(pevo.getZzNum());
		vo.setJcNum(pevo.getJcNum());
		vo.setEjdwNum(pevo.getEjdwNum());
		vo.setDzjNum(pevo.getDzjNum());
		vo.setDzbNum(pevo.getDzbNum());
		vo.setMore2yearNum(pevo.getMore2yearNum());
		vo.setLess7Num(pevo.getLess7Num());
		vo.setNoFsjZbwyNum(pevo.getNoFsjZbwyNum());
		vo.setDxzNum(pevo.getDxzNum());
		vo.setDyNum(pevo.getDyNum());
		vo.setZbsjNum(pevo.getZbsjNum());
		vo.setZbfsjNum(pevo.getZbfsjNum());
		vo.setZzwyNum(pevo.getZzwyNum());
		vo.setXcwyNum(pevo.getXcwyNum());
		vo.setJjwyNum(pevo.getJjwyNum());
		vo.setQnwyNum(pevo.getQnwyNum());
		vo.setGhwyNum(pevo.getGhwyNum());
		vo.setFnwyNum(pevo.getFnwyNum());
		vo.setBmwyNum(pevo.getBmwyNum());
		vo.setUpdatetime(pevo.getUpdatetime());
		return vo;
	}
	
	public static PcAgencyStats toPcAgencyStats(PcAgencyStatsVo pevo) {
		PcAgencyStats vo = new PcAgencyStats();
		vo.setCodeId(pevo.getCodeId());
		vo.setCode(pevo.getCode());
		vo.setId(pevo.getId());
		vo.setName(pevo.getName());
		vo.setParentId(pevo.getParentId());
		vo.setZzNum(pevo.getZzNum());
		vo.setJcNum(pevo.getJcNum());		
		vo.setEjdwNum(pevo.getEjdwNum());
		vo.setDzjNum(pevo.getDzjNum());
		vo.setDzbNum(pevo.getDzbNum());
		vo.setMore2yearNum(pevo.getMore2yearNum());
		vo.setLess7Num(pevo.getLess7Num());
		vo.setNoFsjZbwyNum(pevo.getNoFsjZbwyNum());
		vo.setDxzNum(pevo.getDxzNum());
		vo.setDyNum(pevo.getDyNum());
		vo.setZbsjNum(pevo.getZbsjNum());
		vo.setZbfsjNum(pevo.getZbfsjNum());
		vo.setZzwyNum(pevo.getZzwyNum());
		vo.setXcwyNum(pevo.getXcwyNum());
		vo.setJjwyNum(pevo.getJjwyNum());
		vo.setQnwyNum(pevo.getQnwyNum());
		vo.setGhwyNum(pevo.getGhwyNum());
		vo.setFnwyNum(pevo.getFnwyNum());
		vo.setBmwyNum(pevo.getBmwyNum());
		vo.setUpdatetime(pevo.getUpdatetime());
		return vo;
	}
}
