package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcRemindConfigVo;
import com.partycommittee.service.PcRemindConfigService;;

@Service("PcRemindConfigRo")
@RemotingDestination(channels={"my-amf"})
public class PcRemindConfigRemoteService {
	
	@Resource(name="PcRemindConfigService")
	private PcRemindConfigService pcRemindConfigService;
	public void setPcRemindLockService(PcRemindConfigService pcRemindConfigService) {
		this.pcRemindConfigService = pcRemindConfigService;
	}

	@RemotingInclude
	public List<PcRemindConfigVo> getRemindConfigLists() {
		return pcRemindConfigService.getRemindConfigLists();
	}		
		
	@RemotingInclude
	public void updateItems(List<PcRemindConfigVo> list) {
		pcRemindConfigService.updateItems(list);
	}	

}
