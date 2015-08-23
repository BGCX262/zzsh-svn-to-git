package com.partycommittee.remote.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.remote.vo.PcLicenseVo;
import com.partycommittee.service.PcLicenseService;

@Service("PcLicenseRo")
@RemotingDestination(channels={"my-amf"})
public class PcLicenseRemoteService {
	
	@Resource(name="PcLicenseService")
	private PcLicenseService pcLicenseService;
	public void setPcLicenseService(PcLicenseService pcLicenseService) {
		this.pcLicenseService = pcLicenseService;
	}

	@RemotingInclude
	public PcLicenseVo getLicense() throws UnsupportedEncodingException {
		return pcLicenseService.getLicense();
	}		
	
	@RemotingInclude
	public PcLicenseVo setLicenseInfo(String enstr, String tips) {
		return pcLicenseService.setLicenseInfo(enstr, tips);
	}		

}
