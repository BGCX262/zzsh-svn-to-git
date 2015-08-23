package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcBackupVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;
import com.partycommittee.service.PcBackupService;

@Service("PcBackupRo")
@RemotingDestination(channels={"my-amf"})
public class PcBackupRemoteService {

	@Resource(name="PcBackupService")
	private PcBackupService pcBackupService;
	public void setPcMemberService(PcBackupService pcBackupService) {
		this.pcBackupService = pcBackupService;
	}
	
	@RemotingInclude
	public PageResultVo<PcBackupVo> getBackups(PageHelperVo page) {
		return pcBackupService.getBackups(page);
	}
	
	@RemotingInclude
	public void createBackup() {
		pcBackupService.createBackup();
	}
	
	@RemotingInclude
	public void deleteBackup(int bId) {
		pcBackupService.deleteBackup(bId);
	}	
}
