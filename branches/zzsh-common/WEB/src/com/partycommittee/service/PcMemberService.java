package com.partycommittee.service;

import java.io.File; 
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.persistence.daoimpl.PcAgencyDaoImpl;
import com.partycommittee.persistence.daoimpl.PcDutyCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcEduCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcMemberDaoImpl;
import com.partycommittee.persistence.daoimpl.PcNationCodeDaoImpl;
import com.partycommittee.persistence.daoimpl.PcSexCodeDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcDutyCode;
import com.partycommittee.persistence.po.PcEduCode;
import com.partycommittee.persistence.po.PcMember;
import com.partycommittee.persistence.po.PcNationCode;
import com.partycommittee.persistence.po.PcRole;
import com.partycommittee.persistence.po.PcSexCode;
import com.partycommittee.remote.vo.PcDutyCodeVo;
import com.partycommittee.remote.vo.PcMemberVo;
import com.partycommittee.remote.vo.PcRoleVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

import jxl.*;
import jxl.write.*; 
@Transactional
@Service("PcMemberService")
public class PcMemberService {

	@Resource(name="PcMemberDaoImpl")
	private PcMemberDaoImpl pcMemberDaoImpl;
	public void setPcMemberDaoImpl(PcMemberDaoImpl pcMemberDaoImpl) {
		this.pcMemberDaoImpl = pcMemberDaoImpl;
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
	
	@Resource(name="PcAgencyDaoImpl")
	private PcAgencyDaoImpl pcAgencyDaoImpl;
	public void setPcAgencyDaoImpl(PcAgencyDaoImpl pcAgencyDaoImpl) {
		this.pcAgencyDaoImpl = pcAgencyDaoImpl;
	}	
		
	public List<PcMemberVo> getMemberListByAgencyId(int agencyId) {
		List<PcMemberVo> list = new ArrayList<PcMemberVo>();
		List<PcMember> memberList = pcMemberDaoImpl.getMemberListByAgencyId(agencyId);
		if (memberList != null && memberList.size() > 0) {
			for (PcMember member : memberList) {
				list.add(PcMemberVo.fromPcMember(member));
			}
		}
		return list;
	}
	
	public PageResultVo<PcMemberVo> getMemberListPageByAgencyId(int agencyId, PageHelperVo page) {
		PageResultVo<PcMemberVo> result = new PageResultVo<PcMemberVo>();
		List<PcMemberVo> list = new ArrayList<PcMemberVo>();
		PageResultVo<PcMember> pageResult = pcMemberDaoImpl.getMemberListPageByAgencyId(agencyId, page);
		if (pageResult == null) {
			return null;
		}
		result.setPageHelper(pageResult.getPageHelper());
		if (pageResult.getList() != null && pageResult.getList().size() > 0) {
			for (PcMember member : pageResult.getList()) {
				list.add(PcMemberVo.fromPcMember(member));
			}
		}
		result.setList(list);
		return result;
	}
	
	public void createMember(PcMemberVo memberVo) {
		PcMember member = PcMemberVo.toPcMember(memberVo);
		memberHandler(member);
		pcMemberDaoImpl.createPcMember(member);
	}
	
	public void deleteMember(PcMemberVo memberVo) {
		PcMember member = PcMemberVo.toPcMember(memberVo);
		memberHandler(member);
		pcMemberDaoImpl.deletePcMember(member);
	}
	
	private void memberHandler(PcMember member) {
		if (member.getDutyId() == 0) {
			member.setDutyId(null);
		}
		if (member.getEduId() == 0) {
			member.setEduId(null);
		}
		if (member.getNationId() == 0) {
			member.setNationId(null);
		}
		if (member.getSexId() == 0) {
			member.setSexId(null);
		}
	}
	
	public void updateMember(PcMemberVo memberVo) {
		PcMember member = PcMemberVo.toPcMember(memberVo);
		pcMemberDaoImpl.updatePcMember(member);
	}
	
	public List<PcDutyCodeVo> getDutyCodeList() {
		List<PcDutyCodeVo> list = new ArrayList<PcDutyCodeVo>();
		List<PcDutyCode> roleList = pcDutyCodeDaoImpl.getDutyList();
		if (roleList != null && roleList.size() > 0) {
			for (PcDutyCode item : roleList) {
				list.add(PcDutyCodeVo.fromPcRole(item));
			}
		}
		return list;
	}	
	
	
	public String exportToexcel(int agencyId) {
		// 输出文档路径及名称   
	    String path =System.getProperty("zzsh.root") + "/tmp/";
	    String filename = "members_" + agencyId + ".xls";
//		System.out.println(path + filename);
	    try{
	        //创建一个可写入的excel文件对象
	        WritableWorkbook workbook = Workbook.createWorkbook(new File(path + filename)); 
	        
	        WritableSheet sheet = workbook.createSheet("支委委员", 0); 
	        //表头                      列，行，内容
	        
	        List<PcDutyCode> dutyList = pcDutyCodeDaoImpl.getDutyList();
	        List<PcNationCode> nationList = pcNationCodeDaoImpl.getNationList();
	        List<PcSexCode> sexList = pcSexCodeDaoImpl.getSexList();
	        List<PcEduCode> eduList = pcEduCodeDaoImpl.getEduList();	        
	        
	        jxl.write.DateFormat df = new jxl.write.DateFormat("yyyy-dd-MM"); 
	        jxl.write.WritableCellFormat wcfDF = new jxl.write.WritableCellFormat(df); 	      	        
	        jxl.write.WritableFont wf = new jxl.write.WritableFont(WritableFont.ARIAL, 14, WritableFont.BOLD, false); 
	        jxl.write.WritableCellFormat wcfF = new jxl.write.WritableCellFormat(wf); 
	        
	        int index_x_col = 0;
	        Integer index_y_col = 0;
	        
	        List<Integer> agencyIds = new ArrayList();
	        // 先判断上级关系
	        PcAgency agency = pcAgencyDaoImpl.getAgencyById(agencyId);
	        if (agency.getCodeId() == 10) {
	        	agencyIds.add(agency.getId());
	        } else {
	        	List<PcAgency> lists = pcAgencyDaoImpl.getChildrenLeafAgencyByCode(agency.getCode());
	        	for(PcAgency item : lists) {
	        		agencyIds.add(item.getId());
	        	}
	        }
	        
	        
	        List<Object> hl = new ArrayList();
	        int[] column_attr_width = new int[]{ 8, 15, 15, 8, 10, 15, 15, 15, 15, 40, 15, 20, 20, 20, 20};
	        String[] columns = new String[]{ "序号","姓名", "党内职务", "性别", "民族", "出生年月", "籍贯", "参加工作时间", "文化程度", "行政职务", "入党时间", "任党内职务时间", "现在家庭住址", "支部名称", "所属上级"}; 
	        for(int   i=0;i <columns.length;i++){ 	        	  
	        	 Label head_label = new Label(i, 0, columns[i], wcfF); 
	        	 sheet.addCell(head_label); 
	        	 sheet.setColumnView(i, column_attr_width[i]);
	        } 
	        

	        index_y_col = 1;
	        
	        
	        for(int   i=0;i < agencyIds.size();i++){
	        	
	        	
	        	//获取支部上级名称.
	        	PcAgency agency_tmp = pcAgencyDaoImpl.getAgencyById(agencyIds.get(i));
	        	String tmp_code = agency_tmp.getCode();

	        	List<String> parentNames = new ArrayList();
	        	parentNames.add(agency_tmp.getName());
	        	while(tmp_code.length() > 2) {
	        		tmp_code = tmp_code.substring(0,  tmp_code.length() -2 );
	        		PcAgency agency_parent = pcAgencyDaoImpl.getAgencyByCode(tmp_code);
	        		if (agency_parent == null) continue;
			        parentNames.add(agency_parent.getName());
	        	}
	        	
		        List<PcMember> memberList = pcMemberDaoImpl.getMemberListByAgencyId(agencyIds.get(i));    
		        if (memberList != null && memberList.size() > 0) {
					for (PcMember member : memberList) {
						
						//序号
				        Label label = new Label(0, index_y_col, index_y_col.toString()); 
				        sheet.addCell(label); 						
						
						//姓名
				        Label label0 = new Label(1, index_y_col, member.getName()); 
				        sheet.addCell(label0); 
				        
				        
				        //党内职务
				        String dutyName = "";
				        for (PcDutyCode item : dutyList) {
							if (member.getDutyId().equals(item.getId())) {
								dutyName = item.getDescription();
								break;
							}
						}
				        Label label1= new Label(2, index_y_col, dutyName); 
				        sheet.addCell(label1); 
				        
				        //性别
				        String sexName = "";
				        for (PcSexCode item : sexList) {
							if (member.getSexId() != null && member.getSexId().equals(item.getId())) {
								sexName = item.getDescription();
								break;
							}
						}			        
				        Label label2 = new Label(3, index_y_col, sexName); 
				        sheet.addCell(label2); 
				        
				        
				        //民族
				        String nationName = "";
				        for (PcNationCode item : nationList) {
							if (member.getNationId() != null &&  member.getNationId().equals(item.getId())) {
								nationName = item.getDescription();
								break;
							}
						}
				        
				        Label label3 = new Label(4, index_y_col, nationName); 
				        sheet.addCell(label3); 
	
				        if (member.getBirthday() != null) {
					        jxl.write.DateTime label4 = new jxl.write.DateTime(5, index_y_col, member.getBirthday(), wcfDF); 
					        sheet.addCell(label4); 
				        } else {
				        	 Label label4 = new Label(5, index_y_col, ""); 
				        	 sheet.addCell(label4); 
				        }
				        
				        Label label5 = new Label(6, index_y_col, member.getBirthPlace()); 
				        sheet.addCell(label5); 
				        
				        if (member.getWorkday() != null) {
					        jxl.write.DateTime label6 = new jxl.write.DateTime(7, index_y_col, member.getWorkday(), wcfDF); 
					        sheet.addCell(label6); 
				        } else {
				        	 Label label6 = new Label(7, index_y_col, ""); 
				        	 sheet.addCell(label6); 			        	
				        }
				        
				        //文化程度
				        String eduName = "";
				        for (PcEduCode item : eduList) {
							if (member.getEduId() != null && member.getEduId().equals(item.getId())) {
								eduName = item.getDescription();
								break;
							}
						}				        
				        Label label7 = new Label(8, index_y_col, eduName); 
				        sheet.addCell(label7); 
				        
				        Label label8 = new Label(9, index_y_col, member.getAdminDuty()); 
				        sheet.addCell(label8); 
				        
				        if (member.getJoinday() != null) {
					        jxl.write.DateTime label9 = new jxl.write.DateTime(10, index_y_col, member.getJoinday(), wcfDF); 
					        sheet.addCell(label9); 
				        } else {
				        	 Label label9 = new Label(10, index_y_col, ""); 
				        	 sheet.addCell(label9); 			        	
				        }	
				        
				        if (member.getPostday() != null) {
					        jxl.write.DateTime label10 = new jxl.write.DateTime(11, index_y_col, member.getPostday(), wcfDF); 
					        sheet.addCell(label10); 
				        } else {
				        	 Label label10 = new Label(11, index_y_col, ""); 
				        	 sheet.addCell(label10); 			        	
				        }				        
	
				        
				        Label label10 = new Label(12, index_y_col, member.getAddress()); 
				        sheet.addCell(label10); 
				        
				        index_x_col = 13;
				        for(int j = 0; j < parentNames.size(); j++) {
				        	Label label_p = new Label(index_x_col, index_y_col, parentNames.get(j));
				        	sheet.addCell(label_p); 
				        	sheet.setColumnView(index_x_col, 20);
				        	index_x_col++;
				        }
				        
				        index_y_col++;
					}
		        }
			}
	        
//	        //格式化日期
//	        jxl.write.DateFormat df = new jxl.write.DateFormat("yyyy-dd-MM hh:mm:ss"); 
//	        jxl.write.WritableCellFormat wcfDF = new jxl.write.WritableCellFormat(df); 
//	        jxl.write.DateTime labelDTF = new jxl.write.DateTime(0, 1, new java.util.Date(), wcfDF); 
//	        sheet.addCell(labelDTF);
//	        //普通字符
//	        Label labelCFC = new Label(1, 1, "riverwind"); 
//	        sheet.addCell(labelCFC); 
//	         //格式化数字
//	        jxl.write.NumberFormat nf = new jxl.write.NumberFormat("#.##"); 
//	        WritableCellFormat wcfN = new WritableCellFormat(nf); 
//	        jxl.write.Number labelNF = new jxl.write.Number(2, 1, 13.1415926, wcfN); 
//	        sheet.addCell(labelNF); 
//	        
//	         
//	        jxl.write.Number labelNNF = new jxl.write.Number(3, 1, 10.50001, wcfN); 
//	        sheet.addCell(labelNNF); 
	        //关闭对象，释放资源
	        workbook.write(); 
	        workbook.close();
	
	    }catch(Exception e){
	      System.out.println(e);
	    }	    
	    
	    return filename;
		
	}
}
