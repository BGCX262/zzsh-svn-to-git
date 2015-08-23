package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcAgencyRelationVo;
import com.partycommittee.service.PcAgencyRelationService;

@Service("PcAgencyRelationRo")
@RemotingDestination(channels={"my-amf"})
public class PcAgencyRelationRemoteService {

	@Resource(name="PcAgencyRelationService")
	private PcAgencyRelationService pcAgencyRelationService;
	public void setPcAgencyRelationService(PcAgencyRelationService pcAgencyRelationService) {
		this.pcAgencyRelationService = pcAgencyRelationService;
	}
	
	public List<PcAgencyRelationVo> getAgencyRelationByParentId(int parentId) {
		return pcAgencyRelationService.getChildrenByAgencyId(parentId);
	}
	
	public void createAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		pcAgencyRelationService.createAgencyRelation(agencyRelationVo);
	}
	
	public void updateAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		pcAgencyRelationService.updateAgencyRelation(agencyRelationVo);
	}
	
	public void deleteAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		pcAgencyRelationService.deleteAgencyRelation(agencyRelationVo);
	}
}
