package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

public interface PcMemberDao {

	public List<PcMember> getMemberList();
	
	public List<PcMember> getMemberListByAgencyId(int agencyId);
	
	public PageResultVo<PcMember> getMemberListPageByAgencyId(int agencyId, PageHelperVo page);
	
	public PcMember getMemberById(int id);
	
	public void createPcMember(PcMember member);
	
	public void updatePcMember(PcMember member);
	
	public void deletePcMember(PcMember member);
	
	public List<PcMember> getMemberByDutyId(int id, int dutyId);
}
