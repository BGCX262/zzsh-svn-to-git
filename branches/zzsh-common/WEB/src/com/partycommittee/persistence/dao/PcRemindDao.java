package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcRemind;;

public interface PcRemindDao {
	
	public List<PcRemind> getListNoCommitByParentId(Integer agencyId, Integer year, Integer q, Integer tid);
	
	public List<PcRemind> getListByParentId(Integer agencyId, Integer year, Integer q, Integer tid, Integer sid);	
}
