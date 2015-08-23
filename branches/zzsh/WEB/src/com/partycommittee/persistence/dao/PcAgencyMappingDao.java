package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcAgencyMapping;

public interface PcAgencyMappingDao {

	public List<PcAgencyMapping> getAgencyMappingList();
	
	public List<PcAgencyMapping> getAgencyMappingByUserId(int userId);
	
	public void createAgencyMapping(PcAgencyMapping agencyMapping);
	
	public void updateAgencyMapping(PcAgencyMapping agencyMapping);
	
	public void deleteAgencyMapping(PcAgencyMapping agencyMapping);
	
	public void deleteAgencyMappingByAgencyId(Integer id);

	void updateAgencyMappingByUser(Long id, Integer rootAgencyId);
}
