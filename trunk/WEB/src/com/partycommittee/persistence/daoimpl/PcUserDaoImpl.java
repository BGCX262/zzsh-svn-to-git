package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcUserDao;
import com.partycommittee.persistence.po.PcUser;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

@Repository("PCUserDaoImpl")
public class PcUserDaoImpl extends JpaDaoBase implements PcUserDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcUser> getUserList() {
		try {
			return super.getJpaTemplate().find("from PcUser order by agencyCodeId asc");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageResultVo<PcUser> getUserListByPage(PageHelperVo page) {
		try {
			PageResultVo<PcUser> pageResult = new PageResultVo<PcUser>();
			String sql = "from PcUser where 1 = 1 order by id asc";
			String totalSql = "select count (*) from PcUser";
			List<Long> totalList = super.find(totalSql);
			if (totalList != null) {
				page.setRecordCount(totalList.get(0).intValue());
				if ((page.getRecordCount() % page.getPageSize()) != 0) {
					page.setPageCount(page.getRecordCount() / page.getPageSize() + 1);
				} else {
					page.setPageCount(page.getRecordCount() / page.getPageSize());
				}
			}
			EntityManager em = super.getEntityManager();
			Query q = em.createQuery(sql);
			q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
			q.setMaxResults(page.getPageSize());
			pageResult.setList((List<PcUser>)q.getResultList());
			pageResult.setPageHelper(page);
			return pageResult;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@Override
	public List<PcUser> getUserListByConditions(PcUser user,
			PageHelperVo pageHelper) {
		return null;
	}

	@Override
	public PcUser createUser(PcUser user) {
		try {
			user.setId(null);
			super.persist(user);
			return user;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	public List<PcUser> checkUser(PcUser user) {
		try {
			if (user.getId() == null || user.getId() == 0 ) {
				return super.getJpaTemplate().find("from PcUser where username = '"+user.getUsername()+"'");
			} else {
				return super.getJpaTemplate().find("from PcUser where id <> "+user.getId()+" AND username = '"+user.getUsername()+"'");
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	
	
	@Override
	public void updateUser(PcUser user) {
		try {
			super.merge(user);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deleteUser(PcUser user) {
		try {
			super.removeFromKey(PcUser.class, user.getId());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public PcUser login(String username, String password) {
		try {
			List<PcUser> list = super.getJpaTemplate().find("from PcUser where username = '" 
					+ username + "' and password = '" + password + "'");
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public PageResultVo<PcUser> getUserListByPageAndAgencyId(PageHelperVo page,
			Integer agencyId) {
		try {
			PageResultVo<PcUser> pageResult = new PageResultVo<PcUser>();
			String sql = "from PcUser where privilege = '" + agencyId + "' order by id asc";
			String totalSql = "select count (*) from PcUser where privilege = '" + agencyId + "'";
			List<Long> totalList = super.find(totalSql);
			if (totalList != null) {
				page.setRecordCount(totalList.get(0).intValue());
				if ((page.getRecordCount() % page.getPageSize()) != 0) {
					page.setPageCount(page.getRecordCount() / page.getPageSize() + 1);
				} else {
					page.setPageCount(page.getRecordCount() / page.getPageSize());
				}
			}
			EntityManager em = super.getEntityManager();
			Query q = em.createQuery(sql);
			q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
			q.setMaxResults(page.getPageSize());
			pageResult.setList((List<PcUser>)q.getResultList());
			pageResult.setPageHelper(page);
			return pageResult;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public PageResultVo<PcUser> getUserListByPageAndParentId(PageHelperVo page,
			Integer agencyId, String code) {
		try {
			PageResultVo<PcUser> pageResult = new PageResultVo<PcUser>();
			String sql = "from PcUser where  privilege in (select id FROM PcAgency WHERE code like '" + code + "%') OR privilege = '" + agencyId + "'  order by id asc";
			String totalSql = "select count (*) from PcUser where privilege in (select id FROM PcAgency WHERE code like '" + code + "%') OR privilege = '" + agencyId + "')";
			System.out.print(sql);
			List<Long> totalList = super.find(totalSql);
			if (totalList != null) {
				page.setRecordCount(totalList.get(0).intValue());
				if ((page.getRecordCount() % page.getPageSize()) != 0) {
					page.setPageCount(page.getRecordCount() / page.getPageSize() + 1);
				} else {
					page.setPageCount(page.getRecordCount() / page.getPageSize());
				}
			}
			EntityManager em = super.getEntityManager();
			Query q = em.createQuery(sql);
			q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
			q.setMaxResults(page.getPageSize());
			pageResult.setList((List<PcUser>)q.getResultList());
			pageResult.setPageHelper(page);
			return pageResult;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}	
	
	
	
	

}
