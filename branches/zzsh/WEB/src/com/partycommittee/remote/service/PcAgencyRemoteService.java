package com.partycommittee.remote.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcAgencyInfoVo;
import com.partycommittee.remote.vo.PcAgencyMappingVo;
import com.partycommittee.remote.vo.PcAgencyRelationVo;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.service.PcAgencyMappingService;
import com.partycommittee.service.PcAgencyRelationService;
import com.partycommittee.service.PcAgencyService;

@Service("PcAgencyRo")
@RemotingDestination(channels={"my-amf"})
public class PcAgencyRemoteService {

	@Resource(name="PcAgencyService")
	private PcAgencyService pcAgencyService;
	public void setPcAgencyService(PcAgencyService pcAgencyService) {
		this.pcAgencyService = pcAgencyService;
	}
	
	@Resource(name="PcAgencyMappingService")
	private PcAgencyMappingService pcAgencyMappingService;
	public void setPcAgencyMappingService(PcAgencyMappingService pcAgencyMappingService) {
		this.pcAgencyMappingService = pcAgencyMappingService;
	}
	
	@Resource(name="PcAgencyRelationService")
	private PcAgencyRelationService pcAgencyRelationService;
	public void setPcAgencyRelationService(PcAgencyRelationService pcAgencyRelationService) {
		this.pcAgencyRelationService = pcAgencyRelationService;
	}
	
	@RemotingInclude
	public PcAgencyVo getRootAgencyByUserId(int userId) {
		List<PcAgencyVo> agencyList = getAgencyListByUserId(userId);
		if (agencyList == null || agencyList.size() == 0) {
			return null;
		}
		PcAgencyVo temp = null;
		for (PcAgencyVo agencyVo : agencyList) {
			if (temp == null) {
				temp = agencyVo;
			} else {
				if (agencyVo.getCodeId() < temp.getCodeId()) {
					temp = agencyVo;
				}
			}
		}
		if (temp != null) {
			getParentId(temp);
		}
		return temp;
	}
	
	private void getParentId(PcAgencyVo agencyVo) {
		PcAgencyRelationVo relation = pcAgencyRelationService.getParentByAgencyId(agencyVo.getId());
		if (relation != null) {
			agencyVo.setParentId(relation.getParentId());
		}
	}
	
	private List<PcAgencyVo> getAgencyListByUserId(int userId) {
		List<PcAgencyVo> agencyList = new ArrayList<PcAgencyVo>();
		List<PcAgencyMappingVo> agencyMappings = pcAgencyMappingService.getAgencyMappingByUserId(userId);
		if (agencyMappings == null || agencyMappings.size() == 0) {
			return null;
		}
		for (PcAgencyMappingVo agencyMapping : agencyMappings) {
			PcAgencyVo agency = getAgencyById(agencyMapping.getAgencyId());
			if (agency != null) {
				agencyList.add(agency);
			}
		}
		return agencyList;
	}
	
	@RemotingInclude
	public List<PcAgencyVo> getChildren(int agencyId) {

		return pcAgencyService.getChildrenAgencyListByCode(agencyId);
	}
	
	@RemotingInclude
	public List<PcAgencyVo> getChildrenRevert(int agencyId) {

		return pcAgencyService.getHistoryChildrenAgencyListByCode(agencyId);
	}	
	
	
	// 取出有管理下级职能的部门
	@RemotingInclude
	public List<PcAgencyVo> getChildrenOnlyParent(int agencyId) {
		return pcAgencyService.getChildrenAgencyListByCodeOnlyParent(agencyId);
	}	
	
	
	@RemotingInclude
	public PcAgencyVo getAgencyById(int agencyId) {
		return pcAgencyService.getAgencyById(agencyId);
	}
	
	@RemotingInclude
	public void createAgency(PcAgencyVo agencyVo) {
		pcAgencyService.createAgency(agencyVo);
	}
	
	@RemotingInclude
	public void updateAgency(PcAgencyVo agencyVo) {
		pcAgencyService.updateAgency(agencyVo);
	}
	
	@RemotingInclude
	public void moveAgency(PcAgencyVo agencyVo) {
		pcAgencyService.moveAgency(agencyVo);
	}	
	
	@RemotingInclude
	public void deleteAgency(PcAgencyVo agencyVo) {
		pcAgencyService.deleteAgency(agencyVo);
	}
	
	@RemotingInclude
	public PcAgencyInfoVo getAgencyInfo(Integer agencyId) {
		return pcAgencyService.getAgencyInfo(agencyId);
	}
	
	@RemotingInclude
	public PcAgencyVo getParentAgency(Integer agencyId) {
		return pcAgencyService.getParentAgency(agencyId);
	}
	
	@RemotingInclude
	public String exportToDoc(Integer agencyId, Integer year) {
		return pcAgencyService.exportToDoc(agencyId, year);
	}	
	
	@RemotingInclude
	public void revertAgency(PcAgencyVo agencyVo) {
		pcAgencyService.revertAgency(agencyVo);
	}	
	
	@RemotingInclude
	public Integer getAgencyCount() {
		return pcAgencyService.getAgencyCount();
	}		
	
	@RemotingInclude
	public Integer getAgencyDwCount() {
		return pcAgencyService.getAgencyDwCount();
	}	
}
