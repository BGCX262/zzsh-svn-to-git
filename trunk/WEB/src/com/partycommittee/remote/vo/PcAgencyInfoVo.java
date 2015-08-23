package com.partycommittee.remote.vo;

import java.io.Serializable;
import java.util.List;

public class PcAgencyInfoVo implements Serializable {
	private static final long serialVersionUID = -8970260433260549190L;
	
	private Integer teamNumber;
	private Integer memberNumber;
	private List<PcMemberVo> dutyMemberList;
	
	public Integer getTeamNumber() {
		return teamNumber;
	}
	public void setTeamNumber(Integer teamNumber) {
		this.teamNumber = teamNumber;
	}
	public Integer getMemberNumber() {
		return memberNumber;
	}
	public void setMemberNumber(Integer memberNumber) {
		this.memberNumber = memberNumber;
	}
	public List<PcMemberVo> getDutyMemberList() {
		return dutyMemberList;
	}
	public void setDutyMemberList(List<PcMemberVo> dutyMemberList) {
		this.dutyMemberList = dutyMemberList;
	}
}
