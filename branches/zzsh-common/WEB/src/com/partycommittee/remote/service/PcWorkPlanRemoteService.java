package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcWorkPlanContentVo;
import com.partycommittee.remote.vo.PcWorkPlanVo;
import com.partycommittee.service.PcWorkPlanService;

@Service("PcWorkPlanRo")
@RemotingDestination(channels={"my-amf"})
public class PcWorkPlanRemoteService {
	
	@Resource(name="PcWorkPlanService")
	private PcWorkPlanService pcWorkPlanService;
	public void setPcWorkPlanService(PcWorkPlanService pcWorkPlanService) {
		this.pcWorkPlanService = pcWorkPlanService;
	}
	
	@RemotingInclude
	public void createWorkPlan(PcWorkPlanVo workPlan) {
		try {
			pcWorkPlanService.createWorkPlan(workPlan);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RemotingInclude
	public void updateWorkPlan(PcWorkPlanVo workPlan) {
		pcWorkPlanService.updateWorkPlan(workPlan);
	}
	
	@RemotingInclude
	public void updateWorkPlanStatus(Integer workPlanId, Integer StatusId) {
		pcWorkPlanService.updateWorkPlanStatus(workPlanId, StatusId);
	}	
	
	@RemotingInclude
	public PcWorkPlanVo getWorkPlanYearly(Integer agencyId, Integer year) {
		return pcWorkPlanService.getWorkPlayYearly(agencyId, year);
	}
	
	@RemotingInclude
	public PcWorkPlanVo getWorkPlanYearlySummary(Integer agencyId, Integer year) {
		return pcWorkPlanService.getWorkPlayYearlySummary(agencyId, year);
	}
	
	@RemotingInclude
	public PcWorkPlanVo getWorkPlanQuarter(Integer agencyId, Integer year, Integer quarter) {
		return pcWorkPlanService.getWorkPlanQuarter(agencyId, year, quarter);
	}
	
	@RemotingInclude
	public PcWorkPlanVo getWorkPlanQuarterSummary(Integer agencyId, Integer year, Integer quarter) {
		return pcWorkPlanService.getWorkPlanQuarterSummary(agencyId, year, quarter);
	}	
	
	@RemotingInclude
	public List<PcWorkPlanVo> getCommitWorkplanListByParentId(Integer agencyId, Integer year, List<FilterVo> filters) {
		return pcWorkPlanService.getCommitWorkplanListByParentId(agencyId, year, filters);
	}
	
	@RemotingInclude
	public PcWorkPlanContentVo getWorkPlanContentByWorkPlanId(Integer workPlanId) {
		return pcWorkPlanService.getWorkPlanContentByWorkPlanId(workPlanId);
	}

	@RemotingInclude
	public void saveContentWrokplan(Integer workPlanId, Integer statusId, PcWorkPlanContentVo contentVo) {
		pcWorkPlanService.saveContentWrokplan(workPlanId, statusId, contentVo);
	}	
	
	@RemotingInclude
	public List<PcWorkPlanVo> getWorkPlanListQuarter(Integer agencyId, Integer year) {
		return pcWorkPlanService.getWorkPlanListQuarter(agencyId, year);
	}
	
	@RemotingInclude
	public List<PcWorkPlanVo> getResultListQuarter(Integer agencyId, Integer year) {
		return pcWorkPlanService.getResultListQuarter(agencyId, year);
	}
	
	@RemotingInclude
	public void submitWorkPlan(PcWorkPlanVo workPlan) {
		pcWorkPlanService.submitWorkPlan(workPlan);
	}

	@RemotingInclude
	public PcWorkPlanContentVo getContentInfo(Integer workPlanId, Integer type) {
		return pcWorkPlanService.getContentInfo(workPlanId, type);
	}	
	
	@RemotingInclude
	public List<PcWorkPlanVo> getAlertInfo(Integer agencyId, Integer year, Integer quarter) {
		return pcWorkPlanService.getAlertInfo(agencyId, year, quarter);
	}
	
	@RemotingInclude
	public Boolean deleteWorkPlan(Integer workPlanId) {
		return pcWorkPlanService.deleteWorkPlan(workPlanId);
	}	
	
	@RemotingInclude
	public String exportWorkPlanToDoc(Integer workPlanId) {
		return pcWorkPlanService.exportDoc(workPlanId);
	}		

}
