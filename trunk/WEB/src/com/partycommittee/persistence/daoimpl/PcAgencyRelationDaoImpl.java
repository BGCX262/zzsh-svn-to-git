package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcAgencyRelationDao;
import com.partycommittee.persistence.po.PcAgencyRelation;

@Repository("PcAgencyRelationDaoImpl")
public class PcAgencyRelationDaoImpl extends JpaDaoBase implements PcAgencyRelationDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyRelation> getAgencyRelationList() {
		try {
			return super.getJpaTemplate().find("from PcAgencyRelation");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyRelation> getChildrenByParentId(int parentId) {
		try {
			return super.getJpaTemplate().find("from PcAgencyRelation where parentId = " + parentId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PcAgencyRelation getParentByAgencyId(int id) {
		try {
			List<PcAgencyRelation> list = super.getJpaTemplate().find("from PcAgencyRelation where agencyId = " + id);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void createAgencyRelation(PcAgencyRelation agencyRelation) {
		try {
			agencyRelation.setId(null);
			super.persist(agencyRelation);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void updateAgencyRelation(PcAgencyRelation agencyRelation) {
		try {
			super.merge(agencyRelation);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deleteAgencyRelation(PcAgencyRelation agencyRelation) {
		try {
			super.remove(agencyRelation);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deleteAgencyRelationByAgencyId(Integer id) {
		try {
			final String sql = "delete from PcAgencyRelation where agencyId = " + id + " or parentId = " + id;
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
