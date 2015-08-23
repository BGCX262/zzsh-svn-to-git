package com.partycommittee.service;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcRemindLockDaoImpl;
import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.persistence.po.PcRemindLock;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcMemberVo;
import com.partycommittee.remote.vo.PcRemindLockVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;


@Transactional
@Service("PcRemindLockService")
public class PcRemindLockService {

	@Resource(name="PcRemindLockDaoImpl")
	private PcRemindLockDaoImpl pcRemindLockDaoImpl;
	public void setPcRemindLockDaoImpl(PcRemindLockDaoImpl pcRemindLockDaoImpl) {
		this.pcRemindLockDaoImpl = pcRemindLockDaoImpl;
	}

	public PageResultVo<PcRemindLockVo> getRemindLockByFilters(List<FilterVo> filters, PageHelperVo page) {
		PageResultVo<PcRemindLockVo> result = new PageResultVo<PcRemindLockVo>();
		List<PcRemindLockVo> list = new ArrayList<PcRemindLockVo>();
		PageResultVo<PcRemindLock> pageResult = pcRemindLockDaoImpl.getRemindLockByFilters(filters, page);
		if (pageResult == null) {
			return null;
		}
		result.setPageHelper(pageResult.getPageHelper());
		if (pageResult.getList() != null && pageResult.getList().size() > 0) {
			for (PcRemindLock item : pageResult.getList()) {
				list.add(PcRemindLockVo.fromPcRemindLock(item));
			}
		}
		result.setList(list);
		return result;		
		
	}
	
	public void updateRemindLock(PcRemindLockVo pevo) {
		if (pevo.getStatusId() ==8) {
			//解锁后，默认延长一周时间后锁定.
			
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			 Calendar cal=Calendar.getInstance();
			 cal.add(Calendar.DATE, 7);
			 Date date=cal.getTime();
			 pevo.setDelayDate(df.format(date));
		}
		PcRemindLock vo = PcRemindLockVo.toPcRemindLock(pevo);
		pcRemindLockDaoImpl.updateRemindLock(vo);
	}
	
	public PcRemindLockVo getRemindLockById(Integer id, Integer year, Integer q, Integer m, Integer tId) {
		PcRemindLockVo vo = new PcRemindLockVo();
		PcRemindLock pevo = pcRemindLockDaoImpl.getRemindLockById(id, year, q, m, tId);
		return vo.fromPcRemindLock(pevo);
	}
	

}
