package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcStats;
import com.partycommittee.remote.vo.PcStatsVo;


public interface PcStatsDao {

//	public List<PcStatsVo> getStatsById(Integer id, Integer year, List<Integer> qs, Integer typeId);

	public List<PcStatsVo> getStatsByParentCode(Integer id, Integer year, List<Integer> qs, Integer typeId);
	
	public List<PcStatsVo> getZwhStatsById(Integer id, Integer year,
			Integer startM, Integer endM);
	
	public List<PcStatsVo> getZwhStatsByParentCode(Integer id, Integer year,
			Integer startM, Integer endM);

}
