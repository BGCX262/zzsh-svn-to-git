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
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Service;

import com.common.utils.DateUtils;
import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcAgencyStatsDaoImpl;
import com.partycommittee.persistence.daoimpl.PcRemindConfigDaoImpl;
import com.partycommittee.persistence.daoimpl.PcStatsDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyRelation;
import com.partycommittee.persistence.po.PcAgencyStats;
import com.partycommittee.persistence.po.PcRemindConfig;
import com.partycommittee.persistence.po.PcStats;
import com.partycommittee.remote.vo.PcAgencyStatsVo;
import com.partycommittee.remote.vo.PcMeetingZBStatsVo;
import com.partycommittee.remote.vo.PcWorkPlanZBStatsVo;
import com.partycommittee.remote.vo.PcStatsVo;

import freemarker.template.Configuration;
import freemarker.template.Template;



@Service("PcStatService")
public class PcStatService {

	@Resource(name="PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;
	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}	
	
	@Resource(name="PcAgencyStatsDaoImpl")
	private PcAgencyStatsDaoImpl pcAgencyStatsDaoImpl;
	public void setPcStatDaoImpl(PcAgencyStatsDaoImpl pcAgencyStatsDaoImpl) {
		this.pcAgencyStatsDaoImpl = pcAgencyStatsDaoImpl;
	}
	
	@Resource(name="PcStatsDaoImpl")
	private PcStatsDaoImpl pcStatsDaoImpl;
	public void setPcStatsDaoImpl(PcStatsDaoImpl pcStatsDaoImpl) {
		this.pcStatsDaoImpl = pcStatsDaoImpl;
	}	
	
	@Resource(name="PcRemindConfigDaoImpl")
	private PcRemindConfigDaoImpl pcRemindConfigDaoImpl;
	public void setPcRemindLockDaoImpl(PcRemindConfigDaoImpl pcRemindConfigDaoImpl) {
		this.pcRemindConfigDaoImpl = pcRemindConfigDaoImpl;
	}	
	
	public List<PcAgencyStatsVo> getAgencyStatsByParentId(Integer id, Integer year, Integer endM) {
		List<PcAgencyStatsVo> list = new ArrayList<PcAgencyStatsVo>();

		List<PcAgencyStats> list_admin = new ArrayList<PcAgencyStats>();
		PcAgency agency =  pcAgencyDaoImpl.getAgencyById(id);
		if (id == 1) {
			list_admin = pcAgencyStatsDaoImpl.getAgencyStatsByAdmin(id, year, endM);
		} else {
			list_admin = pcAgencyStatsDaoImpl.getAgencyStatsByCode(agency.getCode(), agency.getCodeId(), year, endM);
		}
		
		for (PcAgencyStats item : list_admin) {
			item.setAgencyId(id);
			item.setCode(agency.getCode());
			item.setCodeId(agency.getCodeId());
			item.setName(agency.getName());
			item.setParentId(agency.getParentId());
			list.add(PcAgencyStatsVo.fromPcAgencyStats(item));
		}			
		
		List<PcAgency> relationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agency.getCode());
		
		for (PcAgency vo : relationList) {
			
			List<PcAgencyStats> list_child = pcAgencyStatsDaoImpl.getAgencyStatsByCode(vo.getCode(), vo.getCodeId(), year, endM);

			for (PcAgencyStats item : list_child) {
				item.setAgencyId(vo.getId());
				item.setCode(vo.getCode());
				item.setCodeId(vo.getCodeId());
				item.setName(vo.getName());
				item.setParentId(vo.getParentId());				
				list.add(PcAgencyStatsVo.fromPcAgencyStats(item));
			}	
		}			

		return list;
	}	

	public List<PcStatsVo> getWorkPlanStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		
		
		// 年度计划
		List<PcStatsVo> yp_list = getYPWorkPlanStatsById(id, year, startM, endM);
		
		for(PcStatsVo item : yp_list) {
			list.add(item);
		}	
		
		// 季度计划
		List<PcStatsVo> qp_list = getQuarterStatsById(id, year, 2, startM, endM);
		for(PcStatsVo item : qp_list) {
			list.add(item);
		}		
		
		// 季度执行情况
		List<PcStatsVo> qs_list = getQuarterStatsById(id, year, 3, startM, endM);
		for(PcStatsVo item : qs_list) {
			list.add(item);
		}			
		
		// 年终总结
		List<PcStatsVo> ys_list = getYSWorkPlanStatsById(id, year, startM, endM);
		
		for(PcStatsVo item : ys_list) {
			list.add(item);
		}			
		
		return list;
	}
	
	public List<PcStatsVo> getMeetingStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		try {
			
			for (Integer i = 5; i < 8; i++) {
				List<PcStatsVo> meeting_list = getQuarterStatsById(id, year, i, startM, endM);
				
				for(PcStatsVo item : meeting_list) {
					list.add(item);
				}						
				
			}
			
			for (Integer i = 8; i <= 9; i++) {
				List<PcStatsVo> meeting_list = getMonthStatsById(id, year, i, startM, endM);
				
				for(PcStatsVo item : meeting_list) {
					list.add(item);
				}						
				
			}			
	
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}	
	
	public List<PcStatsVo> getZbStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		try {
			List<Integer> qs = new ArrayList<Integer>() ;
			
			for(Integer i = startM; i <= endM; i++) {
				if (  qs.indexOf(getQuarter(i)) == -1 ){
					qs.add(getQuarter(i));
				}
			}
			
			Integer i = 1;
	
			for(i = 1; i <= 9; i++) {
				List<Integer> qs_tmp = new ArrayList<Integer>() ;
				if (i == 1 || i == 4) {
					qs_tmp.add(0);
				} else {
					qs_tmp = qs;
				}
				
				if (i >= 8) {
					List<PcStatsVo> list_zwh = pcStatsDaoImpl.getZwhStatsById(id, year, i, startM, endM);
					for(PcStatsVo item : list_zwh) {
						list.add(item);
					}
				} else {
					List<PcStatsVo> list_admin = pcStatsDaoImpl.getStatsById(id, year, qs_tmp, i);
					for(PcStatsVo item : list_admin) {
						list.add(item);
					}					
				}

			}
						
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}	
	
	public List<PcStatsVo> getYPWorkPlanStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		PcRemindConfig remind_config;
		PcAgency agencyVo =  pcAgencyDaoImpl.getAgencyById(id);
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agencyVo.getCode());
		
		if (agencyRelationList == null || agencyRelationList.size() == 0) {
			return null;
		}			
		try {
			
			
			//-------------------------- 年度计划 开始-----------------------------------------------------
				remind_config = pcRemindConfigDaoImpl.getRemindConfigByTypeId(1);
				
				List<PcStatsVo> yp_list_admin = new ArrayList<PcStatsVo>();
				
				yp_list_admin = pcStatsDaoImpl.getYStatsById(id, year, 1, remind_config);
				
				for(PcStatsVo item : yp_list_admin) {
					list.add(item);
				}			
					

				for (PcAgency agency : agencyRelationList) {
//					Date create_datetime = agency.getCreateDatetime();
//					if (create_datetime.getMonth() <= endM) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getYStatsById(agency.getId(), year, 1, remind_config);
						for(PcStatsVo item : list_admin) {
							list.add(item);
						}				
//					}
				}
			
			//-------------------------- 年度计划 结束-----------------------------------------------------
			
			

			
		} catch (Exception e) {
			
		}
		return list;
	}	
	
	public List<PcStatsVo> getYSWorkPlanStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		PcRemindConfig remind_config;
		
		PcAgency agencyVo =  pcAgencyDaoImpl.getAgencyById(id);
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agencyVo.getCode());
		
		if (agencyRelationList == null || agencyRelationList.size() == 0) {
			return null;
		}			
		try {
			
			
			//-------------------------- 年终总结 开始-----------------------------------------------------
			if (endM == 12) {
				remind_config = pcRemindConfigDaoImpl.getRemindConfigByTypeId(4);
				
				List<PcStatsVo> ys_list_admin = new ArrayList<PcStatsVo>();
				
				ys_list_admin = pcStatsDaoImpl.getYStatsById(id, year, 4, remind_config);

				for(PcStatsVo item : ys_list_admin) {
					list.add(item);
				}			
				
				for (PcAgency agency : agencyRelationList) {
					
					Date create_datetime = agency.getCreateDatetime();
//					if (create_datetime.getMonth() <= endM) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getYStatsById(agency.getId(), year, 4, remind_config);
						for(PcStatsVo item : list_admin) {
							list.add(item);
						}			
//					}
				}			
			}
			//-------------------------- 年终总结 结束-----------------------------------------------------
			
			
		} catch (Exception e) {
			
		}
		return list;
	}		
	
	// 季度相关的
	public List<PcStatsVo> getQuarterStatsById(Integer id, Integer year, Integer typeId, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		PcRemindConfig remind_config;
		PcAgency agencyVo =  pcAgencyDaoImpl.getAgencyById(id);
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agencyVo.getCode());
		
		if (agencyRelationList == null || agencyRelationList.size() == 0) {
			return null;
		}			
		try {
			
			List<Integer> qs = new ArrayList<Integer>() ;
			

			for(Integer i = startM; i <= endM; i++) {
				
				if (typeId == 3) {
					if ( i == 3 ||  i == 6 ||  i == 9 ||  i == 12) {
						qs.add( i/3);
					}				
				} else {				
					if (  qs.indexOf(getQuarter(i)) == -1 ){
						qs.add(getQuarter(i));
					}
				}
			}			
			remind_config = pcRemindConfigDaoImpl.getRemindConfigByTypeId(typeId);
			//-------------------------- 季度 开始-----------------------------------------------------
				List<PcStatsVo> ys_list_admin = new ArrayList<PcStatsVo>();
				ys_list_admin = pcStatsDaoImpl.getQStatsById(id, year, qs, typeId, remind_config);
				for(PcStatsVo item : ys_list_admin) {
					list.add(item);
				}			
//				
				for (PcAgency agency : agencyRelationList) {
					Date create_datetime = agency.getCreateDatetime();
					if (qs.size() > 0) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getQStatsById(agency.getId(), year, qs, typeId, remind_config);
						for(PcStatsVo item : list_admin) {
							list.add(item);
						}		
					}
				}
			//-------------------------- 季度 结束-----------------------------------------------------

		} catch (Exception e) {
			
		}

		return list;
	}		
	
	// 季度相关的
	@SuppressWarnings("deprecation")
	public List<PcStatsVo> getMonthStatsById(Integer id, Integer year, Integer typeId, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		PcRemindConfig remind_config;
		PcAgency agencyVo =  pcAgencyDaoImpl.getAgencyById(id);
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenAgencyByCode(agencyVo.getCode());
		
		if (agencyRelationList == null || agencyRelationList.size() == 0) {
			return null;
		}			
		try {
			
			//-------------------------- 季度 开始-----------------------------------------------------
				List<PcStatsVo> ys_list_admin = new ArrayList<PcStatsVo>();
				ys_list_admin = pcStatsDaoImpl.getMStatsById(id, year, startM, endM, typeId);
				for(PcStatsVo item : ys_list_admin) {
					list.add(item);
				}			
//				
				for (PcAgency agency : agencyRelationList) {
					Date create_datetime = agency.getCreateDatetime();
//					if (create_datetime.getMonth() <= endM) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getMStatsById(agency.getId(), year, startM, endM, typeId);
						for(PcStatsVo item : list_admin) {
							list.add(item);
						}		
//					}
				}
			//-------------------------- 季度 结束-----------------------------------------------------

		} catch (Exception e) {
			
		}

		return list;
	}			
		
	public Integer getQuarter(Integer month) {
		
		if (month <= 3) {
			return 1;
		} else if (month <= 6) {
			return 2;
		} else if (month <= 9) {
			return 3;
		} else {
			return 4;
		}
	}
	
	public String getWorkPlanZBStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		
		PcAgency agency = pcAgencyDaoImpl.getAgencyById(id);
		
		List<Integer> qs = new ArrayList<Integer>() ;
		for(Integer i = startM; i <= endM; i++) {
			
			if (startM == 1 || endM == 12) {
				if (  qs.indexOf(0) == -1 ){
					qs.add(0);
				}
			}
			
			if (  qs.indexOf(getQuarter(i)) == -1 ){
				qs.add(getQuarter(i));
			}
		}			

		//写入excel模板
		try{
			
			String tpl_path = System.getProperty("zzsh.root") +"/templates/pt-workplan-stat.xls"; 
		
			Workbook wb = Workbook.getWorkbook(new File(tpl_path));
			
			String tmp_path =System.getProperty("zzsh.root") + "/tmp/";
		    String filename = "pt_workplan_" + DateUtils.formatDate(new Date()) + ".xls";
		    
		    File targetFile = new File(tmp_path + filename); 
		    
//		    ByteArrayOutputStream targetFile = new ByteArrayOutputStream(); 
		    
		    WritableWorkbook wwb = Workbook.createWorkbook(targetFile, wb); 

			
			WritableSheet wws = wwb.getSheet(0);

			Integer num = 1;
			Integer x = 0;
			Integer y = 5; 
			
			//年度计划
			List<PcWorkPlanZBStatsVo> yp_stats = pcStatsDaoImpl.getWorkPlanZBStatsByYear(agency, year, endM, 1);
			
			for(PcWorkPlanZBStatsVo item : yp_stats) {
				
				if (item.getName() == null || item.getName() == "") continue;
				
				Label A = new Label(0, y, num.toString());
				wws.addCell(A);
				
				Label B = new Label(1, y, item.getP_name());
				wws.addCell(B);
				
				Label C = new Label(2, y, item.getDw_name());
				wws.addCell(C);
				
				Label D = new Label(3, y, item.getEj_or_dzz_name());
				wws.addCell(D);				
				
				Label E = new Label(4, y, item.getName());
				wws.addCell(E);
				
				Label F = new Label(5, y, item.getSetup_datetime().substring(0, 10));
				wws.addCell(F);
				
				//年度计划
				Label G = new Label(6, y, item.getReported_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(7, y, item.getAgency_goodjob().toString());
				wws.addCell(H);
				
				Label I = new Label(8, y, item.getReturn_rate().toString());
				wws.addCell(I);
				
				Label J = new Label(9, y, item.getDelay_rate().toString());
				wws.addCell(J);
				
				Label K = new Label(10, y, item.getEva_rate().toString());
				wws.addCell(K);
				
				Label L = new Label(11, y, item.getEva_1_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(12, y, item.getEva_2_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(13, y, item.getEva_3_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(14, y, item.getEva_4_rate().toString());
				wws.addCell(O);			

				y++;
				num++;
			}
			
			//季度类
			x = 15;
			Integer xx = x;
			for (int i = 2; i < 4; i++) {
				y = 5;
				if (i > 2) {
					x = x + 9;
				}
				List<PcWorkPlanZBStatsVo> q_stats = pcStatsDaoImpl.getWorkPlanZBStatsByQuarter(agency, year, qs, endM, i);
				
				for(PcWorkPlanZBStatsVo item : q_stats) {					
					xx = x;
					Label G = new Label(xx++, y, item.getReported_rate().toString());
					wws.addCell(G);
					
					Label H = new Label(xx++, y, item.getAgency_goodjob().toString());
					wws.addCell(H);
					
					Label I = new Label(xx++, y, item.getReturn_rate().toString());
					wws.addCell(I);
					
					Label J = new Label(xx++, y, item.getDelay_rate().toString());
					wws.addCell(J);
					
					Label K = new Label(xx++, y, item.getEva_rate().toString());
					wws.addCell(K);
					
					Label L = new Label(xx++, y, item.getEva_1_rate().toString());
					wws.addCell(L);
					
					Label M = new Label(xx++, y, item.getEva_2_rate().toString());
					wws.addCell(M);
					
					Label N = new Label(xx++, y, item.getEva_3_rate().toString());
					wws.addCell(N);
					
					Label O = new Label(xx++, y, item.getEva_4_rate().toString());
					wws.addCell(O);			

					y++;
				}				
			}
			
			//年终总结
			y = 5;
			List<PcWorkPlanZBStatsVo> ys_stats = pcStatsDaoImpl.getWorkPlanZBStatsByYear(agency, year, endM, 4);
			
			for(PcWorkPlanZBStatsVo item : ys_stats) {
				xx = x + 9;
				Label G = new Label(xx++, y, item.getReported_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(xx++, y, item.getAgency_goodjob().toString());
				wws.addCell(H);
				
				Label I = new Label(xx++, y, item.getReturn_rate().toString());
				wws.addCell(I);
				
				Label J = new Label(xx++, y, item.getDelay_rate().toString());
				wws.addCell(J);
				
				Label K = new Label(xx++, y, item.getEva_rate().toString());
				wws.addCell(K);
				
				Label L = new Label(xx++, y, item.getEva_1_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(xx++, y, item.getEva_2_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(xx++, y, item.getEva_3_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(xx++, y, item.getEva_4_rate().toString());
				wws.addCell(O);			

				y++;
			}			
			
			wwb.write();
			
		
			wwb.close(); 
			wb.close(); 				
			
			return filename;
//			return targetFile.toByteArray();
		}catch(Exception e){
		      System.out.println(e);
		}
		return null;

	}	
	
	public String getMeetingZBStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		
		PcAgency agency = pcAgencyDaoImpl.getAgencyById(id);
		
		List<Integer> qs = new ArrayList<Integer>() ;
		for(Integer i = startM; i <= endM; i++) {				
			if (  qs.indexOf(getQuarter(i)) == -1 ){
				qs.add(getQuarter(i));
			}
		}			

		List<PcStatsVo> list = new ArrayList<PcStatsVo>();		
		
		//写入excel模板
		try{
			
			String tpl_path = System.getProperty("zzsh.root") +"/templates/pt-meeting-stat.xls"; 
		
			Workbook wb = Workbook.getWorkbook(new File(tpl_path));
			
			String tmp_path = System.getProperty("zzsh.root") + "/tmp/";
		    String filename =  "pt_meeting_" + DateUtils.formatDate(new Date()) + ".xls";
		    
		    File targetFile = new File(tmp_path + filename); 
		    		    
		    WritableWorkbook wwb = Workbook.createWorkbook(targetFile, wb);
			WritableSheet wws = wwb.getSheet(0);

			Integer num = 1;
			Integer x = 0;
			Integer y = 5; 
			
			
			//支委会
			List<PcMeetingZBStatsVo> zwh_stats = pcStatsDaoImpl.getMeetingZBStatsByMonth(agency, year, startM, endM, 8);
			for(PcMeetingZBStatsVo item : zwh_stats) {
				
				if (item.getName() == null || item.getName() == "") continue;
				Label A = new Label(0, y, num.toString());
				wws.addCell(A);
				
				Label B = new Label(1, y, item.getP_name());
				wws.addCell(B);
				
				Label C = new Label(2, y, item.getDw_name());
				wws.addCell(C);
				
				Label D = new Label(3, y, item.getEj_or_dzz_name());
				wws.addCell(D);
				
				Label E = new Label(4, y, item.getName());
				wws.addCell(E);
				
				Label F = new Label(5, y, item.getSetup_datetime().substring(0, 10));
				wws.addCell(F);
				
				//支委会
				Label G = new Label(6, y, item.getAttend_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(7, y, item.getReported_rate().toString());
				wws.addCell(H);
				
				Label I = new Label(8, y, item.getTotal().toString());
				wws.addCell(I);
				
				Label J = new Label(9, y, item.getTotal_return().toString());
				wws.addCell(J);
				
				Label K = new Label(10, y, item.getTotal_delay().toString());
				wws.addCell(K);
				
				Label L = new Label(11, y, item.getEva_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(12, y, item.getEva_1_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(13, y, item.getEva_2_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(14, y, item.getEva_3_rate().toString());
				wws.addCell(O);
				
				Label P = new Label(15, y, item.getEva_4_rate().toString());
				wws.addCell(P);
								
				y++;
				num++;
			}		
			
			//党员大会
			y = 5;
			x = 16;
			int xx = x;			
			List<PcMeetingZBStatsVo> dydh_stats = pcStatsDaoImpl.getMeetingZBStatsByQuarter(agency, year, qs, endM, 6);
			for(PcMeetingZBStatsVo item : dydh_stats) {
				xx = x;
				//支委会
				Label G = new Label(xx++, y, item.getAttend_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(xx++, y, item.getReported_rate().toString());
				wws.addCell(H);
				
				Label I = new Label(xx++, y, item.getTotal().toString());
				wws.addCell(I);
				
				Label J = new Label(xx++, y, item.getTotal_return().toString());
				wws.addCell(J);
				
				Label K = new Label(xx++, y, item.getTotal_delay().toString());
				wws.addCell(K);
				
				Label L = new Label(xx++, y, item.getEva_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(xx++, y, item.getEva_1_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(xx++, y, item.getEva_2_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(xx++, y, item.getEva_3_rate().toString());
				wws.addCell(O);
				
				Label P = new Label(xx++, y, item.getEva_4_rate().toString());
				wws.addCell(P);
								
				y++;
			}
			
			//民主生活会
			y = 5;
			x = x + 10;		
			List<PcMeetingZBStatsVo> mzshh_stats = pcStatsDaoImpl.getMeetingZBStatsByQuarter(agency, year, qs, endM, 7);
			for(PcMeetingZBStatsVo item : mzshh_stats) {
				xx = x;
				Label G = new Label(xx++, y, item.getAttend_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(xx++, y, item.getReported_rate().toString());
				wws.addCell(H);
				
				Label I = new Label(xx++, y, item.getTotal().toString());
				wws.addCell(I);
				
				Label J = new Label(xx++, y, item.getTotal_return().toString());
				wws.addCell(J);
				
				Label K = new Label(xx++, y, item.getTotal_delay().toString());
				wws.addCell(K);
				
				Label L = new Label(xx++, y, item.getEva_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(xx++, y, item.getEva_1_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(xx++, y, item.getEva_2_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(xx++, y, item.getEva_3_rate().toString());
				wws.addCell(O);
				
				Label P = new Label(xx++, y, item.getEva_4_rate().toString());
				wws.addCell(P);
								
				y++;
			}
			
			//党课
			y = 5;
			x = x + 10;		
			List<PcMeetingZBStatsVo> dk_stats = pcStatsDaoImpl.getMeetingZBStatsByQuarter(agency, year, qs, endM, 5);
			for(PcMeetingZBStatsVo item : dk_stats) {
				xx = x;
				Label G = new Label(xx++, y, item.getAttend_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(xx++, y, item.getReported_rate().toString());
				wws.addCell(H);
				
				Label I = new Label(xx++, y, item.getTotal().toString());
				wws.addCell(I);
				
				Label J = new Label(xx++, y, item.getTotal_return().toString());
				wws.addCell(J);
				
				Label K = new Label(xx++, y, item.getTotal_delay().toString());
				wws.addCell(K);
				
				Label L = new Label(xx++, y, item.getEva_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(xx++, y, item.getEva_1_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(xx++, y, item.getEva_2_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(xx++, y, item.getEva_3_rate().toString());
				wws.addCell(O);
				
				Label P = new Label(xx++, y, item.getEva_4_rate().toString());
				wws.addCell(P);
								
				y++;
			}			
			
			
			y = 5;
			x = x + 10;
			List<PcMeetingZBStatsVo> qt_stats = pcStatsDaoImpl.getMeetingZBStatsByMonth(agency, year, startM, endM, 9);
			for(PcMeetingZBStatsVo item : qt_stats) {
				xx = x;				
				//其他会议
				Label G = new Label(xx++, y, item.getAttend_rate().toString());
				wws.addCell(G);
				
//				Label H = new Label(xx++, y, item.getReported_rate().toString());
//				wws.addCell(H);
				
				Label I = new Label(xx++, y, item.getTotal().toString());
				wws.addCell(I);
				
				Label J = new Label(xx++, y, item.getTotal_return().toString());
				wws.addCell(J);
				
				Label K = new Label(xx++, y, item.getTotal_delay().toString());
				wws.addCell(K);
				
				Label L = new Label(xx++, y, item.getEva_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(xx++, y, item.getEva_1_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(xx++, y, item.getEva_2_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(xx++, y, item.getEva_3_rate().toString());
				wws.addCell(O);
				
				Label P = new Label(xx++, y, item.getEva_4_rate().toString());
				wws.addCell(P);
								
				y++;
				num++;
			}				
			
			
			wwb.write();
			
		
			wwb.close(); 
			wb.close(); 				
			
//			System.out.print(filename);
			return filename;
			
		}catch(Exception e){
		      System.out.println(e);
		}
		return null;
	}	
	
}
