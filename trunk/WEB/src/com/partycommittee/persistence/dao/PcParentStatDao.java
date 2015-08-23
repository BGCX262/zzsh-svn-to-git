package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcParentStat;
import com.partycommittee.persistence.po.PcRemindStat;

public interface PcParentStatDao {

	public List<PcParentStat> getListStatByParentId(Integer id, Integer year, Integer q) ;
}
