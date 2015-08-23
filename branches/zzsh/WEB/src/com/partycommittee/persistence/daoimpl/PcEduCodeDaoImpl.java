package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcEduCodeDao;
import com.partycommittee.persistence.po.PcEduCode;;

@Repository("PcEduCodeDaoImpl")
public class PcEduCodeDaoImpl extends JpaDaoBase implements PcEduCodeDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcEduCode> getEduList() {
		try {
			return super.getJpaTemplate().find("from PcEduCode");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
