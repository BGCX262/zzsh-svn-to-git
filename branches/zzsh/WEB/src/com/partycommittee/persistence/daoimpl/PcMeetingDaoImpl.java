package com.partycommittee.persistence.daoimpl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcMeetingDao;
import com.partycommittee.persistence.po.PcMeeting;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.remote.vo.FilterVo;

@Repository("PcMeetingDaoImpl")
public class PcMeetingDaoImpl extends JpaDaoBase implements PcMeetingDao {

	@SuppressWarnings("unchecked")
	public List<PcMeeting> getMeetingList(Integer agencyId, Integer year, Integer typeId) {
		try {
			return super.find("from PcMeeting where agency_id = ? and year = ? and typeId = ?", 
					agencyId, year, typeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<PcMeeting> getMeetingListByQuarter(Integer agencyId, Integer year, Integer quarter, Integer typeId) {
		try {
			return super.find("from PcMeeting where agency_id = ? and year = ? and quarter = ? and typeId = ? Order By meeting_datetime asc", 
					agencyId, year, quarter, typeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	

	public void submitMeeting(PcMeeting pcMeeting) {
		try {
			pcMeeting.setStatusId(1);
			super.merge(pcMeeting);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public PcMeeting createMeeting(PcMeeting pcMeeting) {
		try {
			pcMeeting.setId(null);
			super.persist(pcMeeting);
			return pcMeeting;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void updateMeeting(PcMeeting pcMeeting) {
		try {
			super.merge(pcMeeting);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	public void updateMeetingStatus(Integer meetingId, Integer StatusId) {
		try {
			final String sql = "update PcMeeting set status_id = " + StatusId 
					+ " where id = " + meetingId;
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
	public List<PcMeeting> getCommitMeetingListByAgencyIds(
			List<Integer> agencyIds, Integer year) {
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
			return super.find("from PcMeeting where agency_id in (" + ids + ") AND year = " + year + " AND status_id >= 3 Order by agency_id ASC, quarter ASC, id DESC");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<PcMeeting> getCommitMeetingListByAgencyId(
			Integer agencyId, Integer year, List<FilterVo> filters) {
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
			
			return super.find("from PcMeeting " + where + " Order by quarter, month DESC");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	
	@SuppressWarnings("unchecked")
	public PcMeeting getMeeting(Integer agencyId, Integer year, Integer quarter, Integer typeId) {
		try {
			List<PcMeeting> list = new ArrayList<PcMeeting>();
			list = super.find("from PcMeeting where agency_id = ? and year = ? and quarter = ? and typeId = ?", 
					agencyId, year, quarter, typeId);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public PcMeeting getMeetingById(Integer id) {
		try {
			List<PcMeeting> list = new ArrayList<PcMeeting>();
			list = super.find("from PcMeeting where id = ?", id);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void deleteMeeting(Integer meetingId) {
		try {
			super.removeFromKey(PcMeeting.class, meetingId);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}	

}
