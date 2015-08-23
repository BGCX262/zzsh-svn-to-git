package com.partycommittee.persistence.daoimpl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;



import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcParentStatDao;
import com.partycommittee.persistence.po.PcParentStat;

@Repository("PcParentStatDaoImpl")
public class PcParentStatDaoImpl extends JpaDaoBase implements PcParentStatDao {
	

	@SuppressWarnings("unchecked")
	@Override
	public List<PcParentStat> getListStatByParentId(Integer id, Integer year, Integer q) {
		try {		
			return super.find("from PcParentStat where parent_id = " + id + " AND year = " + year + " AND quarter = " + q);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<PcParentStat> getListStatBytId(Integer id, Integer year, Integer q) {
		try {		
			return super.find("from PcParentStat where agency_id = " + id + " AND year = " + year + " AND quarter = " + q);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
}
