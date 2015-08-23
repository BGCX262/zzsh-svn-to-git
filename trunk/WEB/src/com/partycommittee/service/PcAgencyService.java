package com.partycommittee.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcAgencyMappingDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMemberDaoImpl;
import com.partycommittee.persistence.daoimpl.PcWorkPlanDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyRelation;
import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.remote.vo.PcAgencyInfoVo;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.remote.vo.PcMemberVo;

@Transactional
@Service("PcAgencyService")
public class PcAgencyService {

	@Resource(name="PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;
	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}
	
	@Resource(name="PcAgencyMappingDaoImpl")
	private PcAgencyMappingDaoImpl pcAgencyMappingDaoImpl;
	public void setPcAgencyMappingDaoImpl(PcAgencyMappingDaoImpl pcAgencyMappingDaoImpl) {
		this.pcAgencyMappingDaoImpl = pcAgencyMappingDaoImpl;
	}
	
	@Resource(name="PcMemberDaoImpl")
	private PcMemberDaoImpl pcMemberDaoImpl;
	public void setPcMemberDaoImpl(PcMemberDaoImpl pcMemberDaoImpl) {
		this.pcMemberDaoImpl = pcMemberDaoImpl;
	}
	
	@Resource(name="PcWorkPlanDaoImpl")
	private PcWorkPlanDaoImpl pcWorkPlanDaoImpl;
	public void setPcWorkPlanDaoImpl(PcWorkPlanDaoImpl pcWorkPlanDaoImpl) {
		this.pcWorkPlanDaoImpl = pcWorkPlanDaoImpl;
	}
		
	
	public List<PcAgencyVo> getAgencyList() {
		List<PcAgencyVo> list = new ArrayList<PcAgencyVo>();
		List<PcAgency> agencyList = pcAgencyDaoImpl.getAgencyList();
		if (agencyList != null && agencyList.size() > 0) {
			for (PcAgency agency : agencyList) {
				list.add(PcAgencyVo.fromPcAgency(agency));
			}
		}
		return list;
	}
	
	public List<PcAgencyVo> getChildrenAgencyListByCode(int agencyId) {
		List<PcAgencyVo> list = new ArrayList<PcAgencyVo>();
		PcAgency agency =  pcAgencyDaoImpl.getAgencyById(agencyId);
		List<PcAgency> agencyList = pcAgencyDaoImpl.getChildrenAgencyByCode(agency.getCode());
		for (PcAgency item : agencyList) {
			PcAgencyVo vo = PcAgencyVo.fromPcAgency(item);
			vo.setZbsj(" ");

			list.add(vo);
		}
		return list;
	}	
	
	public List<PcAgencyVo> getHistoryChildrenAgencyListByCode(int agencyId) {
		List<PcAgencyVo> list = new ArrayList<PcAgencyVo>();
		PcAgency agency =  pcAgencyDaoImpl.getAgencyById(agencyId);
		
		List<PcAgency> agencyList = pcAgencyDaoImpl.getHistoryChildrenAgencyByCode(agency.getCode());
		for (PcAgency item : agencyList) {
			PcAgencyVo vo = PcAgencyVo.fromPcAgency(item);
			vo.setZbsj(" ");			
			list.add(vo);
		}
		return list;
	}	
	
	public List<PcAgencyVo> getChildrenAgencyListByCodeOnlyParent(int agencyId) {
		List<PcAgencyVo> list = new ArrayList<PcAgencyVo>();
		PcAgency agency =  pcAgencyDaoImpl.getAgencyById(agencyId);
		List<PcAgency> agencyList = pcAgencyDaoImpl.getChildrenAgencyByCodeOnly(agency.getCode());
		for (PcAgency item : agencyList) {
			PcAgencyVo vo = PcAgencyVo.fromPcAgency(item);
			list.add(vo);
		}
		return list;
	}		
	
	
	
	public PcAgencyVo getAgencyById(int agencyId) {
		PcAgency agency = pcAgencyDaoImpl.getAgencyById(agencyId);
		if (agency == null) {
			return null;
		}
		PcAgencyVo agencyVo = PcAgencyVo.fromPcAgency(agency);
		if (agency.getMemberId() != null) {
			PcMember member = pcMemberDaoImpl.getMemberById(agency.getMemberId());
			if (member != null) {
				agencyVo.setMember(PcMemberVo.fromPcMember(member));
			}
		}
		return agencyVo;
	}
	
	public void createAgency(PcAgencyVo agencyVo) {
		
		// Create agency.
		
		// get MaxCode From parent_id;
		String maxcode = pcAgencyDaoImpl.getMaxCodeByParentId(agencyVo.getParentId());
		agencyVo.setCode(maxcode);
		PcAgency agency = PcAgencyVo.toPcAgency(agencyVo);
		pcAgencyDaoImpl.createAgency(agency);
		// Create agency relation.
//		PcAgencyRelation agencyRelation = new PcAgencyRelation();
//		agencyRelation.setAgencyId(agency.getId());
//		agencyRelation.setParentId(agencyVo.getParentId());
//		pcAgencyRelationDaoImpl.createAgencyRelation(agencyRelation);
	}
	
	public void updateAgency(PcAgencyVo agencyVo) {
		System.out.println(agencyVo.getId());
		System.out.println(agencyVo.getSetupDatetime());
		System.out.println(agencyVo.getCreateDatetime());
		PcAgency agency = PcAgencyVo.toPcAgency(agencyVo);
		pcAgencyDaoImpl.updateAgency(agency);
	}
	
	public void moveAgency(PcAgencyVo agencyVo) {
		// 做二件事情
		// 1. PcagencyRelation 做关系调整
//		PcAgencyRelation pcr = pcAgencyRelationDaoImpl.getParentByAgencyId(agencyVo.getId());
//		pcr.setParentId(agencyVo.getParentId());
//		pcAgencyRelationDaoImpl.updateAgencyRelation(pcr);
		
		// 2. Code 代码做相应的调整
		String maxcode = pcAgencyDaoImpl.getMaxCodeByParentId(agencyVo.getParentId());
		agencyVo.setCode(maxcode);
		agencyVo.setParentId(agencyVo.getParentId());
		PcAgency agency = PcAgencyVo.toPcAgency(agencyVo);
		pcAgencyDaoImpl.updateAgency(agency);
		
	}	
	
	public void deleteAgency(PcAgencyVo agencyVo) {
		PcAgency agency = PcAgencyVo.toPcAgency(agencyVo);
		// Delete agency mapping.
		pcAgencyMappingDaoImpl.deleteAgencyMappingByAgencyId(agency.getId());
		
		// Get related child agency.
		List<PcAgency> relations = pcAgencyDaoImpl.getChildrenAgencyByCodeAll(agency.getCode());
		if (relations.size() > 0) {
			for (PcAgency relation : relations) {
				relation.setInvalidDatetime(Math.round(new Date().getTime()/1000));
				pcAgencyDaoImpl.updateAgency(relation);
			}
		}
	}
	
	public void revertAgency(PcAgencyVo agencyVo) {
		PcAgency agency = PcAgencyVo.toPcAgency(agencyVo);
		Integer codeId = agency.getCodeId();
		
		if (codeId != 10) {
			List<PcAgency> relations = pcAgencyDaoImpl.getHistoryChildrenAgencyByCodeAll(agencyVo.getCode());
			if (relations.size() > 0) {
				for (PcAgency relation : relations) {
					relation.setInvalidDatetime(0);
					pcAgencyDaoImpl.updateAgency(relation);
				}
			}			
		}
		
		if (codeId == 10) {
			PcAgency parent = pcAgencyDaoImpl.getAgencyById(agencyVo.getParentId());
			
			while (parent.getId() > 1 ) {
				System.out.println(parent.getName());
				if (parent.getInvalidDatetime() > 0) {
					parent.setInvalidDatetime(0);
					pcAgencyDaoImpl.updateAgency(parent);
				}
				
				parent = pcAgencyDaoImpl.getAgencyById(parent.getParentId());
			}
			
			agency.setInvalidDatetime(0);
			pcAgencyDaoImpl.updateAgency(agency);			
		}
		

		
	}	

	public PcAgencyInfoVo getAgencyInfo(Integer agencyId) {
		PcAgencyInfoVo agencyInfo = new PcAgencyInfoVo();
		// get team number.

		PcAgency agencyVo =  pcAgencyDaoImpl.getAgencyById(agencyId);
		List<PcAgency> relationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agencyVo.getCode());
		
//		List<PcAgency> relationList = pcAgencyDaoImpl.getChildrenByParentId(agencyId);
		if (relationList != null) {
			agencyInfo.setTeamNumber(relationList.size());
		} else {
			agencyInfo.setTeamNumber(0);
		}
		// get member number.
		List<PcMember> memberList = pcMemberDaoImpl.getMemberListByAgencyId(agencyId);
		if (memberList != null) {
			agencyInfo.setMemberNumber(memberList.size());
		} else {
			agencyInfo.setMemberNumber(0);
		}
		// get duty member list.
		List<PcMemberVo> list = new ArrayList<PcMemberVo>();
		List<PcMember> dutyList = pcMemberDaoImpl.getDutyMemberListByAgencyId(agencyId);
		if (dutyList != null && dutyList.size() > 0) {
			for (PcMember memberItem : dutyList) {
				list.add(PcMemberVo.fromPcMember(memberItem));
			}
		}
		agencyInfo.setDutyMemberList(list);
		return agencyInfo;
	}

	public PcAgencyVo getParentAgency(Integer agencyId) {
		return this.getAgencyById(agencyId);
	}
	
	public String exportToDoc(Integer agencyId, Integer year) {
		
		List<PcWorkPlan> workPlanList = new ArrayList<PcWorkPlan>();
		workPlanList = pcWorkPlanDaoImpl.getCompleteWorkPlanListByAgencyIds(agencyId, year);
		for (PcWorkPlan workPlan : workPlanList) {
			
		}

		return "";
	}	
	
}
