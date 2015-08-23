package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcNationCodeDao;
import com.partycommittee.persistence.po.PcNationCode;;

@Repository("PcNationCodeDaoImpl")
public class PcNationCodeDaoImpl extends JpaDaoBase implements PcNationCodeDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcNationCode> getNationList() {
		try {
			return super.getJpaTemplate().find("from PcNationCode");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
