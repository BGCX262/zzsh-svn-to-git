package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcAgencyStats;

public interface PcAgencyStatsDao {
	
	public List<PcAgencyStats> getAgencyStatsByParentCode(Integer id, Integer year, Integer endM);
	
	public List<PcAgencyStats> getAgencyStatsByParentId(Integer id, Integer year, Integer endM);
	
	public List<PcAgencyStats> getAgencyStatsById(Integer id, Integer year, Integer endM);
	
	public List<PcAgencyStats> getAgencyStatsByCode(String code, Integer code_id, Integer year, Integer endM);
	
	public List<PcAgencyStats> getAgencyStatsByAdmin(Integer id, Integer year, Integer endM);
}
