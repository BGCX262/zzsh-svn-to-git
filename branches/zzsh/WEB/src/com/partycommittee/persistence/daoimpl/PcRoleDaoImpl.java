package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcRoleDao;
import com.partycommittee.persistence.po.PcRole;;

@Repository("PcRoleDaoImpl")
public class PcRoleDaoImpl extends JpaDaoBase implements PcRoleDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcRole> getRoleList() {
		try {
			return super.getJpaTemplate().find("from PcRole");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
