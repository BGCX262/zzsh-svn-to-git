package com.partycommittee.persistence.daoimpl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcWorkPlanDao;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.remote.vo.FilterVo;

@Repository("PcWorkPlanDaoImpl")
public class PcWorkPlanDaoImpl extends JpaDaoBase implements PcWorkPlanDao {
	
	@SuppressWarnings("unchecked")
	public PcWorkPlan getWorkPlanById(Integer id) {
		try {
			List<PcWorkPlan> list = super.find("from PcWorkPlan where id = ?", id);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public PcWorkPlan getWorkPlanYearlyByAgencyId(Integer agencyId, Integer year) {
		try {
			List<PcWorkPlan> list = super.find("from PcWorkPlan where agency_id = ? and year = ? and typeId = ? order by id desc"
					, agencyId, year, 1);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public PcWorkPlan getWorkPlanYearlySummaryByAgencyId(Integer agencyId,
			Integer year) {
		try {
			List<PcWorkPlan> list = super.find("from PcWorkPlan where agency_id = ? and year = ? and typeId = ? order by id desc"
					, agencyId, year, 4);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public PcWorkPlan createWorkPlan(PcWorkPlan workPlan) {
		try {
			workPlan.setId(null);
			super.persist(workPlan);
			return workPlan;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public void updateWorkPlan(PcWorkPlan workPlan) {
		try {
			super.merge(workPlan);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	public void updateWorkPlanStatus(Integer workPlanId, Integer StatusId) {
		try {
			final String sql = "update PcWorkPlan set status_id = " + StatusId 
					+ " where id = " + workPlanId;
			this.getJpaTemplate().execute(new JpaCallback<Object>(){
				public Object doInJpa(EntityManager em)throws PersistenceException {
					int size = em.createQuery(sql).executeUpdate();
					return size;
				}
	 		 });
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	

	@SuppressWarnings("unchecked")
	@Override
	public List<PcWorkPlan> getCommitWorkPlanListByAgencyIds(List<Integer> agencyIds, Integer year) {
		try {
			if (agencyIds == null || agencyIds.size() == 0) {
				return null;
			}
			String ids = "";
			for (Integer idItem : agencyIds) {
				if (ids.equals("")) {
					ids = idItem + "";
				} else {
					ids += "," + idItem;
				}
			}
			if (year == 0)  {
				Calendar calendar=Calendar.getInstance();  
				calendar.setTime(new Date()); 
				year = calendar.get(Calendar.YEAR);
			}
			return super.find("from PcWorkPlan where agency_id in (" + ids + ") AND year = " + year + " AND status_id >= 3 Order by agency_id ASC ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<PcWorkPlan> getCommitWorkPlanListByAgencyId(Integer agencyId, Integer year, List<FilterVo> filters) {
		try {

			if (year == 0)  {
				Calendar calendar=Calendar.getInstance();  
				calendar.setTime(new Date()); 
				year = calendar.get(Calendar.YEAR);
			}
			
			String where = " WHERE agency_id = " + agencyId + " AND year = " + year ;
			for(FilterVo item:filters) {

				if (item.getId().equals("quarter")) {
					where = where + " AND quarter=" + item.getData();
				}

				if (item.getId().equals("typeId")) {
					where = where + " AND typeId=" + item.getData();
				}	
				
				if (item.getId().equals("statusId")) {
					where = where + " AND status_id=" + item.getData();
				}				
			
			}			
			
			where = where + " AND status_id >= 3";
			
			return super.find("from PcWorkPlan " + where);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PcWorkPlan> getCompleteWorkPlanListByAgencyIds(Integer agencyId, Integer year) {
		try {
			if (agencyId == null) {
				return null;
			}

			return super.find("from PcWorkPlan where agency_id = " + agencyId + " AND year = " + year + " AND status_id = 5 Order by type_id ASC ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	

	@SuppressWarnings("unchecked")
	public PcWorkPlan getWorkPlanQuarterByAgencyId(Integer agencyId,
			Integer year, Integer quarter) {
		try {
			List<PcWorkPlan> list = super.find("from PcWorkPlan where agency_id = ? and year = ? and quarter = ? and typeId = ? order by id desc"
					, agencyId, year, quarter, 2);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public PcWorkPlan getWorkPlanQuarterByTypeId(Integer agencyId,
			Integer year, Integer quarter, Integer typeId) {
		try {
			List<PcWorkPlan> list = super.find("from PcWorkPlan where agency_id = ? and year = ? and quarter = ? and typeId = ? order by id desc"
					, agencyId, year, quarter, typeId);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	

	@SuppressWarnings("unchecked")
	public List<PcWorkPlan> getWorkPlanQuarterByYear(Integer agencyId, Integer year) {
		try {
			return super.find("from PcWorkPlan where agency_id = ? and year = ? and typeId = ? order by id desc",
					agencyId, year, 2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<PcWorkPlan> getResultQuarterByYear(Integer agencyId,
			Integer year) {
		try {
			return super.find("from PcWorkPlan where agency_id = ? and year = ? and typeId = ? order by id desc",
					agencyId, year, 3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public PcWorkPlan getResultQuarterByAgencyId(Integer agencyId,
			Integer year, Integer quarter) {
		try {
			List<PcWorkPlan> list = super.find("from PcWorkPlan where agency_id = ? and year = ? and quarter = ? and typeId = ? order by id desc"
					, agencyId, year, quarter, 3);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public void deleteWorkPlan(Integer workPlanId) {
		try {
			super.removeFromKey(PcWorkPlan.class, workPlanId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}	

}
