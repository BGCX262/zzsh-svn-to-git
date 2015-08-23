package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcBulletinDao;
import com.partycommittee.persistence.po.PcBulletin;
import com.partycommittee.persistence.po.PcRemindLock;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

@Repository("PcBulletinDaoImpl")
public class PcBulletinDaoImpl extends JpaDaoBase implements PcBulletinDao {

	@SuppressWarnings("unchecked")
	public PageResultVo<PcBulletin> getBulletins(PageHelperVo page) {
		String where = " WHERE expire_time >= DATE_FORMAT( NOW( ) ,  '%Y-%m-%d' ) ";
		PageResultVo<PcBulletin> pageResult = new PageResultVo<PcBulletin>();
		String sql = "from PcBulletin " + where + " ORDER BY id desc";
		String totalSql = "select count (*) from PcBulletin " + where;
		List<Long> totalList = super.find(totalSql);
		if (totalList != null) {
			page.setRecordCount(totalList.get(0).intValue());
			page.setPageCount(totalList.get(0).intValue()/page.getPageSize());
		}
		EntityManager em = super.getEntityManager();
		Query q = em.createQuery(sql);
		q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
		q.setMaxResults(page.getPageSize());
		pageResult.setList((List<PcBulletin>)q.getResultList());
		pageResult.setPageHelper(page);
		return pageResult;		
	}
	
	@SuppressWarnings("unchecked")
	public PcBulletin getBulletin(Integer bId) {
		try {
			List<PcBulletin> list = super.find("from PcBulletin where id = ? ", bId);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}



	public void createBulletin(PcBulletin pcBulletin) {
		try {
			pcBulletin.setId(null);
			super.persist(pcBulletin);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void upateBulletin(PcBulletin pcBulletin) {
		try {
			super.merge(pcBulletin);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public void setIsIndex() {
		try {
			final String sql = "update PcBulletin  set is_index = 0";
			this.getJpaTemplate().execute(new JpaCallback<Object>(){
				public Object doInJpa(EntityManager em)throws PersistenceException {
					int size = em.createQuery(sql).executeUpdate();
					return size;
				}
	 		 });
		} catch (Exception e) {
			e.printStackTrace();
		}
	}		
	
	public void deleteBulletinById(Integer bId) {
		try {
			final String sql = "delete from PcBulletin  where id = " + bId;
			this.getJpaTemplate().execute(new JpaCallback<Object>(){
				public Object doInJpa(EntityManager em)throws PersistenceException {
					int size = em.createQuery(sql).executeUpdate();
					return size;
				}
	 		 });
		} catch (Exception e) {
			e.printStackTrace();
		}
	}		
	
}
