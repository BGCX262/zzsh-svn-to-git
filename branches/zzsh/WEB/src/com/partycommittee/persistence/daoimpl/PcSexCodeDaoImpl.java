package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcSexCodeDao;
import com.partycommittee.persistence.po.PcSexCode;;

@Repository("PcSexCodeDaoImpl")
public class PcSexCodeDaoImpl extends JpaDaoBase implements PcSexCodeDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcSexCode> getSexList() {
		try {
			return super.getJpaTemplate().find("from PcSexCode");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
