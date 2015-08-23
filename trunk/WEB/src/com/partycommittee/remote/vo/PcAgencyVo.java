package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;

import com.partycommittee.persistence.po.PcAgency;

public class PcAgencyVo implements Serializable {
	private static final long serialVersionUID = 389989221452220832L;
	
	private Integer id;
	private Integer parentId;
	private String name;
	private String code;
	private Integer codeId;
	private Integer number;
	private Integer memberId;
	private PcMemberVo member;
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
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}	
	public Integer getCodeId() {
		return this.codeId;
	}
	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}
	public Integer getNumber() {
		return number;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public PcMemberVo getMember() {
		return this.member;
	}
	public void setMember(PcMemberVo member) {
		this.member = member;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	public Date getSetupDatetime() {
		return setupDatetime;
	}
	public void setSetupDatetime(Date setupDatetime) {
		this.setupDatetime = setupDatetime;
	}
	
	public Date getCreateDatetime() {
		return createDatetime;
	}
	public void setCreateDatetime(Date createDatetime) {
		this.createDatetime = createDatetime;
	}	
	
	public String getComment() {
		return this.comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public Integer getPcount() {
		return pcount;
	}
	public void setPcount(Integer pcount) {
		this.pcount = pcount;
	}
	public Integer getZbnum() {
		return zbnum;
	}
	public void setZbnum(Integer zbnum) {
		this.zbnum = zbnum;
	}
	
	public String getZbsj() {
		return zbsj;
	}
	public void setZbsj(String zbsj) {
		this.zbsj = zbsj;
	}
	public String getZzwy() {
		return zzwy;
	}
	public void setZzwy(String zzwy) {
		this.zzwy = zzwy;
	}
	public String getXcwy() {
		return xcwy;
	}
	public void setXcwy(String xcwy) {
		this.xcwy = xcwy;
	}
	public String getJjwy() {
		return jjwy;
	}
	public void setJjwy(String jjwy) {
		this.jjwy = jjwy;
	}
	public String getQnwy() {
		return qnwy;
	}
	public void setQnwy(String qnwy) {
		this.qnwy = qnwy;
	}
	public String getGhwy() {
		return ghwy;
	}
	public void setGhwy(String ghwy) {
		this.ghwy = ghwy;
	}
	public String getFnwy() {
		return fnwy;
	}
	public void setFnwy(String fnwy) {
		this.fnwy = fnwy;
	}
	
	public String getZbfsj() {
		return zbfsj;
	}
	public void setZbfsj(String zbfsj) {
		this.zbfsj = zbfsj;
	}	
	
	public Integer getInvalidDatetime() {
		return invalidDatetime;
	}
	public void setInvalidDatetime(Integer invalidDatetime) {
		this.invalidDatetime = invalidDatetime;
	}	
	
	public static PcAgency toPcAgency(PcAgencyVo agencyVo) {
		PcAgency agency = new PcAgency();
		agency.setExt(agencyVo.getExt());
		agency.setId(agencyVo.getId());
		agency.setParentId(agencyVo.getParentId());
		agency.setMemberId(agencyVo.getMemberId());
		agency.setName(agencyVo.getName());
		agency.setCode(agencyVo.getCode());
		agency.setCodeId(agencyVo.getCodeId());
		agency.setNumber(agencyVo.getNumber());
		agency.setSetupDatetime(agencyVo.getSetupDatetime());
		agency.setCreateDatetime(agencyVo.getCreateDatetime());
		agency.setInvalidDatetime(agencyVo.getInvalidDatetime());
		agency.setTel(agencyVo.getTel());
		agency.setComment(agencyVo.getComment());
		agency.setPcount(agencyVo.getPcount());
		agency.setZbnum(agencyVo.getZbnum());
		agency.setZbsj(agencyVo.getZbsj());
		agency.setZbfsj(agencyVo.getZbfsj());
		agency.setZzwy(agencyVo.getZzwy());
		agency.setXcwy(agencyVo.getXcwy());
		agency.setJjwy(agencyVo.getJjwy());
		agency.setQnwy(agencyVo.getQnwy());
		agency.setGhwy(agencyVo.getGhwy());
		agency.setFnwy(agencyVo.getFnwy());
		return agency;
	}
	
	public static PcAgencyVo fromPcAgency(PcAgency agency) {
		PcAgencyVo agencyVo = new PcAgencyVo();
		agencyVo.setExt(agency.getExt());
		agencyVo.setId(agency.getId());
		agencyVo.setParentId(agency.getParentId());
		agencyVo.setMemberId(agency.getMemberId());
		agencyVo.setName(agency.getName());
		agencyVo.setCode(agency.getCode());
		agencyVo.setCodeId(agency.getCodeId());
		agencyVo.setNumber(agency.getNumber());
		agencyVo.setSetupDatetime(agency.getSetupDatetime());
		agencyVo.setCreateDatetime(agency.getCreateDatetime());
		agencyVo.setInvalidDatetime(agency.getInvalidDatetime());
		agencyVo.setTel(agency.getTel());
		agencyVo.setComment(agency.getComment());
		agencyVo.setPcount(agency.getPcount());
		agencyVo.setZbnum(agency.getZbnum());
		agencyVo.setZbsj(agency.getZbsj());
		agencyVo.setZbfsj(agency.getZbfsj());
		agencyVo.setZzwy(agency.getZzwy());
		agencyVo.setXcwy(agency.getXcwy());
		agencyVo.setJjwy(agency.getJjwy());
		agencyVo.setQnwy(agency.getQnwy());
		agencyVo.setGhwy(agency.getGhwy());
		agencyVo.setFnwy(agency.getFnwy());		
		return agencyVo;
		
	}

}
