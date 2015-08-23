package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcBackupDao;
import com.partycommittee.persistence.po.PcBackup;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

@Repository("PcBackupDaoImpl")
public class PcBackupDaoImpl extends JpaDaoBase implements PcBackupDao {

	@SuppressWarnings("unchecked")
	public PageResultVo<PcBackup> getBackups(PageHelperVo page) {
		
		PageResultVo<PcBackup> pageResult = new PageResultVo<PcBackup>();
		String sql = "from PcBackup ORDER BY id desc";
		String totalSql = "select count (*) from PcBackup";
		List<Long> totalList = super.find(totalSql);
		if (totalList != null) {
			page.setRecordCount(totalList.get(0).intValue());
			page.setPageCount(totalList.get(0).intValue()/page.getPageSize());
		}
		EntityManager em = super.getEntityManager();
		Query q = em.createQuery(sql);
		q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
		q.setMaxResults(page.getPageSize());
		pageResult.setList((List<PcBackup>)q.getResultList());
		pageResult.setPageHelper(page);
		return pageResult;		
	}
	
	public void createBackup(PcBackup pcBulletin) {
		try {
			pcBulletin.setId(null);
			super.persist(pcBulletin);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteBackupById(Integer bId) {
		try {
			final String sql = "delete from PcBackup  where id = " + bId;
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
