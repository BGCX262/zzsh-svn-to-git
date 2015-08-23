package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcAgencyStatsVo;
import com.partycommittee.remote.vo.PcStatsVo;
import com.partycommittee.service.PcStatService;

@Service("PcStatRo")
@RemotingDestination(channels={"my-amf"})
public class PcStatRemoteService {
	
	@Resource(name="PcStatService")
	private PcStatService pcStatService;
	public void setPcStatService(PcStatService pcStatService) {
		this.pcStatService = pcStatService;
	}
	
	@RemotingInclude
	public List<PcAgencyStatsVo> getAgencyStatById(Integer id, Integer year, Integer endM) {
		return pcStatService.getAgencyStatsByParentId(id, year, endM);
	}
	
	@RemotingInclude
	public List<PcStatsVo> getWorkPlanStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		return pcStatService.getWorkPlanStatsById(id, year, startM, endM);
	}
	
	@RemotingInclude
	public String getWorkPlanZBStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		return pcStatService.getWorkPlanZBStatsById(id, year, startM, endM);
	}	
	
	@RemotingInclude
	public List<PcStatsVo> getMeetingStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		return pcStatService.getMeetingStatsById(id, year, startM, endM);
	}
	
	@RemotingInclude
	public String getMeetingZBStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		return pcStatService.getMeetingZBStatsById(id, year, startM, endM);
	}	
	
	@RemotingInclude
	public List<PcStatsVo> getZbStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		return pcStatService.getZbStatsById(id, year, startM, endM);
	}	

}
