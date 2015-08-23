package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcDutyCodeDao;
import com.partycommittee.persistence.po.PcDutyCode;;

@Repository("PcDutyCodeDaoImpl")
public class PcDutyCodeDaoImpl extends JpaDaoBase implements PcDutyCodeDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcDutyCode> getDutyList() {
		try {
			return super.getJpaTemplate().find("from PcDutyCode");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

}
