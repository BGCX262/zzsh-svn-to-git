package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcRemindConfig;;

public interface PcRemindConfigDao {
	
	public List<PcRemindConfig> getRemindConfigLists();
	
	public void updateRemindConfig(PcRemindConfig vo);
	
}
