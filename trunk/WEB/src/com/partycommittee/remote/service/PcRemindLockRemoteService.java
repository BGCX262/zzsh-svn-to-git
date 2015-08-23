package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.remote.vo.PcRemindLockVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;
import com.partycommittee.service.PcRemindLockService;;

@Service("PcRemindLockRo")
@RemotingDestination(channels={"my-amf"})
public class PcRemindLockRemoteService {
	
	@Resource(name="PcRemindLockService")
	private PcRemindLockService pcRemindLockService;
	public void setPcRemindLockService(PcRemindLockService pcRemindLockService) {
		this.pcRemindLockService = pcRemindLockService;
	}

	@RemotingInclude
	public PageResultVo<PcRemindLockVo> getRemindLockByFilters(List<FilterVo> filters, PageHelperVo page) {
		return pcRemindLockService.getRemindLockByFilters(filters, page);
	}		
		
	@RemotingInclude
	public void updateRemindLock(PcRemindLockVo vo) {
		pcRemindLockService.updateRemindLock(vo);
	}	
	
	@RemotingInclude
	public PcRemindLockVo getRemindLockById(Integer id, Integer year, Integer q, Integer m, Integer tId) {
		return pcRemindLockService.getRemindLockById(id, year, q, m, tId);
	}

}
