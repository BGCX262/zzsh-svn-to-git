package com.partycommittee.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcAgencyMappingDaoImpl;
import com.partycommittee.persistence.po.PcAgencyMapping;
import com.partycommittee.remote.vo.PcAgencyMappingVo;

@Transactional
@Service("PcAgencyMappingService")
public class PcAgencyMappingService {

	@Resource(name="PcAgencyMappingDaoImpl")
	private PcAgencyMappingDaoImpl pcAgencyMappingDaoImpl;
	public void setPcAgencyMappingDaoImpl(PcAgencyMappingDaoImpl pcAgencyMappingDaoImpl) {
		this.pcAgencyMappingDaoImpl = pcAgencyMappingDaoImpl;
	}
	
	public List<PcAgencyMappingVo> getAgencyMappingByUserId(int userId) {
		List<PcAgencyMappingVo> list = new ArrayList<PcAgencyMappingVo>();
		List<PcAgencyMapping> agencyMappingList = pcAgencyMappingDaoImpl.getAgencyMappingByUserId(userId);
		if (agencyMappingList != null && agencyMappingList.size() > 0) {
			for (PcAgencyMapping agencyMapping : agencyMappingList) {
				list.add(PcAgencyMappingVo.fromPcAgencyMapping(agencyMapping));
			}
		}
		return list;
	}
	
	public void createAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		PcAgencyMapping agencyMapping = PcAgencyMappingVo.toPcAgencyMapping(agencyMappingVo);
		pcAgencyMappingDaoImpl.createAgencyMapping(agencyMapping);
	}
	
	public void updateAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		PcAgencyMapping agencyMapping = PcAgencyMappingVo.toPcAgencyMapping(agencyMappingVo);
		pcAgencyMappingDaoImpl.updateAgencyMapping(agencyMapping);
	}
	
	public void deleteAgencyMapping(PcAgencyMappingVo agencyMappingVo) {
		PcAgencyMapping agencyMapping = PcAgencyMappingVo.toPcAgencyMapping(agencyMappingVo);
		pcAgencyMappingDaoImpl.deleteAgencyMapping(agencyMapping);
	}
}
