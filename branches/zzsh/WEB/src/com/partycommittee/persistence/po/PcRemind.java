package com.partycommittee.persistence.po;

import java.io.Serializable;
import javax.persistence.*;

import java.sql.Date;


/**
 * The persistent class for the pc_remind database table.
 * 
 */
@Entity
@Table(name="pc_remind")
public class PcRemind implements Serializable {
	private static final long serialVersionUID = 485572770621967497L;


	private Integer id;

	private Integer agencyId;

	private Integer codeId;

	private String ext;
	
	private String code;

	private String name;

	private Integer parentId;
	
	private String parentName;

	private Integer quarter;

	private Integer statusId;

	private Integer typeId;

	private Integer year;

    public PcRemind() {
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

	@Column(name = "ext")
	public String getExt() {
		return this.ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
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
	
	@Column(name = "parent_name")
	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	

	@Column(name = "quarter")
	public Integer getQuarter() {
		return this.quarter;
	}

	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}

	@Column(name = "status")
	public Integer getStatusId() {
		return this.statusId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
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
	
	@Column(name = "code")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	

}