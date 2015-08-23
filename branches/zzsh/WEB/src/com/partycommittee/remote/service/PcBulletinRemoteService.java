package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcBulletinVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;
import com.partycommittee.service.PcBulletinService;

@Service("PcBulletinRo")
@RemotingDestination(channels={"my-amf"})
public class PcBulletinRemoteService {

	@Resource(name="PcBulletinService")
	private PcBulletinService pcBulletinService;
	public void setPcMemberService(PcBulletinService pcBulletinService) {
		this.pcBulletinService = pcBulletinService;
	}
	
	@RemotingInclude
	public PageResultVo<PcBulletinVo> getBulletins(PageHelperVo page) {
		return pcBulletinService.getBulletins(page);
	}
	
	@RemotingInclude
	public PcBulletinVo getBulletin(int bId) {
		return pcBulletinService.getBulletin(bId);
	}
	
	@RemotingInclude
	public void createBulletin(PcBulletinVo pevo) {
		pcBulletinService.createBulletin(pevo);
	}
	
	@RemotingInclude
	public void updateBulletin(PcBulletinVo pevo) {
		pcBulletinService.updateBulletin(pevo);
	}
	
	@RemotingInclude
	public void deleteBulletin(int bId) {
		pcBulletinService.deleteBulletin(bId);
	}	
}
