package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcAgencyStat;

public interface PcAgencyStatDao {

	public List<PcAgencyStat> getListStatBytId(Integer id, Integer year, Integer q);
}
