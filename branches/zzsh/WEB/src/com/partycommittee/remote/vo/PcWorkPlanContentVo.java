package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.Date;

import com.partycommittee.persistence.po.PcWorkPlanContent;

public class PcWorkPlanContentVo implements Serializable {
	private static final long serialVersionUID = -8896809737528193945L;

	private Integer id;
	private Integer workplanId;
	private Integer type;
	private String memberName;
	private String content;
	private Date updatetime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getWorkplanId() {
		return workplanId;
	}
	public void setWorkplanId(Integer workplanId) {
		this.workplanId = workplanId;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
	public static PcWorkPlanContentVo fromPcWorkPlanContent(PcWorkPlanContent workPlanContent) {
		PcWorkPlanContentVo workPlanContentVo = new PcWorkPlanContentVo();
		workPlanContentVo.setContent(workPlanContent.getContent());
		workPlanContentVo.setId(workPlanContent.getId());
		workPlanContentVo.setMemberName(workPlanContent.getMemberName());
		workPlanContentVo.setType(workPlanContent.getType());
		workPlanContentVo.setUpdatetime(workPlanContent.getUpdatetime());
		workPlanContentVo.setWorkplanId(workPlanContent.getWorkplanId());
		return workPlanContentVo;
	}
	
	public static PcWorkPlanContent toPcWorkPlanContent(PcWorkPlanContentVo workPlanContentVo) {
		PcWorkPlanContent workPlanContent = new PcWorkPlanContent();
		workPlanContent.setContent(workPlanContentVo.getContent());
		workPlanContent.setId(workPlanContentVo.getId());
		workPlanContent.setMemberName(workPlanContentVo.getMemberName());
		workPlanContent.setType(workPlanContentVo.getType());
		workPlanContent.setUpdatetime(workPlanContentVo.getUpdatetime());
		workPlanContent.setWorkplanId(workPlanContentVo.getWorkplanId());
		return workPlanContent;
	}
}
