package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcMemberDao;
import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

@Repository("PcMemberDaoImpl")
public class PcMemberDaoImpl extends JpaDaoBase implements PcMemberDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<PcMember> getMemberList() {
		try {
			return super.getJpaTemplate().find("from PcMember Order By sort asc");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PcMember> getMemberListByAgencyId(int agencyId) {
		try {
			return super.getJpaTemplate().find("from PcMember where agencyId = " + agencyId + " Order By sort asc");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public PageResultVo<PcMember> getMemberListPageByAgencyId(int agencyId, PageHelperVo page) {
		try {
			PageResultVo<PcMember> pageResult = new PageResultVo<PcMember>();
			String sql = "from PcMember";
			String totalSql = "select count (*) from PcMember";
			List<Long> totalList = super.find(totalSql);
			if (totalList != null) {
				page.setRecordCount(totalList.get(0).intValue());
			}
			EntityManager em = super.getEntityManager();
			Query q = em.createQuery(sql);
			q.setFirstResult(page.getPageSize() * (page.getPageIndex() - 1));
			q.setMaxResults(page.getPageSize());
			pageResult.setList((List<PcMember>)q.getResultList());
			pageResult.setPageHelper(page);
			return pageResult;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@Override
	public void createPcMember(PcMember member) {
		try {
			member.setId(null);
			super.persist(member);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void updatePcMember(PcMember member) {
		try {
			super.merge(member);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@Override
	public void deletePcMember(PcMember member) {
		try {
			super.removeFromKey(PcMember.class, member.getId());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public PcMember getMemberById(int id) {
		try {
			List<PcMember> list = super.getJpaTemplate().find("from PcMember where id = " + id);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<PcMember> getDutyMemberListByAgencyId(Integer agencyId) {
		try {
			return super.getJpaTemplate().find("from PcMember where dutyId in (1, 2, 3, 4, 5, 6, 7, 8, 9) and agencyId = " + agencyId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PcMember> getMemberByDutyId(int id, int dutyId) {
		try {
			List<PcMember> list = super.getJpaTemplate().find("from PcMember where agencyId = " + id + " AND duty_id =" + dutyId);
			return list;
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	

}
