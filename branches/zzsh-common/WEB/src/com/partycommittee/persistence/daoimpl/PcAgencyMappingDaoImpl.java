package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcAgencyMappingDao;
import com.partycommittee.persistence.po.PcAgencyMapping;

@Repository("PcAgencyMappingDaoImpl")
public class PcAgencyMappingDaoImpl extends JpaDaoBase implements PcAgencyMappingDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyMapping> getAgencyMappingList() {
		try {
			return super.getJpaTemplate().find("from PcAgencyMapping");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcAgencyMapping> getAgencyMappingByUserId(int userId) {
		try {
			return super.getJpaTemplate().find("from PcAgencyMapping where userId = " + userId + " order by agency_id asc ");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@Override
	public void createAgencyMapping(PcAgencyMapping agencyMapping) {
		try {
			agencyMapping.setId(null);
			super.persist(agencyMapping);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void updateAgencyMapping(PcAgencyMapping agencyMapping) {
		try {
			super.merge(agencyMapping);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deleteAgencyMapping(PcAgencyMapping agencyMapping) {
		try {
			super.remove(agencyMapping);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deleteAgencyMappingByAgencyId(Integer id) {
		try {
			final String sql = "delete from PcAgencyMapping where agencyId = " + id;
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

	@Override
	public void updateAgencyMappingByUser(Long id, Integer rootAgencyId) {
		try {
			final String sql = "update PcAgencyMapping set agencyId = " + rootAgencyId 
					+ " where userId = " + id;
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
