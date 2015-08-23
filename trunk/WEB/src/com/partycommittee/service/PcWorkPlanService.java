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
				
				Calendar cal = Calendar.getInstance();
				content.setUpdatetime(cal.getTime());						
				
				pcWorkPlanContentDaoImpl.upateContent(PcWorkPlanContentVo.toPcWorkPlanContent(content));
			}
		}
	}
	
	public void updateWorkPlan(PcWorkPlanVo workPlan) {
		pcWorkPlanDaoImpl.updateWorkPlan(PcWorkPlanVo.toPcWorkPlan(workPlan));
		if (workPlan.getWorkPlanContent() != null) {
			PcWorkPlanContentVo contentVo = workPlan.getWorkPlanContent();

			Calendar cal = Calendar.getInstance();
			contentVo.setUpdatetime(cal.getTime());		
			
			pcWorkPlanContentDaoImpl.upateContent(PcWorkPlanContentVo.toPcWorkPlanContent(contentVo));
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
//		if (contentType == 2) {
//			Calendar cal = Calendar.getInstance();
//			 cal.add(Calendar.DATE,7);//把当前系统的日期加7天
//			 contentVo.setUpdatetime(cal.getTime());
//		}
		
		Calendar cal = Calendar.getInstance();
		contentVo.setUpdatetime(cal.getTime());		
		
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
	
}
