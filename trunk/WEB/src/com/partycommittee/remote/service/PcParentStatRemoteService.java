package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcParentStatVo;
import com.partycommittee.service.PcParentStatService;

@Service("PcParentStatRo")
@RemotingDestination(channels={"my-amf"})
public class PcParentStatRemoteService {
	
	@Resource(name="PcParentStatService")
	private PcParentStatService pcParentStatService;
	public void setPcParentStatService(PcParentStatService pcParentStatService) {
		this.pcParentStatService = pcParentStatService;
	}
	
	@RemotingInclude
	public List<PcParentStatVo> getListStatByParentId(Integer id, Integer year, Integer q) {
		return pcParentStatService.getListStatByParentId(id, year, q);
	}

}
