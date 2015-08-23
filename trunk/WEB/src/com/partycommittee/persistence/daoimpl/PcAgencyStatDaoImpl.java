package com.partycommittee.persistence.daoimpl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcAgencyStatDao;
import com.partycommittee.persistence.po.PcAgencyStat;
import com.partycommittee.persistence.po.PcParentStat;

@Repository("PcAgencyStatDaoImpl")
public class PcAgencyStatDaoImpl extends JpaDaoBase implements PcAgencyStatDao {
	
	public List<PcAgencyStat> getListStatBytId(Integer id, Integer year, Integer q) {
		try {		
			return super.find("from PcAgencyStat where agency_id = " + id + " AND year = " + year + " AND quarter = " + q);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
