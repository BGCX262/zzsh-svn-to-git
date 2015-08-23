package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcMeetingAsenceDao;
import com.partycommittee.persistence.po.PcMeetingAsence;

@Repository("PcMeetingAsenceDaoImpl")
public class PcMeetingAsenceDaoImpl extends JpaDaoBase implements PcMeetingAsenceDao {

	@SuppressWarnings("unchecked")
	public String getMemberIdsByMeetingId(Integer id) {
		try {
			List<PcMeetingAsence> list = super.find("from PcMeetingAsence where meetingId = ?", id);
			if (list != null && list.size() > 0) {
				return list.get(0).getMemberIds();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public PcMeetingAsence getAsenceByMeetingId(Integer id) {
		try {
			List<PcMeetingAsence> list = super.find("from PcMeetingAsence where meetingId = ?", id);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void createAsence(Integer id, String asenceMemberIds) {
		try {
			PcMeetingAsence asence = new PcMeetingAsence();
			asence.setMeetingId(id);
			asence.setMemberIds(asenceMemberIds);
			super.persist(asence);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateAsence(Integer id, String asenceMemberIds) {
		try {
			PcMeetingAsence asence = getAsenceByMeetingId(id);
			if (asence == null) {
				createAsence(id, asenceMemberIds);
				return;
			}
			asence.setMemberIds(asenceMemberIds);
			super.merge(asence);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteMeetingAsenceByMeetingId(Integer meetingId) {
		try {
			final String sql = "delete from PcMeetingAsence  where meetingId = " + meetingId;
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

}
