package com.partycommittee.persistence.po;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Date;


/**
 * The persistent class for the pc_remind_stat database table.
 * 
 */
@Entity
@Table(name="pc_agency_stats")
public class PcAgencyStats implements Serializable {
	private static final long serialVersionUID = 485572770721967499L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
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
	
    public PcAgencyStats() {
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
	
	@Column(name = "code")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "zz_num")
	public Integer getZzNum() {
		return zzNum;
	}
	
	public void setZzNum(Integer zzNum) {
		this.zzNum = zzNum;
	}

	@Column(name = "jc_num")
	public Integer getJcNum() {
		return jcNum;
	}

	public void setJcNum(Integer jcNum) {
		this.jcNum = jcNum;
	}	
	
	@Column(name = "ejdw_num")
	public Integer getEjdwNum() {
		return ejdwNum;
	}

	public void setEjdwNum(Integer ejdwNum) {
		this.ejdwNum = ejdwNum;
	}

	@Column(name = "dzj_num")
	public Integer getDzjNum() {
		return dzjNum;
	}

	public void setDzjNum(Integer dzjNum) {
		this.dzjNum = dzjNum;
	}

	@Column(name = "dzb_num")
	public Integer getDzbNum() {
		return dzbNum;
	}

	public void setDzbNum(Integer dzbNum) {
		this.dzbNum = dzbNum;
	}

	@Column(name = "more2year_num")
	public Integer getMore2yearNum() {
		return more2yearNum;
	}

	public void setMore2yearNum(Integer more2yearNum) {
		this.more2yearNum = more2yearNum;
	}

	@Column(name = "less7_num")
	public Integer getLess7Num() {
		return less7Num;
	}

	public void setLess7Num(Integer less7Num) {
		this.less7Num = less7Num;
	}

	@Column(name = "no_fsj_zbwy_num")
	public Integer getNoFsjZbwyNum() {
		return noFsjZbwyNum;
	}

	public void setNoFsjZbwyNum(Integer noFsjZbwyNum) {
		this.noFsjZbwyNum = noFsjZbwyNum;
	}
	
	@Column(name = "dxz_num")
	public Integer getDxzNum() {
		return dxzNum;
	}

	public void setDxzNum(Integer dxzNum) {
		this.dxzNum = dxzNum;
	}

	@Column(name = "dy_num")
	public Integer getDyNum() {
		return dyNum;
	}

	public void setDyNum(Integer dyNum) {
		this.dyNum = dyNum;
	}

	@Column(name = "zbsj_num")
	public Integer getZbsjNum() {
		return zbsjNum;
	}

	public void setZbsjNum(Integer zbsjNum) {
		this.zbsjNum = zbsjNum;
	}

	@Column(name = "zbfsj_num")
	public Integer getZbfsjNum() {
		return zbfsjNum;
	}

	public void setZbfsjNum(Integer zbfsjNum) {
		this.zbfsjNum = zbfsjNum;
	}

	@Column(name = "zzwy_num")
	public Integer getZzwyNum() {
		return zzwyNum;
	}

	public void setZzwyNum(Integer zzwyNum) {
		this.zzwyNum = zzwyNum;
	}

	@Column(name = "xcwy_num")
	public Integer getXcwyNum() {
		return xcwyNum;
	}

	
	public void setXcwyNum(Integer xcwyNum) {
		this.xcwyNum = xcwyNum;
	}

	@Column(name = "jjwy_num")
	public Integer getJjwyNum() {
		return jjwyNum;
	}

	
	public void setJjwyNum(Integer jjwyNum) {
		this.jjwyNum = jjwyNum;
	}
	
	@Column(name = "qnwy_num")
	public Integer getQnwyNum() {
		return qnwyNum;
	}

	
	public void setQnwyNum(Integer qnwyNum) {
		this.qnwyNum = qnwyNum;
	}

	@Column(name = "ghwy_num")
	public Integer getGhwyNum() {
		return ghwyNum;
	}

	
	public void setGhwyNum(Integer ghwyNum) {
		this.ghwyNum = ghwyNum;
	}

	@Column(name = "fnwy_num")
	public Integer getFnwyNum() {
		return fnwyNum;
	}

	
	public void setFnwyNum(Integer fnwyNum) {
		this.fnwyNum = fnwyNum;
	}

	@Column(name = "bmwy_num")
	public Integer getBmwyNum() {
		return bmwyNum;
	}

	public void setBmwyNum(Integer bmwyNum) {
		this.bmwyNum = bmwyNum;
	}

	@Column(name = "updatetime")
	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}	


}