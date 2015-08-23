package com.partycommittee.service;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.lang.ObjectUtils;
import org.docx4j.Docx4jProperties;
import org.springframework.stereotype.Service;

import com.common.demo.richTextEditorToHtml;
import com.common.utils.DateUtils;
import com.common.utils.Docx4jUtils;
import com.common.utils.HtmlToDoc;
import com.common.utils.ReadFromFile;
import com.common.utils.freemarkUtils;
import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcDutyCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcEduCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMeetingAsenceDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMeetingContentDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMeetingDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMemberDaoImpl;
import com.partycommittee.persistence.daoimpl.PcNationCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcSexCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcWorkPlanContentDaoImpl;
import com.partycommittee.persistence.daoimpl.PcWorkPlanDaoImpl;

import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcDutyCode;
import com.partycommittee.persistence.po.PcEduCode;
import com.partycommittee.persistence.po.PcMeeting;
import com.partycommittee.persistence.po.PcMeetingContent;
import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.persistence.po.PcNationCode;
import com.partycommittee.persistence.po.PcSexCode;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.persistence.po.PcWorkPlanContent;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.remote.vo.PcMeetingContentVo;
import com.partycommittee.remote.vo.PcMeetingVo;
import com.partycommittee.remote.vo.PcWorkPlanContentVo;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Service("PcWordService")
public class PcWordService {

	@Resource(name = "PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;

	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}

	@Resource(name = "PcMemberDaoImpl")
	private PcMemberDaoImpl pcMemberDaoImpl;

	public void setPcMemberDaoImpl(PcMemberDaoImpl pcMemberDaoImpl) {
		this.pcMemberDaoImpl = pcMemberDaoImpl;
	}

	@Resource(name = "PcWorkPlanDaoImpl")
	private PcWorkPlanDaoImpl pcWorkPlanDaoImpl;

	public void setPcWorkPlanDaoImpl(PcWorkPlanDaoImpl pcWorkPlanDaoImpl) {
		this.pcWorkPlanDaoImpl = pcWorkPlanDaoImpl;
	}

	@Resource(name = "PcWorkPlanContentDaoImpl")
	private PcWorkPlanContentDaoImpl pcWorkPlanContentDaoImpl;

	public void setPcWorkPlanContentDaoImpl(
			PcWorkPlanContentDaoImpl pcWorkPlanContentDaoImpl) {
		this.pcWorkPlanContentDaoImpl = pcWorkPlanContentDaoImpl;
	}

	@Resource(name = "PcMeetingDaoImpl")
	private PcMeetingDaoImpl pcMeetingDaoImpl;

	public void setPcMeetingDaoImpl(PcMeetingDaoImpl pcMeetingDaoImpl) {
		this.pcMeetingDaoImpl = pcMeetingDaoImpl;
	}

	@Resource(name = "PcMeetingContentDaoImpl")
	private PcMeetingContentDaoImpl pcMeetingContentDaoImpl;

	public void setPcMeetingContentDaoImpl(
			PcMeetingContentDaoImpl pcMeetingContentDaoImpl) {
		this.pcMeetingContentDaoImpl = pcMeetingContentDaoImpl;
	}

	@Resource(name = "PcMeetingAsenceDaoImpl")
	private PcMeetingAsenceDaoImpl pcMeetingAsenceDaoImpl;

	public void setPcMeetingAsenceDaoImpl(
			PcMeetingAsenceDaoImpl pcMeetingAsenceDaoImpl) {
		this.pcMeetingAsenceDaoImpl = pcMeetingAsenceDaoImpl;
	}

	@Resource(name="PcDutyCodeDaoImpl")
	private PcDutyCodeDaoImpl pcDutyCodeDaoImpl;
	public void setPcDutyCodeDaoImpl(PcDutyCodeDaoImpl pcDutyCodeDaoImpl) {
		this.pcDutyCodeDaoImpl = pcDutyCodeDaoImpl;
	}	
	
	@Resource(name="PcNationCodeDaoImpl")
	private PcNationCodeDaoImpl pcNationCodeDaoImpl;
	public void setPcNationCodeDaoImpl(PcNationCodeDaoImpl pcNationCodeDaoImpl) {
		this.pcNationCodeDaoImpl = pcNationCodeDaoImpl;
	}	
	
	@Resource(name="PcSexCodeDaoImpl")
	private PcSexCodeDaoImpl pcSexCodeDaoImpl;
	public void setPcSexCodeDaoImpl(PcSexCodeDaoImpl pcSexCodeDaoImpl) {
		this.pcSexCodeDaoImpl = pcSexCodeDaoImpl;
	}		
	
	@Resource(name="PcEduCodeDaoImpl")
	private PcEduCodeDaoImpl pcEduCodeDaoImpl;
	public void setPcEduCodeDaoImpl(PcEduCodeDaoImpl pcEduCodeDaoImpl) {
		this.pcEduCodeDaoImpl = pcEduCodeDaoImpl;
	}			
	

	@SuppressWarnings("deprecation")
	public String exportDocForAll(Integer agencyId, Integer year) {
		
		PcAgency agency = pcAgencyDaoImpl.getAgencyById(agencyId);

		String path = System.getProperty("zzsh.root") + "/tmp/";
		
		String resultName = agencyId + "_" + System.currentTimeMillis() + ".docx";
		
		String fileName = agencyId + "_out_" + System.currentTimeMillis() + ".docx";
		String outName = path + fileName;

		freemarkUtils f = new freemarkUtils();
		String p_name = "";
		try {
			
			//查找单位：
			PcAgency p = agency;
			
			while(true) {
				p = pcAgencyDaoImpl.getAgencyById(p.getParentId());
				if (p.getCodeId() == 7 || p.getCodeId() == 15 || p.getCodeId() == 6) {
					p_name = p.getName();
					break;
				}	
			}			
			
			p_name = p_name.replaceAll("党委", "");
			
			//首页
			byte[] out_index = exportDocForIndex(agency, year, p_name);
			if (out_index != null) {
				f.saveToFile(outName, out_index);
			}
			
			//基本情况
			byte[] out_base = exportDocForBase(agency);
	
			if (out_base != null) {
				f.saveToFile(outName, out_base);
			}
			
			//委员花名册
			byte[] out_members_wy = exportDocForMembersWy(agency);
			if (out_members_wy != null) {
				f.saveToFile(outName, out_members_wy);
			}
			
			//年度计划
			PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanYearlyByAgencyId(agencyId, year);
			byte[] out_wp = exportDocForWp(workPlan.getId());
			if (out_wp != null) {
				f.saveToFile(outName, out_wp);
			}
			
			PcWorkPlan wp_q = null;
			PcWorkPlan wp_qs = null;
			int i = 1;
			int j = 5;
			for (i = 1; i <=4 ; i++) {
				
				//季度计划
				byte[] out_wp_q = null;
				wp_q = pcWorkPlanDaoImpl.getWorkPlanQuarterByAgencyId(agencyId, year, i);
				if (wp_q == null) continue;
				out_wp_q = exportDocForWp(wp_q.getId());
				
				if (out_wp_q != null) {
					f.saveToFile(outName, out_wp_q);
				}
				

				//会议
				byte[] out_mt = null;
				for (j = 5; j <=9; j++) {
					List<PcMeeting> meetingList = pcMeetingDaoImpl.getMeetingListByQuarter(agencyId, year, i, j);
					
					for (PcMeeting meetingItem : meetingList) {
						out_mt = exportDocForMt(meetingItem);
						
						if (out_mt != null) {
							f.saveToFile(outName, out_mt);
						}					
						out_mt = null;
					}
				}	
				
				
				//季度执行情况
				byte[] out_wp_qs = null;
				wp_qs =  pcWorkPlanDaoImpl.getWorkPlanQuarterByTypeId(agencyId, year, i, 3);
				if (wp_qs == null) continue;
				out_wp_qs = exportDocForWp(wp_qs.getId());
				
				if (out_wp_qs != null) {
					f.saveToFile(outName, out_wp_qs);
				}
								
				
				
			}

			//年终总结
			PcWorkPlan workPlan_end = pcWorkPlanDaoImpl.getWorkPlanYearlySummaryByAgencyId(agencyId, year);
			if (workPlan_end != null) {
				byte[] out_wp_end = exportDocForWp(workPlan_end.getId());
				if (out_wp_end != null) {
					f.saveToFile(outName, out_wp_end);
				}
			}
			
			//进行htmltoDoc转换
			byte[] content = ReadFromFile.getBytes(outName);
			HtmlToDoc.doHtmlToDoc(content, outName);
			
			
			String fileName_table = agencyId + "_out_table_" + System.currentTimeMillis() + ".docx";
			String outName_table = path + fileName_table;			
			
			Properties properties = Docx4jProperties.getProperties();
	        properties.setProperty("docx4j.PageOrientationLandscape", "true");     			
			
			//党员花名册
			
			byte[] out_members = exportDocForMembers(agency);
			if (out_members != null) {
				f.saveToFile(outName_table, out_members);
			}
			
			//进行htmltoDoc转换
			byte[] content_table = ReadFromFile.getBytes(outName_table);
			HtmlToDoc.doHtmlToDoc(content_table, outName_table);			
			
			//最后在进行outName 与 outName_table 合并，解决一个word文件横排和竖排并存的问题
			
			Boolean s = Docx4jUtils.merge(outName, outName_table, path + resultName);
			
			//删除临时文件
			if (s) {
				File f1 = new File(outName);
				f1.deleteOnExit();
				f1.delete();				
				
				
				File f2 = new File(outName);
				
				f2.deleteOnExit();
				f2.delete();					
			}
			
		
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return p_name + "--" + resultName;
	}
	
	@SuppressWarnings("deprecation")
	public String exportDocForWorkPlan(Integer workPlanId) {
		
		String path = System.getProperty("zzsh.root") + "/tmp/";
		String fileName = "gzsc_" + System.currentTimeMillis() + ".docx";
		String outName = path + fileName;
		freemarkUtils f = new freemarkUtils();
		try {
			Properties properties = Docx4jProperties.getProperties();
	        properties.setProperty("docx4j.PageOrientationLandscape", "false");        			
			//年度计划
			PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanById(workPlanId);
			byte[] out_wp = exportDocForWp(workPlan.getId());
			if (out_wp != null) {
				f.saveToFile(outName, out_wp);
			}
			
			//进行htmltoDoc转换
			byte[] content_table = ReadFromFile.getBytes(outName);
			HtmlToDoc.doHtmlToDoc(content_table, outName);				
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return fileName;
	}
	
	@SuppressWarnings("deprecation")
	public String exportDocForMeeting(Integer meetingId) {
		
		String path = System.getProperty("zzsh.root") + "/tmp/";
		String fileName = "gzsc_" + System.currentTimeMillis() + ".docx";
		String outName = path + fileName;
		freemarkUtils f = new freemarkUtils();
		try {
						
			Properties properties = Docx4jProperties.getProperties();
	        properties.setProperty("docx4j.PageOrientationLandscape", "false");     
			PcMeeting meeting = pcMeetingDaoImpl.getMeetingById(meetingId);
			byte[] out_wp = exportDocForMt(meeting);
			if (out_wp != null) {
				f.saveToFile(outName, out_wp);
			}
			
			//进行htmltoDoc转换
			byte[] content_table = ReadFromFile.getBytes(outName);
			HtmlToDoc.doHtmlToDoc(content_table, outName);				
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return fileName;
	}	
	
	public byte[] exportDocForIndex(PcAgency agency, Integer year, String p_name) {
		
		if (agency == null) {
			return null;
		}
		String t = "index.htm";
		
		try {
			freemarkUtils f = new freemarkUtils();

			Map<String, String> map_index = new HashMap<String, String>();
			map_index.put("g_year", year.toString());
			map_index.put("dw_name", p_name);
			map_index.put("zb_name", agency.getName());

			byte[] out_index = f.createDoc(t, map_index);
			return out_index;
		} catch (Exception e) {
			return null;
		}
		
	}

	public byte[] exportDocForBase(PcAgency agency) {
		
		if (agency == null) {
			return null;
		}		
		
		String t = "zb-base.htm";
		SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy年MM月dd日");
		Map<String, String> map_base = new HashMap<String, String>();
		map_base.put("zb_name", agency.getName());
		map_base.put("gx_date", formatNowYear.format(agency.getSetupDatetime()));
		map_base.put("dxz_num", agency.getPcount().toString());
		map_base.put("zb_num", agency.getZbnum().toString());

		map_base.put("zbsj", "");
		map_base.put("zbfsj", "");
		map_base.put("zzwy", "");
		map_base.put("jjwy", "");
		map_base.put("xcwy", "");
		map_base.put("qnwy", "");
		map_base.put("ghwy", "");
		map_base.put("fnwy", "");
		map_base.put("bmwy", "");

		List<PcMember> memberList = pcMemberDaoImpl.getMemberListByAgencyId(agency.getId());
		
		if (memberList != null && memberList.size() > 0) {
			for (PcMember member : memberList) {
				switch (member.getDutyId()) {
				case 1:
					map_base.put("zbsj", member.getName());
					break;
				case 2:
					map_base.put("zbfsj", member.getName());
					break;
				case 3:
					map_base.put("zzwy", member.getName());
					break;
				case 4:
					map_base.put("xcwy", member.getName());
					break;
				case 5:
					map_base.put("jjwy", member.getName());
					break;
				case 6:
					map_base.put("qnwy", member.getName());
					break;
				case 7:
					map_base.put("ghwy", member.getName());
					break;

				case 8:
					map_base.put("bmwy", member.getName());
					break;
				case 9:
					map_base.put("fnwy", member.getName());
					break;
				}

			}

		}

		try {
			freemarkUtils f = new freemarkUtils();
			byte[] out_index = f.createDoc(t, map_base);
			return out_index;
		} catch (Exception e) {

		}
		return null;
	}

	public byte[] exportDocForWp(Integer workPlanId) {
		if (workPlanId == null || workPlanId == 0) {
			return null;
		}
		String t = "workplan.htm";
		try {

			PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanById(workPlanId);
			
			if (workPlan == null ) {
				return null;
			}
			Integer typeId = workPlan.getTypeId();

			String report_title = "";
			switch (typeId) {
			case 1:
				report_title = "(" + workPlan.getYear() + ")年度工作计划";
				break;
			case 2:
				report_title = "(" + workPlan.getYear() + ")年第"
						+ workPlan.getQuarter() + "季度工作安排";
				break;
			case 3:
				report_title = "(" + workPlan.getYear() + ")年第"
						+ workPlan.getQuarter() + "季度工作执行情况";
				break;
			case 4:
				report_title = "(" + workPlan.getYear() + ")年度工作总结";
				break;
			}

			Map dataMap = new HashMap();
			SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy年MM月dd日");
			String str = null;
			String content = null;

			// 计划内容
			PcWorkPlanContentVo vo = this.getWpContentInfo(workPlanId, 1);

			str = vo.getContent();
			content = richTextEditorToHtml.doRichTextEditorToHtml(str);
			// String content =
			// "<P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P>";

			dataMap.put("wp_title", report_title);
			dataMap.put("wp_content", content);
			dataMap.put("wp_reported", vo.getMemberName());
			dataMap.put("wp_date", formatNowYear.format(vo.getUpdatetime()));

			// 评语
			PcWorkPlanContentVo py_vo = this.getWpContentInfo(workPlanId, 3);
			str = py_vo.getContent();
			content = richTextEditorToHtml.doRichTextEditorToHtml(str);
			dataMap.put("py_content", content);
			dataMap.put("py_obj", py_vo.getMemberName());
			dataMap.put("py_date", formatNowYear.format(py_vo.getUpdatetime()));

			// 评价
			PcWorkPlanContentVo pj_vo = this.getWpContentInfo(workPlanId, 4);
			str = pj_vo.getContent();
			String rate = "";

			if (str.equals("1")) rate = "好";
			if (str.equals("2")) rate = "较好";
			if (str.equals("3")) rate = "一般";
			if (str.equals("4")) rate = "差";

			dataMap.put("pj_content", rate);
			dataMap.put("pj_obj", pj_vo.getMemberName());
			dataMap.put("pj_date", formatNowYear.format(pj_vo.getUpdatetime()));

			freemarkUtils f = new freemarkUtils();
			byte[] out_workplan = f.createDoc(t, dataMap);
			return out_workplan;

		} catch (Exception e) {

		}

		return null;

	}

	public PcWorkPlanContentVo getWpContentInfo(Integer workPlanId, Integer type) {
		PcWorkPlanContent content = pcWorkPlanContentDaoImpl
				.getContentByWorkPlanIdAndType(workPlanId, type);
		if (content == null) {
			return null;
		}
		return PcWorkPlanContentVo.fromPcWorkPlanContent(content);
	}

	public byte[] exportDocForMt(PcMeeting pcMeeting) {
		if (pcMeeting == null) {
			return null;
		}
		try {

//			PcMeeting pcMeeting = pcMeetingDaoImpl.getMeetingById(meetingId);
			if (pcMeeting == null) {
				return null;
			}
			Integer typeId = pcMeeting.getTypeId();

			String t = "meeting.htm";

			if (typeId == 9) {
				t = "meeting-other.htm";
			}
			Integer meetingId = pcMeeting.getId();
			PcMeetingContentVo vo = this.getMtContentInfo(meetingId, 1);

			String asenceMemberIds = pcMeetingAsenceDaoImpl.getMemberIdsByMeetingId(meetingId);
			if (asenceMemberIds == null)
				asenceMemberIds = "";
			String report_title = "(" + pcMeeting.getYear() + ")年第"
					+ pcMeeting.getQuarter() + "季度";
			switch (typeId) {
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
				report_title = "(" + pcMeeting.getYear() + ")年第"
						+ pcMeeting.getMonth() + "月支部委员会";
				break;
			case 9:
				report_title = pcMeeting.getMeetingName();
				break;
			}

			Map dataMap = new HashMap();
			String str = vo.getContent();
			String content = richTextEditorToHtml.doRichTextEditorToHtml(str);
			// String content =
			// "<P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P>";
			SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy年MM月dd日");
			
			
			dataMap.put("mt_title", report_title);
			
			dataMap.put("mt_time", formatNowYear.format(pcMeeting
					.getMeetingDatetime()));
			dataMap.put("mt_mod", pcMeeting.getModerator());
			dataMap.put("mt_theme", pcMeeting.getTheme());
			dataMap.put("mt_attend", pcMeeting.getAttend().toString());
			dataMap.put("mt_asence", pcMeeting.getAsence().toString());
			dataMap.put("mt_asencems", asenceMemberIds);

			dataMap.put("mt_content", content);

			dataMap.put("mt_reported", vo.getMemberName());
			dataMap.put("mt_date", formatNowYear.format(vo.getUpdatetime()));

			// 评语
			PcMeetingContentVo py_vo = this.getMtContentInfo(meetingId, 3);
			str = py_vo.getContent();
			content = richTextEditorToHtml.doRichTextEditorToHtml(str);
			dataMap.put("py_content", content);
			dataMap.put("py_obj", py_vo.getMemberName());
			dataMap.put("py_date", formatNowYear.format(py_vo.getUpdatetime()));

			// 评价
			PcMeetingContentVo pj_vo = this.getMtContentInfo(meetingId, 4);
			str = pj_vo.getContent();
			String rate = "";
			
			if (str.equals("1")) rate = "好";
			if (str.equals("2")) rate = "较好";
			if (str.equals("3")) rate = "一般";
			if (str.equals("4")) rate = "差";

			dataMap.put("pj_content", rate);
			dataMap.put("pj_obj", pj_vo.getMemberName());
			dataMap.put("pj_date", formatNowYear.format(pj_vo.getUpdatetime()));

			freemarkUtils f = new freemarkUtils();
			byte[] out_meeting = f.createDoc(t, dataMap);
			return out_meeting;

		} catch (Exception e) {
			return null;
		}



	}

	public PcMeetingContentVo getMtContentInfo(Integer meetingId,
			Integer meetingType) {
		PcMeetingContent content = pcMeetingContentDaoImpl
				.getContentBymeetingIdAndType(meetingId, meetingType);
		if (content == null) {
			return null;
		}
		return PcMeetingContentVo.fromPcMeetingContent(content);
	}
	
	public byte[] exportDocForMembers(PcAgency agency) {
		// 输出文档路径及名称   

	    try{

	        List<PcDutyCode> dutyList = pcDutyCodeDaoImpl.getDutyList();
	        List<PcNationCode> nationList = pcNationCodeDaoImpl.getNationList();
	        List<PcSexCode> sexList = pcSexCodeDaoImpl.getSexList();
	        List<PcEduCode> eduList = pcEduCodeDaoImpl.getEduList();	        
	        	        
//	        int index_x_col = 0;
//	        Integer index_y_col = 0;
	        
	        List<Integer> agencyIds = new ArrayList();
	        // 先判断上级关系

	        	
        	//获取支部上级名称.
        	String tmp_code = agency.getCode();

//        	List<PcAgency> parents = new ArrayList<PcAgency>();
//        	while(tmp_code.length() > 2) {
//        		tmp_code = tmp_code.substring(0,  tmp_code.length() -2 );
//        		PcAgency agency_parent = pcAgencyDaoImpl.getAgencyByCode(tmp_code);
//        		if (agency_parent == null) continue;
//        		parents.add(agency_parent);
//        	}
        	
	        List<PcMember> memberList = pcMemberDaoImpl.getMemberListByAgencyId(agency.getId());  
	        int col = 1;
	        String t = "members.htm";
	        SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy年MM月dd日");
	        Map<String,Object> dataMap=new HashMap<String,Object>();    
	        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();    
	        if (memberList != null && memberList.size() > 0) {
	        	
	        	
				for (PcMember member : memberList) {
					Map<String,Object> map = new HashMap<String,Object>();   

					
					//序号
					map.put("no", col);

					//姓名
			        map.put("name",  member.getName());
			        
			        			        
			        //性别
			        String sex_name = "";
			        for (PcSexCode item : sexList) {
						if (member.getSexId() != null && member.getSexId().equals(item.getId())) {
							sex_name = item.getDescription();
							break;
						}
					}			        
			        map.put("sex_name",  sex_name);
			        
			        
			        //民族
			        String nation_name = "";
			        for (PcNationCode item : nationList) {
						if (member.getNationId() != null &&  member.getNationId().equals(item.getId())) {
							nation_name = item.getDescription();
							break;
						}
					}
			        map.put("nation_name",  nation_name);
			        
			        //出生年月
			        map.put("birthday", "");
			        map.put("age", "");		
			        if (member.getBirthday() != null) {
				        map.put("birthday",  formatNowYear.format(member.getBirthday()));    
				        
				        //年龄
				        Integer age = DateUtils.getAge(member.getBirthday());
				        map.put("age", age.toString());		
        
			        }
			        

			        
			        //籍贯
			        map.put("birth_place", member.getBirthPlace());

			        //参加工作时间
			        map.put("work_day", "");
			        if (member.getWorkday() != null) {
			        	map.put("work_day",  formatNowYear.format(member.getWorkday()));    
			        }
			        
			        //入党时间
			        map.put("join_day", "");
			        if (member.getJoinday() != null) {
			        	map.put("join_day",  formatNowYear.format(member.getJoinday()));    
			        }

			        //文化程度
			        String edu_name = "";
			        for (PcEduCode item : eduList) {
						if (member.getEduId() != null && member.getEduId().equals(item.getId())) {
							edu_name = item.getDescription();
							break;
						}
					}				        
			        map.put("edu_name",  edu_name);
			        
			        //党内职务
			        String duty_name = "";
			        for (PcDutyCode item : dutyList) {
						if (member.getDutyId().equals(item.getId())) {
							duty_name = item.getDescription();
							break;
						}
					}
			        
			        map.put("duty_name",  duty_name);			        
			        
			        //行政职务
			        map.put("admin_duty",  member.getAdminDuty());
			        


			        list.add(map); 
			        col++;
				}
	        }
			
	        dataMap.put("members", list);
	        
			freemarkUtils f = new freemarkUtils();
			byte[] out_members = f.createDoc(t, dataMap);
			return out_members;	        
	
	    }catch(Exception e){
	      System.out.println(e);
	    }	    
	    
	    return null;
		
	}	
	
	
	public byte[] exportDocForMembersWy(PcAgency agency) {
		// 输出文档路径及名称   

	    try{

	        List<PcDutyCode> dutyList = pcDutyCodeDaoImpl.getDutyList();
	        List<PcNationCode> nationList = pcNationCodeDaoImpl.getNationList();
	        List<PcSexCode> sexList = pcSexCodeDaoImpl.getSexList();
	        List<PcEduCode> eduList = pcEduCodeDaoImpl.getEduList();	        
	        	        
//	        int index_x_col = 0;
//	        Integer index_y_col = 0;
	        
	        List<Integer> agencyIds = new ArrayList();
	        // 先判断上级关系

	        	
        	//获取支部上级名称.
        	String tmp_code = agency.getCode();

	        List<PcMember> memberList = pcMemberDaoImpl.getDutyMemberListByAgencyId(agency.getId());  
	        int col = 1;
	        String t = "members-wy.htm";
	        SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy年MM月dd日");
	        Map<String,Object> dataMap=new HashMap<String,Object>();    
	        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();    
	        if (memberList != null && memberList.size() > 0) {
	        	
	        	
				for (PcMember member : memberList) {
					Map<String,Object> map = new HashMap<String,Object>();   

					
					//党内职务
			        String duty_name = "";
			        for (PcDutyCode item : dutyList) {
						if (member.getDutyId().equals(item.getId())) {
							duty_name = item.getDescription();
							break;
						}
					}
			        
			        map.put("duty_name",  duty_name);	

					//姓名
			        map.put("name",  member.getName());
			        
			        			        
			        //性别
			        String sex_name = "";
			        for (PcSexCode item : sexList) {
						if (member.getSexId() != null && member.getSexId().equals(item.getId())) {
							sex_name = item.getDescription();
							break;
						}
					}			        
			        map.put("sex_name",  sex_name);
			        
			        
			        //民族
			        String nation_name = "";
			        for (PcNationCode item : nationList) {
						if (member.getNationId() != null &&  member.getNationId().equals(item.getId())) {
							nation_name = item.getDescription();
							break;
						}
					}
			        map.put("nation_name",  nation_name);
			        
			        //出生年月
			        map.put("birthday", "");
			        map.put("age", "");		
			        if (member.getBirthday() != null) {
				        map.put("birthday",  formatNowYear.format(member.getBirthday()));    
				        
				        //年龄
				        Integer age = DateUtils.getAge(member.getBirthday());
				        map.put("age", age.toString());		
        
			        }
			        

			        //参加工作时间
			        map.put("work_day", "");
			        if (member.getWorkday() != null) {
			        	map.put("work_day",  formatNowYear.format(member.getWorkday()));    
			        }
			        
			        //入党时间
			        map.put("join_day", "");
			        if (member.getJoinday() != null) {
			        	map.put("join_day",  formatNowYear.format(member.getJoinday()));    
			        }

			        //文化程度
			        String edu_name = "";
			        for (PcEduCode item : eduList) {
						if (member.getEduId() != null && member.getEduId().equals(item.getId())) {
							edu_name = item.getDescription();
							break;
						}
					}				        
			        map.put("edu_name",  edu_name);
			        
			        		        
			        
			        //行政职务
			        map.put("postday",  formatNowYear.format(member.getPostday()));
			        


			        list.add(map); 
			        col++;
				}
	        }
			
	        dataMap.put("members", list);
	        
			freemarkUtils f = new freemarkUtils();
			byte[] out_members = f.createDoc(t, dataMap);
			return out_members;	        
	
	    }catch(Exception e){
	      System.out.println(e);
	    }	    
	    
	    return null;
		
	}		
	

}
