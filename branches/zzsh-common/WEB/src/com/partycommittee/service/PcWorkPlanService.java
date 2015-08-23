package com.partycommittee.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.taglibs.standard.extra.spath.Path;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.demo.richTextEditorToHtml;
import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcWorkPlanDaoImpl;
import com.partycommittee.persistence.daoimpl.PcWorkPlanContentDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyRelation;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.persistence.po.PcWorkPlanContent;
import com.partycommittee.remote.vo.FilterVo;
import com.partycommittee.remote.vo.PcWorkPlanContentVo;
import com.partycommittee.remote.vo.PcWorkPlanVo;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Transactional
@Service("PcWorkPlanService")
public class PcWorkPlanService {

	@Resource(name="PcWorkPlanDaoImpl")
	private PcWorkPlanDaoImpl pcWorkPlanDaoImpl;
	public void setPcWorkPlanDaoImpl(PcWorkPlanDaoImpl pcWorkPlanDaoImpl) {
		this.pcWorkPlanDaoImpl = pcWorkPlanDaoImpl;
	}
	
	@Resource(name="PcWorkPlanContentDaoImpl")
	private PcWorkPlanContentDaoImpl pcWorkPlanContentDaoImpl;
	public void setPcWorkPlanContentDaoImpl(PcWorkPlanContentDaoImpl pcWorkPlanContentDaoImpl) {
		this.pcWorkPlanContentDaoImpl = pcWorkPlanContentDaoImpl;
	}

	@Resource(name="PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;
	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}	
	
	public void createWorkPlan(PcWorkPlanVo workPlan) throws Exception {
		if (workPlan == null) {
			return;
		}
		
		// 先检查唯一性
		PcWorkPlan svo = pcWorkPlanDaoImpl.getWorkPlanQuarterByTypeId(workPlan.getAgencyId(), workPlan.getYear(), workPlan.getQuarter(), workPlan.getTypeId());
		
		if (svo == null) {
		
			PcWorkPlan pcWorkPlan = pcWorkPlanDaoImpl.createWorkPlan(PcWorkPlanVo.toPcWorkPlan(workPlan));
			if (pcWorkPlan != null && workPlan.getWorkPlanContent() != null) {
				PcWorkPlanContentVo content = workPlan.getWorkPlanContent();
				content.setWorkplanId(pcWorkPlan.getId());
				pcWorkPlanContentDaoImpl.createContent(PcWorkPlanContentVo.toPcWorkPlanContent(content));
			}
		} else {
			workPlan.setId(svo.getId());
			pcWorkPlanDaoImpl.updateWorkPlan(PcWorkPlanVo.toPcWorkPlan(workPlan));
			if (workPlan.getWorkPlanContent() != null) {
				PcWorkPlanContentVo content = workPlan.getWorkPlanContent();
				PcWorkPlanContent workPlanContent = pcWorkPlanContentDaoImpl.getContentByWorkPlanId(workPlan.getId());
				content.setWorkplanId(workPlan.getId());
				content.setId(workPlanContent.getId());
				pcWorkPlanContentDaoImpl.upateContent(PcWorkPlanContentVo.toPcWorkPlanContent(content));
			}
		}
	}
	
	public void updateWorkPlan(PcWorkPlanVo workPlan) {
		pcWorkPlanDaoImpl.updateWorkPlan(PcWorkPlanVo.toPcWorkPlan(workPlan));
		if (workPlan.getWorkPlanContent() != null) {
			pcWorkPlanContentDaoImpl.upateContent(PcWorkPlanContentVo.toPcWorkPlanContent(workPlan.getWorkPlanContent()));
		}
	}
	
	public void updateWorkPlanStatus(Integer workPlanId, Integer StatusId) {
		pcWorkPlanDaoImpl.updateWorkPlanStatus(workPlanId, StatusId);
	}
	
	public PcWorkPlanVo getWorkPlayYearly(Integer agencyId, Integer year) {
		PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanYearlyByAgencyId(agencyId, year);
		if (workPlan == null) {
			return null;
		}
		PcWorkPlanContent workPlanContent = pcWorkPlanContentDaoImpl.getContentByWorkPlanId(workPlan.getId());
		PcWorkPlanVo workPlanVo = PcWorkPlanVo.fromPcWorkPlan(workPlan);
		workPlanVo.setWorkPlanContent(PcWorkPlanContentVo.fromPcWorkPlanContent(workPlanContent));
		return workPlanVo;
	}
	
	public PcWorkPlanVo getWorkPlayYearlySummary(Integer agencyId, Integer year) {
		PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanYearlySummaryByAgencyId(agencyId, year);
		if (workPlan == null) {
			return null;
		}
		PcWorkPlanContent workPlanContent = pcWorkPlanContentDaoImpl.getContentByWorkPlanId(workPlan.getId());
		PcWorkPlanVo workPlanVo = PcWorkPlanVo.fromPcWorkPlan(workPlan);
		workPlanVo.setWorkPlanContent(PcWorkPlanContentVo.fromPcWorkPlanContent(workPlanContent));
		return workPlanVo;
	}

	public List<PcWorkPlanVo> getCommitWorkplanListByParentId(Integer agencyId, Integer year, List<FilterVo> filters) {
		List<PcWorkPlanVo> list = new ArrayList<PcWorkPlanVo>();
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(agencyId);
		if (agencyRelationList == null || agencyRelationList.size() == 0) {
			return null;
		}
//		List<Integer> agencyIds = new ArrayList<Integer>();
//		for (PcAgencyRelation agencyRelation : agencyRelationList) {
//			agencyIds.add(agencyRelation.getAgencyId());
//		}
//		List<PcWorkPlan> workPlanList = new ArrayList<PcWorkPlan>();
//		workPlanList = pcWorkPlanDaoImpl.getCommitWorkPlanListByAgencyIds(agencyIds, year);
//		for (PcWorkPlan workPlan : workPlanList) {
//			list.add(PcWorkPlanVo.fromPcWorkPlan(workPlan));
//		}
		

		for (PcAgency agency : agencyRelationList) {
			List<PcWorkPlan> workPlanList = new ArrayList<PcWorkPlan>();
			workPlanList = pcWorkPlanDaoImpl.getCommitWorkPlanListByAgencyId(agency.getId(), year, filters);

			
			for (PcWorkPlan workPlan : workPlanList) {
				PcWorkPlanVo vo = PcWorkPlanVo.fromPcWorkPlan(workPlan);
				vo.setAgencyName(agency.getName());
				list.add(vo);
			}			
		}
		

		return list;
	}
	
	public PcWorkPlanContentVo getWorkPlanContentByWorkPlanId(Integer workPlanId) {
		PcWorkPlanContent content = pcWorkPlanContentDaoImpl.getContentByWorkPlanIdAndType(workPlanId, 1);
		return PcWorkPlanContentVo.fromPcWorkPlanContent(content);
	}
	
	public void saveContentWrokplan(Integer workPlanId, Integer statusId, PcWorkPlanContentVo contentVo) {
		contentVo.setWorkplanId(workPlanId);
		//contentVo.setType(3);
		Integer contentType = contentVo.getType();
		
		// 如果为驳回，则需要将updateTime 为延后7天日期.
		if (contentType == 2) {
			Calendar cal = Calendar.getInstance();
			 cal.add(Calendar.DATE,7);//把当前系统的日期加7天
			 contentVo.setUpdatetime(cal.getTime());
		}
		
		PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanById(workPlanId);
		workPlan.setStatusId(statusId);
		pcWorkPlanDaoImpl.updateWorkPlan(workPlan);
		PcWorkPlanContent workPlanContent = pcWorkPlanContentDaoImpl.getContentByWorkPlanIdAndType(workPlanId, contentType);
		if (workPlanContent == null) {
			pcWorkPlanContentDaoImpl.createContent(PcWorkPlanContentVo.toPcWorkPlanContent(contentVo));
		} else {
			workPlanContent.setContent(contentVo.getContent());
			workPlanContent.setMemberName(contentVo.getMemberName());
			workPlanContent.setUpdatetime(contentVo.getUpdatetime());
			pcWorkPlanContentDaoImpl.upateContent(workPlanContent);
		}
	}

	public PcWorkPlanVo getWorkPlanQuarter(Integer agencyId, Integer year,
			Integer quarter) {
		PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanQuarterByAgencyId(agencyId, year, quarter);
		if (workPlan == null) {
			return null;
		}
		PcWorkPlanContent workPlanContent = pcWorkPlanContentDaoImpl.getContentByWorkPlanId(workPlan.getId());
		PcWorkPlanVo workPlanVo = PcWorkPlanVo.fromPcWorkPlan(workPlan);
		workPlanVo.setWorkPlanContent(PcWorkPlanContentVo.fromPcWorkPlanContent(workPlanContent));
		return workPlanVo;
	}
	
	public PcWorkPlanVo getWorkPlanQuarterSummary(Integer agencyId, Integer year,
			Integer quarter) {
		PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanQuarterByTypeId(agencyId, year, quarter, 3);
		if (workPlan == null) {
			return null;
		}
		PcWorkPlanContent workPlanContent = pcWorkPlanContentDaoImpl.getContentByWorkPlanId(workPlan.getId());
		PcWorkPlanVo workPlanVo = PcWorkPlanVo.fromPcWorkPlan(workPlan);
		workPlanVo.setWorkPlanContent(PcWorkPlanContentVo.fromPcWorkPlanContent(workPlanContent));
		return workPlanVo;
	}	

	public List<PcWorkPlanVo> getWorkPlanListQuarter(Integer agencyId, Integer year) {
		List<PcWorkPlanVo> list = createOriginalQuarterWorkPlanList(agencyId, year, 2);
		List<PcWorkPlan> workPlanList = pcWorkPlanDaoImpl.getWorkPlanQuarterByYear(agencyId, year);
		if (workPlanList == null || workPlanList.size() == 0) {
			return list;
		}
		for (PcWorkPlan workPlanItem : workPlanList) {
			for (int i = 0; i < list.size(); i++) {
				PcWorkPlanVo workPlanVo = list.get(i);
				if (workPlanVo.getQuarter().intValue() == workPlanItem.getQuarter().intValue()) {
					list.remove(i);
					list.add(i, PcWorkPlanVo.fromPcWorkPlan(workPlanItem));
				}
			}
		}
		return list;
	}

	private List<PcWorkPlanVo> createOriginalQuarterWorkPlanList(Integer agencyId, Integer year, Integer typeId) {
		List<PcWorkPlanVo> list = new ArrayList<PcWorkPlanVo>();
		for (int i = 1; i <= 4; i++) {
			PcWorkPlanVo pcWorkPlan = new PcWorkPlanVo();
			pcWorkPlan.setYear(year);
			pcWorkPlan.setQuarter(i);
			pcWorkPlan.setTypeId(typeId);
			pcWorkPlan.setAgencyId(agencyId);
			pcWorkPlan.setStatusId(1);
			list.add(pcWorkPlan);
		}
		return list;
	}

	public List<PcWorkPlanVo> getResultListQuarter(Integer agencyId, Integer year) {
		List<PcWorkPlanVo> list = createOriginalQuarterWorkPlanList(agencyId, year, 3);
		List<PcWorkPlan> workPlanList = pcWorkPlanDaoImpl.getResultQuarterByYear(agencyId, year);
		if (workPlanList == null || workPlanList.size() == 0) {
			return list;
		}
		for (PcWorkPlan workPlanItem : workPlanList) {
			for (int i = 0; i < list.size(); i++) {
				PcWorkPlanVo workPlanVo = list.get(i);
				if (workPlanVo.getQuarter().intValue() == workPlanItem.getQuarter().intValue()) {
					list.remove(i);
					list.add(i, PcWorkPlanVo.fromPcWorkPlan(workPlanItem));
				}
			}
		}
		return list;
	}

	public void submitWorkPlan(PcWorkPlanVo workPlan) {
		workPlan.setStatusId(1);
		pcWorkPlanDaoImpl.updateWorkPlan(PcWorkPlanVo.toPcWorkPlan(workPlan));
	}
	
	public Boolean deleteWorkPlan(Integer workPlanId) {
		try {
			pcWorkPlanDaoImpl.deleteWorkPlan(workPlanId);
			pcWorkPlanContentDaoImpl.deleteWorkPlanContentByWorkPlanId(workPlanId);
		}catch (Exception e) {
			return false;
		}
		return true;
	}	

	public PcWorkPlanContentVo getContentInfo(Integer workPlanId, Integer type) {
		PcWorkPlanContent content = pcWorkPlanContentDaoImpl.getContentByWorkPlanIdAndType(workPlanId, type);
		if (content == null) {
			return null;
		}
		return PcWorkPlanContentVo.fromPcWorkPlanContent(content);
	}

	public List<PcWorkPlanVo> getAlertInfo(Integer agencyId, Integer year,
			Integer quarter) {
		List<PcWorkPlanVo> list = new ArrayList<PcWorkPlanVo>();
		// Year work plan.
		PcWorkPlan yearWorkPlan = pcWorkPlanDaoImpl.getWorkPlanYearlyByAgencyId(agencyId, year);
		if (yearWorkPlan != null) {
			list.add(PcWorkPlanVo.fromPcWorkPlan(yearWorkPlan));
		} else {
			PcWorkPlanVo workPlanVo = new PcWorkPlanVo();
			workPlanVo.setTypeId(1);
			workPlanVo.setStatusId(0);
			list.add(workPlanVo);
		}
		// Quarter work plan.
		PcWorkPlan quarterWorkPlan = pcWorkPlanDaoImpl.getWorkPlanQuarterByAgencyId(agencyId, year, quarter);
		if (quarterWorkPlan != null) {
			list.add(PcWorkPlanVo.fromPcWorkPlan(quarterWorkPlan));
		} else {
			PcWorkPlanVo workPlanVo = new PcWorkPlanVo();
			workPlanVo.setTypeId(2);
			workPlanVo.setStatusId(0);
			list.add(workPlanVo);
		}
		// Quarter result.
		PcWorkPlan quarterResultWorkPlan = pcWorkPlanDaoImpl.getResultQuarterByAgencyId(agencyId, year, quarter);
		if (quarterResultWorkPlan != null) {
			list.add(PcWorkPlanVo.fromPcWorkPlan(quarterResultWorkPlan));
		} else {
			PcWorkPlanVo workPlanVo = new PcWorkPlanVo();
			workPlanVo.setTypeId(3);
			workPlanVo.setStatusId(0);
			list.add(workPlanVo);
		}
		// Year result.
		PcWorkPlan yearResultWorkPlan = pcWorkPlanDaoImpl.getWorkPlanYearlySummaryByAgencyId(agencyId, year);
		if (yearResultWorkPlan != null) {
			list.add(PcWorkPlanVo.fromPcWorkPlan(yearResultWorkPlan));
		} else {
			PcWorkPlanVo workPlanVo = new PcWorkPlanVo();
			workPlanVo.setTypeId(4);
			workPlanVo.setStatusId(0);
			list.add(workPlanVo);
		}
		return list;
	}
	
	
   private Configuration configuration = null;  
   public PcWorkPlanService() {  
      configuration = new Configuration();  
      configuration.setDefaultEncoding("utf-8");  
   }  
  
   @SuppressWarnings("deprecation")
   public String exportDoc(Integer workPlanId) {
	   

	   
	   try {
		   
		   PcWorkPlan workPlan = pcWorkPlanDaoImpl.getWorkPlanById(workPlanId);
		   Integer typeId = workPlan.getTypeId();		   
		   
		   String report_title = "";
		   switch(typeId) {
			   case 1:
				   report_title = workPlan.getYear() + "年度工作计划";
				   break;
			   case 2:
				   report_title = workPlan.getYear() + "年第"+ workPlan.getQuarter() +"工作计划及执行情况";
				   break;
			   case 3:
				   report_title = workPlan.getYear() + "年第"+ workPlan.getQuarter() +"工作计划及执行情况";
				   break;	
			   case 4:
				   report_title = workPlan.getYear() + "年度工作总结";
				   break;			   
		   }
		   
		   
		   Map dataMap = new HashMap();
		   SimpleDateFormat formatNowYear = new SimpleDateFormat("yyyy-MM-dd");
		   String str = null;
		   String content = null;
		   if (typeId == 1 || typeId == 4) {
			   
			   PcWorkPlanContentVo vo = this.getContentInfo(workPlanId, 1);
			   
			   str = vo.getContent();
			   content = richTextEditorToHtml.doRichTextEditorToHtml(str);
	//		   String content = "<P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P>";
			  
	
			   dataMap.put("report_title", report_title);
			   dataMap.put("report_content", content);
			   dataMap.put("report_name", vo.getMemberName());  
			   dataMap.put("report_date", formatNowYear.format(vo.getUpdatetime()));  
			   return this.createDoc(workPlanId, dataMap, "workplan.ftl");
		   } else {
			   int agencyId = workPlan.getAgencyId();
			   int y = workPlan.getYear();
			   int q = workPlan.getQuarter();
			   
			   dataMap.put("report_title", report_title);
			  			   
			   PcWorkPlan qp_workplan =  pcWorkPlanDaoImpl.getWorkPlanQuarterByTypeId(agencyId, y, q, 2);
			   if (qp_workplan != null) {
				   PcWorkPlanContentVo qpvo = this.getContentInfo(qp_workplan.getId(), 1);
				   
				   str = qpvo.getContent();
				   content = richTextEditorToHtml.doRichTextEditorToHtml(str);				   
				   dataMap.put("qp_content", content);
				   dataMap.put("qp_name", qpvo.getMemberName());  
				   dataMap.put("qp_date", formatNowYear.format(qpvo.getUpdatetime())); 				   
			   } else {
				   dataMap.put("qp_content", "");
				   dataMap.put("qp_name", "");  
				   dataMap.put("qp_date", ""); 
			   }
			   
			   PcWorkPlan qs_workplan =  pcWorkPlanDaoImpl.getWorkPlanQuarterByTypeId(agencyId, y, q, 3);
			   
			   if (qs_workplan != null) {
				   PcWorkPlanContentVo qsvo = this.getContentInfo(qs_workplan.getId(), 1);
				   
				   str = qsvo.getContent();
				   content = richTextEditorToHtml.doRichTextEditorToHtml(str);				   
				   dataMap.put("qs_content", content);
				   dataMap.put("qs_name", qsvo.getMemberName());  
				   dataMap.put("qs_date", formatNowYear.format(qsvo.getUpdatetime())); 	
				   
				   PcWorkPlanContentVo qevo = this.getContentInfo(qs_workplan.getId(), 3);
				   
				   if (qevo == null) {
					   dataMap.put("qe_content", "");
					   dataMap.put("qe_name", "");  
					   dataMap.put("qe_date", ""); 
				   } else {
					   str = qevo.getContent();
					   content = richTextEditorToHtml.doRichTextEditorToHtml(str);	
					   dataMap.put("qe_content", content);
					   dataMap.put("qe_name", qevo.getMemberName());  
					   dataMap.put("qe_date", formatNowYear.format(qevo.getUpdatetime())); 	
				   }
				   
				   
				   
			   } else {
				   dataMap.put("qs_content", "");
				   dataMap.put("qs_name", "");  
				   dataMap.put("qs_date", ""); 
				   dataMap.put("qe_content", "");
				   dataMap.put("qe_name", "");  
				   dataMap.put("qe_date", "");
			   }			   
			   
			   
			   return this.createDoc(workPlanId, dataMap, "quarterplan.ftl");
		   }

		   
		   
	   }catch(Exception $e) {
		   
	   }
	   
	   return "";
	   
   }
   
   public String createDoc(Integer workPlanId, Map dataMap, String template) {  
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
      String filename = "workplan_" + workPlanId + ".doc";
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
	
   
   public static void main(String args[]){

	   
	   PcWorkPlanService dh = new PcWorkPlanService();

	   
	   Map dataMap = new HashMap();

//	   String content = richTextEditorToHtml.doRichTextEditorToHtml(str);
	   String content = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">治安大队2012年工作计划</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\"></FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">2012年，治安大队要以党的十七届六中全会精神为指引，坚决贯彻市局、分局党委安排部署，紧密围绕“三项重点工作”和“三项建设”，以群众工作统领和统筹治安管理工作，全面加强队伍的思想建设、作风建设和业务能力建设，进一步提高对社会治安秩序的掌控能力，为“平安清河”建设出力，向建党九十周年献礼。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">一、坚持群众路线，树立为民思想，打造忠诚、有为公安队伍</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">（一）强化班子建设，注重人才培养。牢固树立科学发展理念，以“抓管理、带队伍、创业绩”思路为指导，全力推动支部班子自身能力建设，发挥支部班子的领导核心和战斗堡垒作用。工作中做到以身作则、率先垂范，用自身的行动影响和激励民警。针对单位年轻同志多，工作热情高的特点，充分利用此次领导干部竞聘选拔机会，努力营造争先创优、比学赶帮的良好氛围，为人才成长创造条件，推动队伍全面发展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">（二）加强宗旨教育、树立为民思想。要以党的群众路线教育为切入点，在分局党委领导下深入开展“大走访”开门评警、“听呼声、走百家、送服务”等为民实践活动，牢固树立宗旨意识、服务意识。工作中，从关系到群众利益的小事抓起，在队伍思想上解决认识问题，在工作上解决方法问题，在与群众接触上解决态度问题。做到带着感情、责任、微笑去工作，从小事上赢得大民心，真正树立起公安机关为民、爱民良好形象。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">（三）进一步加强队伍作风建设。大力弘扬“忠诚、为民、公正、廉洁”的首都人民警察核心价值观，引导民警正确看待各类社会现象和社会问题。注重纪律作风的日常养成，在队伍中树立细节决定成败的理念。从工作细节抓起，从日常工作中不规范的地方改起，在队伍中进一步形成“严深细实”的工作作风，打造一支作风严谨、雷厉风行的公安队伍，坚决杜绝洒汤漏水现象发生。  </FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">（四）以人为本，积极倡导“严管厚爱”理念。积极贯彻分局党委提出的“严管厚爱”的管理理念，用警示教育中鲜活的事例为教材，把“严是爱，松是害”落实到队伍建设上来。把严管体现在过程中，把厚爱体现在结果上，使大家真正理解严管、厚爱的辩证关系，实现从被动接受管理到从严要求自己的根本性转变。积极争取分局和相关单位的支持，进一步改善民警工作和生活条件，丰富民警的业余生活，大力营造栓心留人的良好环境，将领导的关心、组织的关怀落到实处。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"宋体\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"0\">（五）丰富民警文体生活，创建和谐警营。根据远离都市，民警业余生活单调枯燥，长此以往容易使民警士气消沉，影响队伍战斗力的情况，大队将立足于现有条件，通过积极组织乒乓球、羽毛球、篮球、棋牌等文体活动，丰富民警业余文化生活，缓解民警思想和工作压力。要通过开座谈会交流、私下谈心等方式了解民警思想动态，关心和帮助民警解决工作、生活中的困难，切实做到爱警、知警、暖警，努力营造团结、紧张、严肃、活泼、奋发有为的警营文化氛围。</FONT></P></TEXTFORMAT>";
	   content = richTextEditorToHtml.doRichTextEditorToHtml(content);
	   dataMap.put("report_year", "2012");
	   dataMap.put("report_content", content);
	   dataMap.put("report_name", "test");  
	   dataMap.put("report_date", "dddd");  	   
	   String filename1 = dh.createDoc(23, dataMap, "workplan.ftl");	   
   }   
	
}
