package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcRemindStat;;

public interface PcRemindStatDao {

	public List<PcRemindStat> getListWorkPlanById(Integer id, Integer year, Integer q, Integer s);
		
	public List<PcRemindStat> getListWorkPlanByParentId(Integer id, Integer year, Integer q, Integer s);

	public List<PcRemindStat> getListMeetingById(Integer id, Integer year, Integer q, Integer s);
	
	public List<PcRemindStat> getListMeetingByParentId(Integer id, Integer year, Integer q, Integer s);	
}
