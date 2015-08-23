package com.partycommittee.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcAgencyMappingDaoImpl;
import com.partycommittee.persistence.daoimpl.PcRoleDaoImpl;
import com.partycommittee.persistence.daoimpl.PcUserDaoImpl;
import com.partycommittee.persistence.daoimpl.PcUserRoleDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyMapping;
import com.partycommittee.persistence.po.PcRole;
import com.partycommittee.persistence.po.PcUser;
import com.partycommittee.persistence.po.PcUserRole;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.remote.vo.PcRoleVo;
import com.partycommittee.remote.vo.PcUserRoleVo;
import com.partycommittee.remote.vo.PcUserVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

@Transactional
@Service("PCUserService")
public class PcUserService {
	
	@Resource(name="PCUserDaoImpl")
	private PcUserDaoImpl pcUserDaoImpl;
	public void setPCUserDaoImpl(PcUserDaoImpl pcUserDaoImpl) {
		this.pcUserDaoImpl = pcUserDaoImpl;
	}
	
	@Resource(name="PcAgencyMappingDaoImpl")
	private PcAgencyMappingDaoImpl pcAgencyMappingDaoImpl;
	public void setPcAgencyMappingDaoImpl(PcAgencyMappingDaoImpl pcAgencyMappingDaoImpl) {
		this.pcAgencyMappingDaoImpl = pcAgencyMappingDaoImpl;
	}
	
	@Resource(name="PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;
	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}
	
	@Resource(name="PcRoleDaoImpl")
	private PcRoleDaoImpl pcRoleDaoImpl;
	public void setPcRoleDaoImpl(PcRoleDaoImpl pcRoleDaoImpl) {
		this.pcRoleDaoImpl = pcRoleDaoImpl;
	}	
	
	@Resource(name="PcUserRoleDaoImpl")
	private PcUserRoleDaoImpl pcUserRoleDaoImpl;
	public void setPcUserRoleDaoImpl(PcUserRoleDaoImpl pcUserRoleDaoImpl) {
		this.pcUserRoleDaoImpl = pcUserRoleDaoImpl;
	}		
	
	public PcUserVo login(String username, String password) {
		PcUser user = pcUserDaoImpl.login(username, password);
		if (user == null || user.getStatus() != 1) {
			return null;
		}
		PcUserVo userVo = PcUserVo.fromPCUser(user);
		userVo.setRoles(getRolesByUserId(userVo.getId()));
		
		 Calendar ca = Calendar.getInstance();
		user.setLastlogintime(ca.getTime());
		pcUserDaoImpl.updateUser(user);

		return userVo;
	}
	
	public List<PcUserVo> getUserList() {
		List<PcUserVo> list = new ArrayList<PcUserVo>();
		List<PcUser> userList = pcUserDaoImpl.getUserList();
		if (userList != null && userList.size() > 0) {
			for (PcUser user : userList) {
				PcUserVo vo = PcUserVo.fromPCUser(user);
				vo.setRoles(getRolesByUserId(vo.getId()));
				list.add(vo);
			}
		}
		return list;
	}
	
	public PageResultVo<PcUserVo> getUserListByPage(PageHelperVo page, Integer agencyId) {
		PageResultVo<PcUserVo> result = new PageResultVo<PcUserVo>();
		List<PcUserVo> list = new ArrayList<PcUserVo>();
		PageResultVo<PcUser> pageResult = new PageResultVo<PcUser>();
		if (agencyId == 0) {
			pageResult = pcUserDaoImpl.getUserListByPage(page);
		} else {
			pageResult = pcUserDaoImpl.getUserListByPageAndAgencyId(page, agencyId);
		}
		
		if (pageResult == null) {
			return null;
		}
		result.setPageHelper(pageResult.getPageHelper());
		if (pageResult.getList() != null && pageResult.getList().size() > 0) {
			for (PcUser user : pageResult.getList()) {
				PcUserVo userVo = PcUserVo.fromPCUser(user);
				userVo.setRoles(getRolesByUserId(userVo.getId()));
				getAgencyList(userVo);
				list.add(userVo);
			}
		}
		result.setList(list);
		return result;
	}
	
	public PageResultVo<PcUserVo> getUserListByPageAndParentId(PageHelperVo page, Integer agencyId) {
		PageResultVo<PcUserVo> result = new PageResultVo<PcUserVo>();
		List<PcUserVo> list = new ArrayList<PcUserVo>();
		PageResultVo<PcUser> pageResult = new PageResultVo<PcUser>();
		pageResult = pcUserDaoImpl.getUserListByPageAndParentId(page, agencyId);
		if (pageResult == null) {
			return null;
		}
		result.setPageHelper(pageResult.getPageHelper());
		if (pageResult.getList() != null && pageResult.getList().size() > 0) {
			for (PcUser user : pageResult.getList()) {
				PcUserVo userVo = PcUserVo.fromPCUser(user);
				userVo.setRoles(getRolesByUserId(userVo.getId()));
				getAgencyList(userVo);
				list.add(userVo);
			}
		}
		result.setList(list);
		return result;
	}	
	
	public void getAgencyList(PcUserVo userVo) {
		String privilege = userVo.getPrivilege();
		if (privilege != null && !privilege.equals("")) {
			List<PcAgencyVo> agencyList = new ArrayList<PcAgencyVo>();
			List<PcAgency> list = pcAgencyDaoImpl.getAgencyListByIds(privilege);
			if (list != null && list.size() > 0) {
				for (PcAgency agencyItem : list) {
					agencyList.add(PcAgencyVo.fromPcAgency(agencyItem));
				}
			}
			userVo.setAgencyList(agencyList);
		}
//		List<PcAgencyVo> list = new ArrayList<PcAgencyVo>();
//		for (String privilegeItem : privilegeList) {
//			int agencyId = Integer.parseInt(privilegeItem);
//			PcAgency agencyItem = pcAgencyDaoImpl.getAgencyById(agencyId);
//			if (agencyItem != null) {
//				list.add(PcAgencyVo.fromPcAgency(agencyItem));
//			}
//		}
//		userVo.setAgencyList(list);
	}
	
	public List<PcUserVo> checkUserOnly(PcUserVo userVo) {
		List<PcUserVo> list = new ArrayList<PcUserVo>();
		PcUser user = PcUserVo.toPCUser(userVo);
		List<PcUser> userList = pcUserDaoImpl.checkUser(user);
		if (userList != null && userList.size() > 0) {
			for (PcUser vo : userList) {
				list.add(PcUserVo.fromPCUser(vo));
			}
		}
		return list;
	}	
	
	public void createUser(PcUserVo userVo) {
		PcUser user = PcUserVo.toPCUser(userVo);
		updateAgencyCodeId(user);
		user = pcUserDaoImpl.createUser(user);
		updateUserAgencyMapping(user.getId(), userVo.getPrivilege());
		updateUserRoles(user.getId(), userVo.getRoles());
	}
	
	public void updateUser(PcUserVo userVo) {
		PcUser user = PcUserVo.toPCUser(userVo);
		updateAgencyCodeId(user);
		pcUserDaoImpl.updateUser(user);
		updateUserAgencyMapping(user.getId(), userVo.getPrivilege());
		updateUserRoles(userVo.getId(), userVo.getRoles());
	}
	
	private void updateAgencyCodeId(PcUser user) {
		if (user.getPrivilege() != null && !user.getPrivilege().equals("")) {
			List<PcAgency> agencyList = pcAgencyDaoImpl.getAgencyListByIds(user.getPrivilege());
			if (agencyList == null || agencyList.size() == 0) {
				user.setAgencyCodeId(null);
			} else {
				Integer rootCodeId = null;
				for (PcAgency agency : agencyList) {
					if (rootCodeId == null) {
						rootCodeId = agency.getCodeId();
					} else {
						if (rootCodeId > agency.getCodeId()) {
							rootCodeId = agency.getCodeId();
						}
					}
				}
				user.setAgencyCodeId(rootCodeId);
			}
		} else {
			user.setAgencyCodeId(null);
		}
	}
	
	private void updateUserAgencyMapping(Long userId, String privilege) {
		if (privilege == null || privilege.equals("")) {
			return;
		}
		Integer rootAgencyId = getRootAgencyId(privilege.split(","));
		if (rootAgencyId != null) {
			List<PcAgencyMapping> mappingList = pcAgencyMappingDaoImpl.getAgencyMappingByUserId(userId.intValue());
			if (mappingList == null || mappingList.size() == 0) {
				PcAgencyMapping newMapping = new PcAgencyMapping();
				newMapping.setAgencyId(rootAgencyId);
				newMapping.setUserId(userId.intValue());
				pcAgencyMappingDaoImpl.createAgencyMapping(newMapping);
				return;
			}
			pcAgencyMappingDaoImpl.updateAgencyMappingByUser(userId, rootAgencyId);
		}
	}
	
	private void updateUserRoles(Long userId, List<Integer> roles) {
		pcUserRoleDaoImpl.deleteByUserId(userId);
		for (Integer roleId : roles) {
			PcUserRole vo = new PcUserRole();
			vo.setUserId(userId);
			vo.setRoleId(roleId);
			pcUserRoleDaoImpl.createUserRole(vo);
		}
	}	
	
	public void deleteUser(PcUserVo userVo) {
		PcUser user = PcUserVo.toPCUser(userVo);
		pcUserDaoImpl.deleteUser(user);
	}
	
	private Integer getRootAgencyId(String[] strings) {
		Integer temp = null;
		for (String str : strings) {
			Long id = Long.parseLong(str);
			if (id == null) {
				continue;
			}
			if (temp == null) {
				temp = id.intValue();
			} else {
				if (id.intValue() < temp) {
					temp = id.intValue();
				}
			}
		}
		return temp;
	}
	
	public List<PcRoleVo> getRoleList() {
		List<PcRoleVo> list = new ArrayList<PcRoleVo>();
		List<PcRole> roleList = pcRoleDaoImpl.getRoleList();
		if (roleList != null && roleList.size() > 0) {
			for (PcRole item : roleList) {
				list.add(PcRoleVo.fromPcRole(item));
			}
		}
		return list;
	}	
	
	public List<Integer> getRolesByUserId(Long userId) {
		List<Integer> list = new ArrayList<Integer>();
		List<PcUserRole> roleList = pcUserRoleDaoImpl.getRolesByUserId(userId);
		if (roleList != null && roleList.size() > 0) {
			for (PcUserRole item : roleList) {
				list.add(PcUserRoleVo.fromPcUserRole(item).getRoleId());
			}
		}
		return list;
	}		
	
}
