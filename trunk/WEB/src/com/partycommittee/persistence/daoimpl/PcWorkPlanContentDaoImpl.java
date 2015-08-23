package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcWorkPlanContentDao;
import com.partycommittee.persistence.po.PcWorkPlanContent;

@Repository("PcWorkPlanContentDaoImpl")
public class PcWorkPlanContentDaoImpl extends JpaDaoBase implements PcWorkPlanContentDao {

	@SuppressWarnings("unchecked")
	@Override
	public PcWorkPlanContent getContentByWorkPlanId(Integer workPlanId) {
		try {
			List<PcWorkPlanContent> list = super.find("from PcWorkPlanContent where workplanId = ? and type = ?", 
					workPlanId, 1);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void createContent(PcWorkPlanContent content) {
		try {
			content.setId(null);
			super.persist(content);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void upateContent(PcWorkPlanContent content) {
		try {
			super.merge(content);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public PcWorkPlanContent getContentByWorkPlanIdAndType(Integer workPlanId, int i) {
		try {
			List<PcWorkPlanContent> list = super.find("from PcWorkPlanContent where workplanId = ? and type = ?", 
					workPlanId, i);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public void deleteWorkPlanContentByWorkPlanId(Integer workPlanId) {
		try {
			final String sql = "delete from PcWorkPlanContent  where workplanId = " + workPlanId;
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
