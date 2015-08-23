package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.constants.SessionConstant;
import com.partycommittee.service.PcWordService;

import flex.messaging.FlexContext;

@Service("PcWordRo")
@RemotingDestination(channels={"my-amf"})
public class PcWordRemoteService {
	
	@Resource(name="PcWordService")
	private PcWordService pCWordService;
	public void setPCWordService(PcWordService pCWordService) {
		this.pCWordService = pCWordService;
	}

	@RemotingInclude
	public String exportDocForAll(Integer agencyId, Integer year) {
		return pCWordService.exportDocForAll(agencyId, year);
	}
	
	@RemotingInclude
	public String exportDocForWorkPlan(Integer workPlanId) {
		return pCWordService.exportDocForWorkPlan(workPlanId);
	}	
	
	@RemotingInclude
	public String exportDocForMeeting(Integer meetingId) {
		return pCWordService.exportDocForMeeting(meetingId);
	}		
			
}
