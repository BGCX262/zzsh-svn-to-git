package com.partycommittee.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.demo.richTextEditorToHtml;
import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMeetingAsenceDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMeetingContentDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMeetingDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyRelation;
import com.partycommittee.persistence.po.PcMeeting;
import com.partycommittee.persistence.po.PcMeetingContent;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcMeetingContentVo;
import com.partycommittee.remote.vo.PcMeetingVo;
import com.partycommittee.remote.vo.PcWorkPlanContentVo;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Transactional
@Service("PcMeetingService")
public class PcMeetingService {

	@Resource(name="PcMeetingDaoImpl")
	private PcMeetingDaoImpl pcMeetingDaoImpl;
	public void setPcMeetingDaoImpl(PcMeetingDaoImpl pcMeetingDaoImpl) {
		this.pcMeetingDaoImpl = pcMeetingDaoImpl;
	}
	
	@Resource(name="PcMeetingContentDaoImpl")
	private PcMeetingContentDaoImpl pcMeetingContentDaoImpl;
	public void setPcMeetingContentDaoImpl(PcMeetingContentDaoImpl pcMeetingContentDaoImpl) {
		this.pcMeetingContentDaoImpl = pcMeetingContentDaoImpl;
	}
	
	@Resource(name="PcMeetingAsenceDaoImpl")
	private PcMeetingAsenceDaoImpl pcMeetingAsenceDaoImpl;
	public void setPcMeetingAsenceDaoImpl(PcMeetingAsenceDaoImpl pcMeetingAsenceDaoImpl) {
		this.pcMeetingAsenceDaoImpl = pcMeetingAsenceDaoImpl;
	}
	
	@Resource(name="PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;
	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}		
	
	private List<PcMeetingVo> createOriginalMeetingList(Integer agencyId, Integer year, Integer typeId) {
		List<PcMeetingVo> list = new ArrayList<PcMeetingVo>();
		for (int i = 1; i <= 4; i++) {
			PcMeetingVo meeting = new PcMeetingVo();
			meeting.setYear(year);
			meeting.setQuarter(i);
			meeting.setTypeId(typeId);
			meeting.setAgencyId(agencyId);
			meeting.setStatusId(2);
			list.add(meeting);
		}
		return list;
	}
	
	private List<PcMeetingVo> createOriginalCommitteeMeetingList(Integer agencyId, Integer year, Integer typeId) {
		List<PcMeetingVo> list = new ArrayList<PcMeetingVo>();
		for (int i = 1; i <= 12; i++) {
			PcMeetingVo meeting = new PcMeetingVo();
			meeting.setYear(year);
			if (i <= 3) {
				meeting.setQuarter(1);
			} else if (i <= 6) {
				meeting.setQuarter(2);
			} else if (i <= 9) {
				meeting.setQuarter(3);
			} else {
				meeting.setQuarter(4);
			}
			meeting.setMonth(i);
			meeting.setTypeId(typeId);
			meeting.setAgencyId(agencyId);
			meeting.setStatusId(2);
			list.add(meeting);
		}
		return list;
	}
	
	public List<PcMeetingVo> getMeetingList(Integer agencyId, Integer year, Integer meetingType) {
		List<PcMeetingVo> list = new ArrayList<PcMeetingVo>();
		List<PcMeeting> meetingList = pcMeetingDaoImpl.getMeetingList(agencyId, year, meetingType);
		if (meetingList == null || meetingList.size() == 0) {
			return list;
		}

		for (PcMeeting meetingItem : meetingList) {
			PcMeetingVo meetingItemVo = PcMeetingVo.fromPcMeeting(meetingItem);
			String asenceMemberIds = pcMeetingAsenceDaoImpl.getMemberIdsByMeetingId(meetingItemVo.getId());
			meetingItemVo.setAsenceMemberIds(asenceMemberIds);
			list.add(meetingItemVo);
		}
		return list;
	}

	public PcMeetingContentVo getMeetingContent(Integer meetingId) {
		PcMeetingContent content = pcMeetingContentDaoImpl.getMeetingContent(meetingId);
		return PcMeetingContentVo.fromPcMeetingContent(content);
	}

	public void submitMeeting(PcMeetingVo meeting) {
		pcMeetingDaoImpl.submitMeeting(PcMeetingVo.toPcMeeting(meeting));
	}

	public void createMeeting(PcMeetingVo meeting) {
		if (meeting == null) {
			return;
		}
		PcMeeting pcMeeting = pcMeetingDaoImpl.createMeeting(PcMeetingVo.toPcMeeting(meeting));
		if (pcMeeting != null && meeting.getContent() != null) {
			PcMeetingContentVo content = meeting.getContent();
			content.setMeetingId(pcMeeting.getId());
			pcMeetingContentDaoImpl.createContent(PcMeetingContentVo.toPcMeetingContent(content));
		}
		if (pcMeeting != null && meeting.getAsenceMemberIds() != null && !meeting.getAsenceMemberIds().equals("")) {
			pcMeetingAsenceDaoImpl.createAsence(pcMeeting.getId(), meeting.getAsenceMemberIds());
		}
	}

	public void updateMeeting(PcMeetingVo meeting) {
		pcMeetingDaoImpl.updateMeeting(PcMeetingVo.toPcMeeting(meeting));
		if (meeting.getContent() != null) {
			PcMeetingContentVo contentVo = meeting.getContent();
			
			Calendar cal = Calendar.getInstance();
			contentVo.setUpdatetime(cal.getTime());			
			pcMeetingContentDaoImpl.upateContent(PcMeetingContentVo.toPcMeetingContent(contentVo));
		}
		if (meeting.getAsenceMemberIds() != null && !meeting.getAsenceMemberIds().equals("")) {
			pcMeetingAsenceDaoImpl.updateAsence(meeting.getId(), meeting.getAsenceMemberIds());
		}
	}
	
	public void updateMeetingStatus(Integer meetingId, Integer statusId) {
		pcMeetingDaoImpl.updateMeetingStatus(meetingId, statusId);
	}	
	
	public void saveContentMeeting(Integer meetingId, Integer statusId, PcMeetingContentVo contentVo) {
		contentVo.setMeetingId(meetingId);
		//contentVo.setType(3);
		Integer contentType = contentVo.getType();
		
		// 如果为驳回，则需要将updateTime 为延后7天日期.
//		if (contentType == 2) {
//			Calendar cal = Calendar.getInstance();
//			cal.add(Calendar.DATE,7);//把当前系统的日期加7天
//			contentVo.setUpdatetime(cal.getTime());
//		}	
		
		Calendar cal = Calendar.getInstance();
		contentVo.setUpdatetime(cal.getTime());			
		
		PcMeeting pcMeeting = pcMeetingDaoImpl.getMeetingById(meetingId);
		pcMeeting.setStatusId(statusId);
		pcMeetingDaoImpl.updateMeeting(pcMeeting);
		
		PcMeetingContent pcMeetingContent = pcMeetingContentDaoImpl.getContentBymeetingIdAndType(meetingId, contentType);
		if (pcMeetingContent == null) {
			pcMeetingContentDaoImpl.createContent(PcMeetingContentVo.toPcMeetingContent(contentVo));
		} else {
			pcMeetingContent.setContent(contentVo.getContent());
			pcMeetingContent.setMemberName(contentVo.getMemberName());
			pcMeetingContent.setUpdatetime(cal.getTime());
			pcMeetingContentDaoImpl.upateContent(pcMeetingContent);
		}
	}

	public List<PcMeetingVo> getCommitChildrenMeeting(Integer agencyId, Integer year, List<FilterVo> filters) {
		List<PcMeetingVo> list = new ArrayList<PcMeetingVo>();
		
		
		//List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(agencyId);
		
		PcAgency agencyVo =  pcAgencyDaoImpl.getAgencyById(agencyId);
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agencyVo.getCode());		
		
		if (agencyRelationList == null || agencyRelationList.size() == 0) {
			return null;
		}
//		List<Integer> agencyIds = new ArrayList<Integer>();
//		for (PcAgencyRelation agencyRelation : agencyRelationList) {
//			agencyIds.add(agencyRelation.getAgencyId());
//		}
//		List<PcMeeting> meetingList = new ArrayList<PcMeeting>();
//		meetingList = pcMeetingDaoImpl.getCommitMeetingListByAgencyIds(agencyIds, year);
//		if (meetingList != null && meetingList.size() > 0) {
//			for (PcMeeting meeting : meetingList) {
//				PcMeetingVo meetingVoItem = PcMeetingVo.fromPcMeeting(meeting);
//				String asenceMemberIds = pcMeetingAsenceDaoImpl.getMemberIdsByMeetingId(meetingVoItem.getId());
//				meetingVoItem.setAsenceMemberIds(asenceMemberIds);
//				list.add(meetingVoItem);
//			}
//		}

		List<Integer> agencyIds = new ArrayList<Integer>();
		for (PcAgency agency : agencyRelationList) {
			List<PcMeeting> meetingList = new ArrayList<PcMeeting>();
//			PcAgency agency = pcAgencyDaoImpl.getAgencyById(agencyRelation.getId());
			
			meetingList = pcMeetingDaoImpl.getCommitMeetingListByAgencyId(agency.getId(), year, filters);
			
			if (meetingList != null && meetingList.size() > 0) {
				for (PcMeeting meeting : meetingList) {
					PcMeetingVo meetingVoItem = PcMeetingVo.fromPcMeeting(meeting);
					String asenceMemberIds = pcMeetingAsenceDaoImpl.getMemberIdsByMeetingId(meetingVoItem.getId());
					meetingVoItem.setAsenceMemberIds(asenceMemberIds);
					meetingVoItem.setAgencyName(agency.getName());
					list.add(meetingVoItem);
				}
			}				
		}

		return list;
	}

	public PcMeetingContentVo getContentInfo(Integer meetingId, Integer meetingType) {
		PcMeetingContent content = pcMeetingContentDaoImpl.getContentBymeetingIdAndType(meetingId, meetingType);
		if (content == null) {
			return null;
		}
		return PcMeetingContentVo.fromPcMeetingContent(content);
	}	

	public List<PcMeetingVo> getAlertInfo(Integer agencyId, Integer year,
			Integer quarter) {
		List<PcMeetingVo> list = new ArrayList<PcMeetingVo>();
		// class.
		PcMeeting classMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 5);
		if (classMeeting != null) {
			list.add(PcMeetingVo.fromPcMeeting(classMeeting));
		} else {
			PcMeetingVo meetingVo = new PcMeetingVo();
			meetingVo.setTypeId(5);
			meetingVo.setStatusId(0);
			list.add(meetingVo);
		}
		// branch members.
		PcMeeting branchMemberMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 6);
		if (branchMemberMeeting != null) {
			list.add(PcMeetingVo.fromPcMeeting(branchMemberMeeting));
		} else {
			PcMeetingVo meetingVo = new PcMeetingVo();
			meetingVo.setTypeId(6);
			meetingVo.setStatusId(0);
			list.add(meetingVo);
		}
		// branch committee.
		PcMeeting branchCommitteeMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 8);
		if (branchCommitteeMeeting != null) {
			list.add(PcMeetingVo.fromPcMeeting(branchCommitteeMeeting));
		} else {
			PcMeetingVo meetingVo = new PcMeetingVo();
			meetingVo.setTypeId(8);
			meetingVo.setStatusId(0);
			list.add(meetingVo);
		}
		// branch life.
		PcMeeting branchLifeMeeting = pcMeetingDaoImpl.getMeeting(agencyId, year, quarter, 7);
		if (branchLifeMeeting != null) {
			list.add(PcMeetingVo.fromPcMeeting(branchLifeMeeting));
		} else {
			PcMeetingVo meetingVo = new PcMeetingVo();
			meetingVo.setTypeId(7);
			meetingVo.setStatusId(0);
			list.add(meetingVo);
		}
		return list;
	}

	public PcMeetingContentVo getMeetingComment(PcMeetingVo meetingVo) {
		PcMeetingContent content = pcMeetingContentDaoImpl.getMeetingComment(meetingVo.getId());
		if (content == null) {
			return null;
		}
		return PcMeetingContentVo.fromPcMeetingContent(content);
	}
	
	public Boolean deleteMeeting(Integer meetingId) {
		pcMeetingDaoImpl.deleteMeeting(meetingId);
		pcMeetingContentDaoImpl.deleteMeetingContentByMeetingId(meetingId);
		pcMeetingAsenceDaoImpl.deleteMeetingAsenceByMeetingId(meetingId);
		return true;
	}	
}
