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
			pcMeetingContentDaoImpl.upateContent(PcMeetingContentVo.toPcMeetingContent(meeting.getContent()));
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
		if (contentType == 2) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE,7);//把当前系统的日期加7天
			contentVo.setUpdatetime(cal.getTime());
		}		
		
		PcMeeting pcMeeting = pcMeetingDaoImpl.getMeetingById(meetingId);
		pcMeeting.setStatusId(statusId);
		pcMeetingDaoImpl.updateMeeting(pcMeeting);
		
		PcMeetingContent pcMeetingContent = pcMeetingContentDaoImpl.getContentBymeetingIdAndType(meetingId, contentType);
		if (pcMeetingContent == null) {
			pcMeetingContentDaoImpl.createContent(PcMeetingContentVo.toPcMeetingContent(contentVo));
		} else {
			pcMeetingContent.setContent(contentVo.getContent());
			pcMeetingContent.setMemberName(contentVo.getMemberName());
			pcMeetingContent.setUpdatetime(contentVo.getUpdatetime());
			pcMeetingContentDaoImpl.upateContent(pcMeetingContent);
		}
	}

	public List<PcMeetingVo> getCommitChildrenMeeting(Integer agencyId, Integer year, List<FilterVo> filters) {
		List<PcMeetingVo> list = new ArrayList<PcMeetingVo>();
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(agencyId);
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
	
	   private Configuration configuration = null;  
	   public PcMeetingService() {  
	      configuration = new Configuration();  
	      configuration.setDefaultEncoding("utf-8");  
	   }  
	  
	   @SuppressWarnings("deprecation")
	   public String exportDoc(Integer meetingId) {

		   try {
			   
			   PcMeeting pcMeeting = pcMeetingDaoImpl.getMeetingById(meetingId);
			   
			   
			   Integer typeId = pcMeeting.getTypeId();
			   PcMeetingContentVo vo = this.getContentInfo(meetingId, 1);
			   
			   String asenceMemberIds = pcMeetingAsenceDaoImpl.getMemberIdsByMeetingId(meetingId);
			   if (asenceMemberIds == null ) asenceMemberIds = "";
			   String report_title =  pcMeeting.getYear() + "年第"+ pcMeeting.getQuarter() + "季度";
			   switch(typeId) {
				   case 5:
					   report_title += "党课";
					   break;
				   case 6:
					   report_title += "支部党员大会";
					   break;
				   case 7:
					   report_title += "支部民主生活会";
					   break;	
				   case 8:
					   report_title += "支部委员会";
					   break;
				   case 9:
					   report_title = pcMeeting.getMeetingName();
					   break;					   
			   }
			   
			   
			   Map dataMap = new HashMap();
			   String str = vo.getContent();
			   String content = richTextEditorToHtml.doRichTextEditorToHtml(str);
//			   String content = "<P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P>";
			   SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy-MM-dd");
			   
			   
			   
			   dataMap.put("report_title", report_title);
			   dataMap.put("report_time", formatNowYear.format(pcMeeting.getMeetingDatetime()));
			   dataMap.put("report_moderator", pcMeeting.getModerator());
			   dataMap.put("report_theme", pcMeeting.getTheme());
			   dataMap.put("report_attend", pcMeeting.getAttend().toString());
			   dataMap.put("report_asence", pcMeeting.getAsence().toString());
			   dataMap.put("report_asenceMembers", asenceMemberIds);
			   dataMap.put("report_content", content);  
			   
			   dataMap.put("report_name", vo.getMemberName());  
			   dataMap.put("report_date", formatNowYear.format(vo.getUpdatetime()));  

			   
			   return this.createDoc(meetingId, dataMap, "meeting.ftl");
		   }catch(Exception $e) {
			   
		   }
		   
		   return "";
		   
	   }
	   
	   public String createDoc(Integer meetingId, Map dataMap, String template) {  
	      // 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，   
	      // 这里我们的模板是放在/com/ybhy/word包下面   
	      configuration.setClassForTemplateLoading(this.getClass(),  
	            "/com/partycommittee/service/templates");  
	      configuration.setEncoding(Locale.CHINA, "UTF-8");
	      Template t = null;  
	      try {  
	         // test.ftl为要装载的模板   
	    	
	         t = configuration.getTemplate(template);
	         t.setEncoding("UTF-8");  
	      } catch (IOException e) {  
	         e.printStackTrace();  
	      }  
	      // 输出文档路径及名称   
	      String path =System.getProperty("zzsh.root") + "/tmp/";
	      String filename = "meeting_" + meetingId + ".doc";
	      File outFile = new File(path + filename);  
	      Writer out = null;
	      try {  
	 
	         
	         out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile),"UTF-8"));  
	         t.process(dataMap, out);  
	         out.close(); 
	      } catch (Exception e1) {  
	         e1.printStackTrace();  
	      }
	      
	      return filename;
	   } 	
	
}
