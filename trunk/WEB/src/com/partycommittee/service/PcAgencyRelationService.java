package com.partycommittee.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcAgencyRelationDaoImpl;
import com.partycommittee.persistence.po.PcAgencyRelation;
import com.partycommittee.remote.vo.PcAgencyRelationVo;

@Transactional
@Service("PcAgencyRelationService")
public class PcAgencyRelationService {

	@Resource(name="PcAgencyRelationDaoImpl")
	private PcAgencyRelationDaoImpl pcAgencyRelationDaoImpl;
	public void setPcAgencyRelationDaoImpl(PcAgencyRelationDaoImpl pcAgencyRelationDaoImpl) {
		this.pcAgencyRelationDaoImpl = pcAgencyRelationDaoImpl;
	}
	
	public List<PcAgencyRelationVo> getAgencyRelationList() {
		List<PcAgencyRelationVo> list = new ArrayList<PcAgencyRelationVo>();
		List<PcAgencyRelation> agencyRelationList = pcAgencyRelationDaoImpl.getAgencyRelationList();
		if (agencyRelationList != null && agencyRelationList.size() > 0) {
			for (PcAgencyRelation agencyRelation : agencyRelationList) {
				list.add(PcAgencyRelationVo.fromPcAgencyRelation(agencyRelation));
			}
		}
		return list;
	}
	
	public List<PcAgencyRelationVo> getChildrenByAgencyId(int agencyId) {
		List<PcAgencyRelationVo> list = new ArrayList<PcAgencyRelationVo>();
		List<PcAgencyRelation> agencyRelationList = pcAgencyRelationDaoImpl.getChildrenByParentId(agencyId);
		if (agencyRelationList != null && agencyRelationList.size() > 0) {
			for (PcAgencyRelation agencyRelation : agencyRelationList) {
				list.add(PcAgencyRelationVo.fromPcAgencyRelation(agencyRelation));
			}
		}
		return list;
	}
	
	public PcAgencyRelationVo getParentByAgencyId(int agencyId) {
		PcAgencyRelation agencyRelation = pcAgencyRelationDaoImpl.getParentByAgencyId(agencyId);
		if (agencyRelation != null) {
			return PcAgencyRelationVo.fromPcAgencyRelation(agencyRelation);
		}
		return null;
	}
	
	public void createAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		PcAgencyRelation agencyRelation = PcAgencyRelationVo.toPcAgencyRelation(agencyRelationVo);
		pcAgencyRelationDaoImpl.createAgencyRelation(agencyRelation);
	}
	
	public void updateAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		PcAgencyRelation agencyRelation = PcAgencyRelationVo.toPcAgencyRelation(agencyRelationVo);
		pcAgencyRelationDaoImpl.updateAgencyRelation(agencyRelation);
	}
	
	public void deleteAgencyRelation(PcAgencyRelationVo agencyRelationVo) {
		PcAgencyRelation agencyRelation = PcAgencyRelationVo.toPcAgencyRelation(agencyRelationVo);
		pcAgencyRelationDaoImpl.deleteAgencyRelation(agencyRelation);
	}
}
