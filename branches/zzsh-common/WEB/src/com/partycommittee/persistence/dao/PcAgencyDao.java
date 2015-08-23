package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcAgency;

public interface PcAgencyDao {

	public List<PcAgency> getAgencyList();
	
	public PcAgency getAgencyById(int agencyId);
	
	public void createAgency(PcAgency agency);
	
	public void updateAgency(PcAgency agency);
	
	public void deleteAgency(PcAgency agency);

	List<PcAgency> getAgencyListByIds(String privilege);
	
	public String getMaxCodeByParentId(int parent_id);
}
