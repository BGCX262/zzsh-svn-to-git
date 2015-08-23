package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcDutyCodeVo;
import com.partycommittee.remote.vo.PcMemberVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;
import com.partycommittee.service.PcMemberService;

@Service("PcMemberRo")
@RemotingDestination(channels={"my-amf"})
public class PcMemberRemoteService {

	@Resource(name="PcMemberService")
	private PcMemberService pcMemberService;
	public void setPcMemberService(PcMemberService pcMemberService) {
		this.pcMemberService = pcMemberService;
	}
	
	@RemotingInclude
	public List<PcMemberVo> getMemberListByAgencyId(int agencyId) {
		return pcMemberService.getMemberListByAgencyId(agencyId);
	}
	
	@RemotingInclude
	public PageResultVo<PcMemberVo> getMemberListPageByAgencyId(int agencyId, PageHelperVo page) {
		return pcMemberService.getMemberListPageByAgencyId(agencyId, page);
	}
	
	@RemotingInclude
	public void createMember(PcMemberVo memberVo) {
		pcMemberService.createMember(memberVo);
	}
	
	@RemotingInclude
	public void updateMember(PcMemberVo memberVo) {
		pcMemberService.updateMember(memberVo);
	}
	
	@RemotingInclude
	public void deleteMembers(List<PcMemberVo> memberList) {
		if (memberList == null || memberList.size() == 0) {
			return;
		}
		for (PcMemberVo memberItem : memberList) {
			pcMemberService.deleteMember(memberItem);
		}
	}
	
	@RemotingInclude
	public List<PcDutyCodeVo> getDutyCodeList() {
		return pcMemberService.getDutyCodeList();
	}	
	
	@RemotingInclude
	public String exportToexcel(int agencyId) {
		return pcMemberService.exportToexcel(agencyId);
	}
		
}
