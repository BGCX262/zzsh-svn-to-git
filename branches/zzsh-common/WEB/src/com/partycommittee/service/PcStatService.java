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
	
	public List<PcAgencyStatsVo> getAgencyStatsByParentId(Integer id) {
		List<PcAgencyStatsVo> list = new ArrayList<PcAgencyStatsVo>();
		
		if (id == 1) {
			List<PcAgencyStats> list_admin = pcAgencyStatsDaoImpl.getAgencyStatsById(id);
			for (PcAgencyStats item : list_admin) {
				list.add(PcAgencyStatsVo.fromPcAgencyStats(item));
			}		
			
			List<PcAgencyStats> list_child = pcAgencyStatsDaoImpl.getAgencyStatsByParentId(id);
			for (PcAgencyStats item : list_child) {
				list.add(PcAgencyStatsVo.fromPcAgencyStats(item));
			}			
		} else {
			List<PcAgencyStats> y = pcAgencyStatsDaoImpl.getAgencyStatsByParentCode(id);
			for (PcAgencyStats item : y) {
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
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(id);
		
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
					Date create_datetime = agency.getCreateDatetime();
					if (create_datetime.getMonth() <= endM) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getYStatsById(agency.getId(), year, 1, remind_config);
						for(PcStatsVo item : list_admin) {
							list.add(item);
						}				
					}
				}
			
			//-------------------------- 年度计划 结束-----------------------------------------------------
			
			

			
		} catch (Exception e) {
			
		}
		return list;
	}	
	
	public List<PcStatsVo> getYSWorkPlanStatsById(Integer id, Integer year, Integer startM, Integer endM) {
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();
		PcRemindConfig remind_config;
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(id);
		
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
					if (create_datetime.getMonth() <= endM) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getYStatsById(agency.getId(), year, 4, remind_config);
						for(PcStatsVo item : list_admin) {
							list.add(item);
						}			
					}
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
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(id);
		
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
					if (create_datetime.getMonth() <= endM) {
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
		List<PcAgency> agencyRelationList = pcAgencyDaoImpl.getChildrenByParentId(id);
		
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
					if (create_datetime.getMonth() <= endM) {
						List<PcStatsVo> list_admin = pcStatsDaoImpl.getMStatsById(agency.getId(), year, startM, endM, typeId);
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
			
		List<PcWorkPlanZBStatsVo> zb_stats = pcStatsDaoImpl.getWorkPlanZBStatsById(id, year, qs, endM);
		
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
//			Label A1 = (Label)wws.getWritableCell(0,4);
//			A1.setString("1");
//			wws.addCell(A1);
			
//			Label A1 = new Label(0, 4, "1234");
//			wws.addCell(A1);
			Integer num = 1;
			Integer x = 0;
			Integer y = 5; 
//		    System.out.println(zb_stats.size());
			for(PcWorkPlanZBStatsVo item : zb_stats) {
				if (item.getName() == null || item.getName() == "") continue;
//				System.out.println(num.toString());
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
				Label G = new Label(6, y, item.getYp_reported_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(7, y, item.getYp_agency_goodjob().toString());
				wws.addCell(H);
				
				Label I = new Label(8, y, item.getYp_return_rate().toString());
				wws.addCell(I);
				
				Label J = new Label(9, y, item.getYp_delay_rate().toString());
				wws.addCell(J);
				
				Label K = new Label(10, y, item.getYp_eva_rate().toString());
				wws.addCell(K);
				
				Label L = new Label(11, y, item.getYp_eva_1_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(12, y, item.getYp_eva_2_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(13, y, item.getYp_eva_3_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(14, y, item.getYp_eva_4_rate().toString());
				wws.addCell(O);			
				
				//季度计划
				Label P = new Label(15, y, item.getQp_reported_rate().toString());
				wws.addCell(P);
				
				Label Q = new Label(16, y, item.getQp_agency_goodjob().toString());
				wws.addCell(Q);
				
				Label R = new Label(17, y, item.getQp_return_rate().toString());
				wws.addCell(R);
				
				Label S = new Label(18, y, item.getQp_delay_rate().toString());
				wws.addCell(S);				
				
				Label T = new Label(19, y, item.getQp_eva_rate().toString());
				wws.addCell(T);
				
				Label U = new Label(20, y, item.getQp_eva_1_rate().toString());
				wws.addCell(U);
				
				Label V = new Label(21, y, item.getQp_eva_2_rate().toString());
				wws.addCell(V);
				
				Label W = new Label(22, y, item.getQp_eva_3_rate().toString());
				wws.addCell(W);
				
				Label X = new Label(23, y, item.getQp_eva_4_rate().toString());
				wws.addCell(X);	
				
				//季度执行情况
				Label Y = new Label(24, y, item.getQs_reported_rate().toString());
				wws.addCell(Y);
				
				Label Z = new Label(25, y, item.getQs_agency_goodjob().toString());
				wws.addCell(Z);
				
				Label AA = new Label(26, y, item.getQs_return_rate().toString());
				wws.addCell(AA);
				
				Label AB = new Label(27, y, item.getQs_delay_rate().toString());
				wws.addCell(AB);						
				
				Label AC = new Label(28, y, item.getQs_eva_rate().toString());
				wws.addCell(AC);
				
				Label AD = new Label(29, y, item.getQs_eva_1_rate().toString());
				wws.addCell(AD);
				
				Label AE = new Label(30, y, item.getQs_eva_2_rate().toString());
				wws.addCell(AE);
				
				Label AF = new Label(31, y, item.getQs_eva_3_rate().toString());
				wws.addCell(AF);
				
				Label AG = new Label(32, y, item.getQs_eva_4_rate().toString());
				wws.addCell(AG);		
				
				//年终总结
				Label AH = new Label(33, y, item.getYs_reported_rate().toString());
				wws.addCell(AH);
				
				Label AI = new Label(34, y, item.getYs_agency_goodjob().toString());
				wws.addCell(AI);
				
				Label AJ = new Label(35, y, item.getYs_return_rate().toString());
				wws.addCell(AJ);
				
				Label AK = new Label(36, y, item.getYs_return_rate().toString());
				wws.addCell(AK);				
				
				Label AL = new Label(37, y, item.getYs_eva_rate().toString());
				wws.addCell(AL);
				
				Label AM = new Label(38, y, item.getYs_eva_1_rate().toString());
				wws.addCell(AM);
				
				Label AN = new Label(39, y, item.getYs_eva_2_rate().toString());
				wws.addCell(AN);
				
				Label AO = new Label(40, y, item.getYs_eva_3_rate().toString());
				wws.addCell(AO);
				
				Label AP = new Label(41, y, item.getYs_eva_4_rate().toString());
				wws.addCell(AP);				
				

				y++;
				num++;
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
		
		List<Integer> qs = new ArrayList<Integer>() ;
		for(Integer i = startM; i <= endM; i++) {				
			if (  qs.indexOf(getQuarter(i)) == -1 ){
				qs.add(getQuarter(i));
			}
		}			
		
		List<PcStatsVo> list = new ArrayList<PcStatsVo>();		
		List<PcMeetingZBStatsVo> zb_stats = pcStatsDaoImpl.getMeetingZBStatsById(id, year, qs, endM);
		
		//写入excel模板
		try{
			
			String tpl_path = System.getProperty("zzsh.root") +"/templates/pt-meeting-stat.xls"; 
		
			Workbook wb = Workbook.getWorkbook(new File(tpl_path));
			
			String tmp_path = System.getProperty("zzsh.root") + "/tmp/";
		    String filename =  "pt_meeting_" + DateUtils.formatDate(new Date()) + ".xls";
		    
		    File targetFile = new File(tmp_path + filename); 
		    
//		    ByteArrayOutputStream targetFile = new ByteArrayOutputStream(); 
		    
		    WritableWorkbook wwb = Workbook.createWorkbook(targetFile, wb); 

			
			WritableSheet wws = wwb.getSheet(0);
//			Label A1 = (Label)wws.getWritableCell(0,4);
//			A1.setString("1");
//			wws.addCell(A1);
			
//			Label A1 = new Label(0, 4, "1234");
//			wws.addCell(A1);
			Integer num = 1;
			Integer x = 0;
			Integer y = 5; 
//		    System.out.println(zb_stats.size());
			for(PcMeetingZBStatsVo item : zb_stats) {
				
				if (item.getName() == null || item.getName() == "") continue;
//				System.out.println(num.toString());
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
				Label G = new Label(6, y, item.getZwh_attend_rate().toString());
				wws.addCell(G);
				
				Label H = new Label(7, y, item.getZwh_reported_rate().toString());
				wws.addCell(H);
				
				Label I = new Label(8, y, item.getZwh_total().toString());
				wws.addCell(I);
				
				Label J = new Label(9, y, item.getZwh_total_return().toString());
				wws.addCell(J);
				
				Label K = new Label(10, y, item.getZwh_total_delay().toString());
				wws.addCell(K);
				
				Label L = new Label(11, y, item.getZwh_eva_rate().toString());
				wws.addCell(L);
				
				Label M = new Label(12, y, item.getZwh_eva_1_rate().toString());
				wws.addCell(M);
				
				Label N = new Label(13, y, item.getZwh_eva_2_rate().toString());
				wws.addCell(N);
				
				Label O = new Label(14, y, item.getZwh_eva_3_rate().toString());
				wws.addCell(O);
				
				Label P = new Label(15, y, item.getZwh_eva_4_rate().toString());
				wws.addCell(P);
				
				//党员大会
				Label Q = new Label(16, y, item.getDydh_attend_rate().toString());
				wws.addCell(Q);
				
				Label R = new Label(17, y, item.getDydh_reported_rate().toString());
				wws.addCell(R);
				
				Label S = new Label(18, y, item.getDydh_total().toString());
				wws.addCell(S);
				
				Label T = new Label(19, y, item.getDydh_total_return().toString());
				wws.addCell(T);
				
				Label U = new Label(20, y, item.getDydh_total_delay().toString());
				wws.addCell(U);
				
				Label V = new Label(21, y, item.getDydh_eva_rate().toString());
				wws.addCell(V);
				
				Label W = new Label(22, y, item.getDydh_eva_1_rate().toString());
				wws.addCell(W);
				
				Label X = new Label(23, y, item.getDydh_eva_2_rate().toString());
				wws.addCell(X);
				
				Label Y = new Label(24, y, item.getDydh_eva_3_rate().toString());
				wws.addCell(Y);
				
				Label Z = new Label(25, y, item.getDydh_eva_4_rate().toString());
				wws.addCell(Z);
				
				//民主生活会
				Label AA = new Label(26, y, item.getMzshh_attend_rate().toString());
				wws.addCell(AA);
				
				Label AB = new Label(27, y, item.getMzshh_reported_rate().toString());
				wws.addCell(AB);
				
				Label AC = new Label(28, y, item.getMzshh_total().toString());
				wws.addCell(AC);
				
				Label AD = new Label(29, y, item.getMzshh_total_return().toString());
				wws.addCell(AD);
				
				Label AE = new Label(30, y, item.getMzshh_total_delay().toString());
				wws.addCell(AE);
				
				Label AF = new Label(31, y, item.getMzshh_eva_rate().toString());
				wws.addCell(AF);
				
				Label AG = new Label(32, y, item.getMzshh_eva_1_rate().toString());
				wws.addCell(AG);
				
				Label AH = new Label(33, y, item.getMzshh_eva_2_rate().toString());
				wws.addCell(AH);
				
				Label AI = new Label(34, y, item.getMzshh_eva_3_rate().toString());
				wws.addCell(AI);
				
				Label AJ = new Label(35, y, item.getMzshh_eva_4_rate().toString());
				wws.addCell(AJ);
				
				//党课
				Label AK = new Label(36, y, item.getDk_attend_rate().toString());
				wws.addCell(AK);
				
				Label AL = new Label(37, y, item.getDk_reported_rate().toString());
				wws.addCell(AL);
				
				Label AM = new Label(38, y, item.getDk_total().toString());
				wws.addCell(AM);
				
				Label AN = new Label(39, y, item.getDk_total_return().toString());
				wws.addCell(AN);
				
				Label AO = new Label(40, y, item.getDk_total_delay().toString());
				wws.addCell(AO);
				
				Label AP = new Label(41, y, item.getDk_eva_rate().toString());
				wws.addCell(AP);
				
				Label AQ = new Label(42, y, item.getDk_eva_1_rate().toString());
				wws.addCell(AQ);
				
				Label AR = new Label(43, y, item.getDk_eva_2_rate().toString());
				wws.addCell(AR);
				
				Label AS = new Label(44, y, item.getDk_eva_3_rate().toString());
				wws.addCell(AS);
				
				Label AT = new Label(45, y, item.getDk_eva_4_rate().toString());
				wws.addCell(AT);
				
				//其他
				Label AU = new Label(46, y, item.getQt_attend_rate().toString());
				wws.addCell(AU);

				
				Label AV = new Label(47, y, item.getQt_total().toString());
				wws.addCell(AV);
				
				Label AW = new Label(48, y, item.getQt_total_return().toString());
				wws.addCell(AW);
				
				Label AX = new Label(49, y, item.getQt_total_delay().toString());
				wws.addCell(AX);
				
				Label AY = new Label(50, y, item.getQt_eva_rate().toString());
				wws.addCell(AY);
				
				Label AZ = new Label(51, y, item.getQt_eva_1_rate().toString());
				wws.addCell(AZ);
				
				Label BA = new Label(52, y, item.getQt_eva_2_rate().toString());
				wws.addCell(BA);
				
				Label BB = new Label(53, y, item.getQt_eva_3_rate().toString());
				wws.addCell(BB);
				
				Label BC = new Label(54, y, item.getQt_eva_4_rate().toString());
				wws.addCell(BC);				
				
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
