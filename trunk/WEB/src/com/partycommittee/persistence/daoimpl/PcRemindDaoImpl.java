package com.partycommittee.persistence.daoimpl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcRemindDao;
import com.partycommittee.persistence.po.PcRemind;;

@Repository("PcRemindDaoImpl")
public class PcRemindDaoImpl extends JpaDaoBase implements PcRemindDao {
	

	@SuppressWarnings("unchecked")
	@Override
	public List<PcRemind> getListNoCommitByParentId(Integer id, Integer year, Integer q, Integer tid) {
		try {
			if (id == null) {
				return null;
			}
			EntityManager em = super.getEntityManager();
			
			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);
			// 获取直属党支部
			Query query=em.createQuery("from PcRemind where code like '"+code+"%' AND year = " + year + " and quarter = " + q + " AND type_id = " + tid + " AND status < 3 Order by agency_id ASC ");
			List<PcRemind> list =  query.getResultList();
			
			
//			// 获取直属党支部
//			Query query=em.createQuery("from PcRemind where parent_id = " + id + " AND year = " + year + " and quarter = " + q + " AND type_id = " + tid + " AND status <= 1 Order by agency_id ASC ");
//			List<PcRemind> list =  query.getResultList();
//			
//			// 获取下级党委或党总支下属党支部:
//			Query sql = em.createQuery("SELECT id FROM PcAgency WHERE id in (SELECT agencyId FROM PcAgencyRelation WHERE parent_id = " + id + "  ) AND code_id in (7,8)" );
//			List<Integer> rs = sql.getResultList();
//			
//			if (rs.size() > 0) {
//				String ids = "";
//				for (Integer idItem : rs) {
//					if (ids.equals("")) {
//						ids = idItem + "";
//					} else {
//						ids += "," + idItem;
//					}
//				}
//
//				Query query1=em.createQuery("from PcRemind where   parent_id in (" + ids + ") AND year = " + year + " and quarter = " + q + " AND type_id = " + tid + " AND status<=1 Order by agency_id ASC ");
//				List<PcRemind> list1 = query1.getResultList();
//				list.addAll(list1);
//			}			
			
			return list;
//			return super.find("from PcRemind where parent_id = " + id + " AND year = " + year + " and quarter = " + q + " AND type_id = " + tid + " AND status <= 1 Order by agency_id ASC ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PcRemind> getListByParentId(Integer id, Integer year, Integer q, Integer tid, Integer sid) {
		try {
			if (id == null) {
				return null;
			}
			EntityManager em = super.getEntityManager();
			
			Query sql1 = em.createQuery("select code from PcAgency where id = " + id);
			List<String> rs = sql1.getResultList();
			String code = rs.get(0);
			// 获取直属党支部
			Query query=em.createQuery("from PcRemind where code like '"+code+"%' AND year = " + year + " and quarter = " + q + " AND type_id = " + tid + " AND status = " + sid + " Order by agency_id ASC ");
			List<PcRemind> list =  query.getResultList();
//			// 获取下级党委或党总支下属党支部:
//			Query sql = em.createQuery("SELECT id FROM PcAgency WHERE id in (SELECT agencyId FROM PcAgencyRelation WHERE parent_id = " + id + "  ) AND code_id in (7,8)" );
//			List<Integer> rs = sql.getResultList();
//			
//			if (rs.size() > 0) {
//				String ids = "";
//				for (Integer idItem : rs) {
//					if (ids.equals("")) {
//						ids = idItem + "";
//					} else {
//						ids += "," + idItem;
//					}
//				}
//
//				Query query1=em.createQuery("from PcRemind where   parent_id in (" + ids + ") AND year = " + year + " and quarter = " + q + " AND type_id = " + tid + " AND status = " + sid + " Order by agency_id ASC ");
//				List<PcRemind> list1 = query1.getResultList();
//				list.addAll(list1);
//			}

			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
