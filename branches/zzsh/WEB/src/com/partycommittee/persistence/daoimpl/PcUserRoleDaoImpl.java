package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcUserRoleDao;
import com.partycommittee.persistence.po.PcAgencyMapping;
import com.partycommittee.persistence.po.PcUser;
import com.partycommittee.persistence.po.PcUserRole;

@Repository("PcUserRoleDaoImpl")
public class PcUserRoleDaoImpl extends JpaDaoBase implements PcUserRoleDao {


	@SuppressWarnings("unchecked")
	@Override
	public List<PcUserRole> getRolesByUserId(Long userId) {
		try {
			return super.getJpaTemplate().find("from PcUserRole where user_id = " + userId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@Override
	public void createUserRole(PcUserRole userRole) {
		try {
			userRole.setId(null);
			super.persist(userRole);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}	
	
	@Override
	public void deleteByUserId(Long userId) {
		try {
			final String sql = "delete from PcUserRole where user_id = " + userId;
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
