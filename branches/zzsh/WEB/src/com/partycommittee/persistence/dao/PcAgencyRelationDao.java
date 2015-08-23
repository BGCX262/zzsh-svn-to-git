package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcAgencyRelation;

public interface PcAgencyRelationDao {

	public List<PcAgencyRelation> getAgencyRelationList();
	
	public List<PcAgencyRelation> getChildrenByParentId(int parentId);
	
	public PcAgencyRelation getParentByAgencyId(int id);
	
	public void createAgencyRelation(PcAgencyRelation agencyRelation);
	
	public void updateAgencyRelation(PcAgencyRelation agencyRelation);
	
	public void deleteAgencyRelation(PcAgencyRelation agencyRelation);
	
	public void deleteAgencyRelationByAgencyId(Integer id);
}
