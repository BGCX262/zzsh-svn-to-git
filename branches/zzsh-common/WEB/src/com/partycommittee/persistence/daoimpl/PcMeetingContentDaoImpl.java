package com.partycommittee.persistence.daoimpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.springframework.orm.jpa.JpaCallback;
import org.springframework.stereotype.Repository;

import com.partycommittee.persistence.dao.PcMeetingContentDao;
import com.partycommittee.persistence.po.PcMeetingContent;

@Repository("PcMeetingContentDaoImpl")
public class PcMeetingContentDaoImpl extends JpaDaoBase implements PcMeetingContentDao {

	@SuppressWarnings("unchecked")
	public PcMeetingContent getMeetingContent(Integer meetingId) {
		try {
			List<PcMeetingContent> list = super.find("from PcMeetingContent where meetingId = ? and type = ?", meetingId, 1);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public PcMeetingContent getMeetingComment(Integer meetingId) {
		try {
			List<PcMeetingContent> list = super.find("from PcMeetingContent where meetingId = ? and type = ?", meetingId, 3);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void approvalMeeting(PcMeetingContent pcMeetingContent) {
		try {
			pcMeetingContent.setId(null);
			pcMeetingContent.setType(2);
			super.persist(pcMeetingContent);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void evaluateMeeting(PcMeetingContent pcMeetingContent) {
		try {
			pcMeetingContent.setId(null);
			pcMeetingContent.setType(3);
			super.persist(pcMeetingContent);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void createContent(PcMeetingContent pcMeetingContent) {
		try {
			pcMeetingContent.setId(null);
			super.persist(pcMeetingContent);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void upateContent(PcMeetingContent pcMeetingContent) {
		try {
			super.merge(pcMeetingContent);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public PcMeetingContent getContentBymeetingIdAndType(Integer meetingId,
			int i) {
		try {
			List<PcMeetingContent> list = super.find("from PcMeetingContent where meetingId = ? and type = ?", 
					meetingId, i);
			if (list != null && list.size() > 0) {
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public void deleteMeetingContentByMeetingId(Integer meetingId) {
		try {
			final String sql = "delete from PcMeetingContent  where meetingId = " + meetingId;
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
