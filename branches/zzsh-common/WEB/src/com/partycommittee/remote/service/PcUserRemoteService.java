package com.partycommittee.remote.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import com.partycommittee.constants.SessionConstant;
import com.partycommittee.remote.vo.PcRoleVo;
import com.partycommittee.remote.vo.PcUserRoleVo;
import com.partycommittee.remote.vo.PcUserVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;
import com.partycommittee.service.PcUserService;

import flex.messaging.FlexContext;

@Service("PcUserRo")
@RemotingDestination(channels={"my-amf"})
public class PcUserRemoteService {
	
	@Resource(name="PCUserService")
	private PcUserService pCUserService;
	public void setPCUserService(PcUserService pCUserService) {
		this.pCUserService = pCUserService;
	}
	
	@RemotingInclude
	public PcUserVo login(String username, String password) {
		PcUserVo user = pCUserService.login(username, password);
		HttpServletRequest request = FlexContext.getHttpRequest();
		HttpSession session = request.getSession();
		session.setAttribute(SessionConstant.SESSON_USER, user);
		return user;
	}
	
	@RemotingInclude
	public String userLogOut() {
		HttpServletRequest request = FlexContext.getHttpRequest();
		HttpSession session = request.getSession();
		session.removeAttribute(SessionConstant.SESSON_USER);
		return "";
	}
	
	@RemotingInclude
	public PcUserVo getLoginUser() {
		HttpServletRequest request = FlexContext.getHttpRequest();
		HttpSession session = request.getSession();
		PcUserVo user = (PcUserVo)session.getAttribute(SessionConstant.SESSON_USER);
		return user;
	}
	
	@RemotingInclude
	public List<PcUserVo> getPcUserList() {
		return pCUserService.getUserList();
	}
	
	@RemotingInclude
	public PageResultVo<PcUserVo> getPcUserListByPage(PageHelperVo page, Integer agencyId) {
		return pCUserService.getUserListByPage(page, agencyId);
	}
	
	@RemotingInclude
	public PageResultVo<PcUserVo> getPcUserListByPageAndParentId(PageHelperVo page, Integer agencyId) {
		return pCUserService.getUserListByPageAndParentId(page, agencyId);
	}
	
	
	@RemotingInclude
	public List<PcUserVo> checkUserOnly(PcUserVo userVo) {
		return pCUserService.checkUserOnly(userVo);
	}	
	
	
	@RemotingInclude
	public void createPcUser(PcUserVo userVo) {
		pCUserService.createUser(userVo);
	}
	
	@RemotingInclude
	public void updatePcUser(PcUserVo userVo) {
		pCUserService.updateUser(userVo);
	}
	
	@RemotingInclude
	public void deletePcUsers(List<PcUserVo> userList) {
		for (PcUserVo userVo : userList) {
			pCUserService.deleteUser(userVo);
		}
	}
	
	@RemotingInclude
	public List<PcRoleVo> getRoleList() {
		return pCUserService.getRoleList();
	}	
		
}
