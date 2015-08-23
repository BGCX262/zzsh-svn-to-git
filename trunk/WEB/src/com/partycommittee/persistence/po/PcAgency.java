package com.partycommittee.persistence.po;

import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@Entity
@Table(name = "pc_agency")
public class PcAgency implements java.io.Serializable {
	private static final long serialVersionUID = 2648939911474179327L;

	/** default constructor */
	public PcAgency() {
	}
	
	private Integer id;
	private Integer parentId;
	private String name;
	private String code;

	private Integer codeId;
	private Integer number;
	private Integer memberId;
	private String tel;
	private Date setupDatetime;
	private Date createDatetime;
	private Integer invalidDatetime;
	private String comment;

	private Integer pcount;//'党小组数',
	private Integer zbnum;//'支部人数',
	private String zbsj;//'支部书记',
	private String zbfsj;//'支部副书记',
	private String zzwy;//'组织委员',
	private String xcwy;//'宣传委员',
	private String jjwy;//'纪检委员',
	private String qnwy;//'青年委员',
	private String ghwy;//'工会委员',
	private String fnwy;//'妇女委员',
	private String ext;//'saas扩展字段',
	
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer getId() {
		return this.id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "name")
	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name = "code")
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}	
	
	@Column(name = "code_id")
	public Integer getCodeId() {
		return this.codeId;
	}
	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}

	@Column(name = "number")
	public Integer getNumber() {
		return this.number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	
	@Column(name = "member_id")
	public Integer getMemberId() {
		return this.memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	
	@Column(name = "tel")
	public String getTel() {
		return this.tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	@Column(name = "ext")
	public String getExt() {
		return this.ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "setup_datetime", length = 23)
	public Date getSetupDatetime() {
		return this.setupDatetime;
	}
	public void setSetupDatetime(Date setupDatetime) {
		this.setupDatetime = setupDatetime;
	}
	

	public void setCreateDatetime(Date createDatetime) {
		this.createDatetime = createDatetime;
	}	
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_datetime", length = 23)	
	public Date getCreateDatetime() {
		return createDatetime;
	}	
		
	@Column(name = "comment")
	public String getComment() {
		return this.comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@Column(name = "p_count")
	public Integer getPcount() {
		return pcount;
	}
	public void setPcount(Integer pCount) {
		pcount = pCount;
	}
	
	@Column(name = "zb_num")
	public Integer getZbnum() {
		return zbnum;
	}
	
	public void setZbnum(Integer zbNum) {
		zbnum = zbNum;
	}
	
	@Column(name = "zbsj")
	public String getZbsj() {
		return zbsj;
	}
	public void setZbsj(String zbsj) {
		this.zbsj = zbsj;
	}
	
	@Column(name = "zbfsj")
	public String getZbfsj() {
		return zbfsj;
	}
	public void setZbfsj(String zbfsj) {
		this.zbfsj = zbfsj;
	}
	
	@Column(name = "zzwy")
	public String getZzwy() {
		return zzwy;
	}
	public void setZzwy(String zzwy) {
		this.zzwy = zzwy;
	}
	
	@Column(name = "xcwy")
	public String getXcwy() {
		return xcwy;
	}
	public void setXcwy(String xcwy) {
		this.xcwy = xcwy;
	}
	
	@Column(name = "jjwy")
	public String getJjwy() {
		return jjwy;
	}
	public void setJjwy(String jjwy) {
		this.jjwy = jjwy;
	}
	
	@Column(name = "qnwy")
	public String getQnwy() {
		return qnwy;
	}
	public void setQnwy(String qnwy) {
		this.qnwy = qnwy;
	}
	
	@Column(name = "ghwy")
	public String getGhwy() {
		return ghwy;
	}
	public void setGhwy(String ghwy) {
		this.ghwy = ghwy;
	}
	
	@Column(name = "fnwy")
	public String getFnwy() {
		return fnwy;
	}
	public void setFnwy(String fnwy) {
		this.fnwy = fnwy;
	}
	
	@Column(name = "parent_id")
	public Integer getParentId() {
		return parentId;
	}
	
	
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	@Column(name = "invalid_datetime")
	public Integer getInvalidDatetime() {
		return invalidDatetime;
	}
	public void setInvalidDatetime(Integer invalidDatetime) {
		this.invalidDatetime = invalidDatetime;
	}
	

}