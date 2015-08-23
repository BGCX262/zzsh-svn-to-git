package com.partycommittee.persistence.daoimpl;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcRemindLockDao;
import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.persistence.po.PcRemindLock;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.helper.PageResultVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;

@Repository("PcRemindLockDaoImpl")
public class PcRemindLockDaoImpl extends JpaDaoBase implements PcRemindLockDao {

	@Override
	public void updateRemindLock(PcRemindLock vo) {
		try {
			if (vo.getMonth() == null) {
				vo.setMonth(0);
			}
			
			if (vo.getQuarter() == null) {
				vo.setQuarter(0);
			}			
			super.merge(vo);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}


	@SuppressWarnings("unchecked")
	@Override
	public PageResultVo<PcRemindLock> getRemindLockByFilters(List<FilterVo> filters, PageHelperVo page) {
		try {
			String where = " WHERE agencyId not in (select id FROM PcAgency WHERE invalid_datetime > 0) " ;
			for(FilterVo item:filters) {
				if (item.getId().equals("year")) {
					where = where + " AND year =" + item.getData();
				}
				
				if (item.getId().equals("quarter")) {
					where = where + " AND quarter=" + item.getData();
				}
				
				
				if (item.getId().equals("month")) {
					where = where + " AND month=" + item.getData();
				}					
				
				if (item.getId().equals("agencyId")) {
					where = where + " AND agencyId=" + item.getData();
				}
				
				if (item.getId().equals("parentId")) {
					where = where + " AND parentId=" + item.getData();
				}		
				
				if (item.getId().equals("parentCode")) {
					where = where + " AND code like '" + item.getData() + "%'";
				}	
				
				if (item.getId().equals("typeId")) {
					where = where + " AND typeId=" + item.getData();
				}	
			
			}
			
			
			
			
			PageResultVo<PcRemindLock> pageResult = new PageResultVo<PcRemindLock>();
			String sql = "from PcRemindLock " + where;
			String totalSql = "select count (*) from PcRemindLock " + where;
			List<Long> totalList = super.find(totalSql);
			if (totalList != null) {
				page.setRecordCount(totalList.get(0).intValue());
				page.setPageCount(totalList.get(0).intValue()/page.getPageSize());
			}
			EntityManager em = super.getEntityManager();
			Query q = em.createQuery(sql);
			q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
			q.setMaxResults(page.getPageSize());
			pageResult.setList((List<PcRemindLock>)q.getResultList());
			pageResult.setPageHelper(page);
			return pageResult;			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PcRemindLock getRemindLockById(Integer id, Integer year, Integer q, Integer m, Integer tId) {
		try {
			List<PcRemindLock> list =  super.find("from PcRemindLock where agency_id = " + id + " AND year = " + year + " and quarter = " + q + " and month = " + m + "  AND type_id = " + tId + " ");
			if (list != null && list.size() > 0) {
				return list.get(0);
			}			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	

}
