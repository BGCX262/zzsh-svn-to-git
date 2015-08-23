package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.constants.SessionConstant;
import com.partycommittee.service.PcCommonService;

import flex.messaging.FlexContext;

@Service("PcCommonRo")
@RemotingDestination(channels={"my-amf"})
public class PcCommonRemoteService {
	
	@Resource(name="PcCommonService")
	private PcCommonService pcCommonService;

	
	public PcCommonService getPcCommonService() {
		return pcCommonService;
	}

	public void setPcCommonService(PcCommonService pcCommonService) {
		this.pcCommonService = pcCommonService;
	}

	@RemotingInclude
	public Long getMilliseconds(long clientTime) {
		return pcCommonService.getMilliseconds(clientTime);
	}			
}
