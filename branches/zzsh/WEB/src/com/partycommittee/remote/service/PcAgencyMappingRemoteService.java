package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcAgencyMappingVo;
import com.partycommittee.service.PcAgencyMappingService;

@Service("PcAgencyMappingRo")
@RemotingDestination(channels={"my-amf"})
public class PcAgencyMappingRemoteService {

	@Resource(name="PcAgencyMappingService")
	private PcAgencyMappingService pcAgencyMappingService;
	public void setPcAgencyMappingService(PcAgencyMappingService pcAgencyMappingService) {
		this.pcAgencyMappingService = pcAgencyMappingService;
	}
	
	public List<PcAgencyMappingVo> getAgencyMappingListByUserId(int userId) {
		return pcAgencyMappingService.getAgencyMappingByUserId(userId);
	}
	
	public void createAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		pcAgencyMappingService.createAgencyMapping(agencyMappingVo);
	}
	
	public void updateAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		pcAgencyMappingService.updateAgencyMapping(agencyMappingVo);
	}
	
	public void deleteAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		pcAgencyMappingService.deleteAgencyMapping(agencyMappingVo);
	}
}
