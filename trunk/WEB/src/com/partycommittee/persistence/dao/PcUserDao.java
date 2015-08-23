package com.partycommittee.persistence.dao;

import java.util.List;

import com.partycommittee.persistence.po.PcUser;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

public interface PcUserDao {
	/**
	 * User Login.
	 * @param username
	 * @param password
	 * @return PcUser
	 */
	public PcUser login(String username, String password);
	
	/**
	 * Get user list.
	 * @return List<PcUser>
	 */
	public List<PcUser> getUserList();
	
	/**
	 * Get user list by page.
	 * @param page
	 * @return PageResultVo<PcUser>
	 */
	public PageResultVo<PcUser> getUserListByPage(PageHelperVo page);
	
	/**
	 * Get user list by page.
	 * @param page
	 * @return PageResultVo<PcUser>
	 */
	public PageResultVo<PcUser> getUserListByPageAndParentId(PageHelperVo page, Integer angencyId, String code);
	
	
	/**
	 * Get user list by conditions and page info.
	 * @param user
	 * @param pageHelper
	 * @return List<PcUser>
	 */
	public List<PcUser> getUserListByConditions(PcUser user, PageHelperVo pageHelper);
	
	/**
	 * Create new user.
	 * @param user
	 * @return PcUser
	 */
	public PcUser createUser(PcUser user);
	
	/**
	 * Update user.
	 * @param user
	 */
	public void updateUser(PcUser user);
	
	/**
	 * Delete user.
	 * @param user
	 */
	public void deleteUser(PcUser user);
}
