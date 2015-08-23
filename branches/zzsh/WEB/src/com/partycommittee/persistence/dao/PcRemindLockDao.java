package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcRemindLock;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

public interface PcRemindLockDao {
	
	public PageResultVo<PcRemindLock> getRemindLockByFilters(List<FilterVo> filters, PageHelperVo page);
	
	public void updateRemindLock(PcRemindLock vo);
	
	public PcRemindLock getRemindLockById(Integer id, Integer year, Integer q, Integer m, Integer tId);
	
}
