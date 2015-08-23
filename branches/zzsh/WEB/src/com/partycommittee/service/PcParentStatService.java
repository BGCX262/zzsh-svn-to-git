package com.partycommittee.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.partycommittee.persistence.daoimpl.PcParentStatDaoImpl;
import com.partycommittee.persistence.po.PcParentStat;
import com.partycommittee.remote.vo.PcParentStatVo;


@Service("PcParentStatService")
public class PcParentStatService {

	@Resource(name="PcParentStatDaoImpl")
	private PcParentStatDaoImpl pcParentStatDaoImpl;
	public void setPcParentStatDaoImpl(PcParentStatDaoImpl pcParentStatDaoImpl) {
		this.pcParentStatDaoImpl = pcParentStatDaoImpl;
	}

	public List<PcParentStatVo> getListStatByParentId(Integer id, Integer year, Integer q) {
		List<PcParentStatVo> list = new ArrayList<PcParentStatVo>();
		
		if (id == 1) {
			List<PcParentStat> list_admin = pcParentStatDaoImpl.getListStatBytId(id, year, q);
			for (PcParentStat item : list_admin) {
				list.add(PcParentStatVo.fromPcParentStat(item));
			}			
		}
		List<PcParentStat> y = pcParentStatDaoImpl.getListStatByParentId(id, year, q);
		for (PcParentStat item : y) {
			list.add(PcParentStatVo.fromPcParentStat(item));
		}
		return list;
	}	
}
