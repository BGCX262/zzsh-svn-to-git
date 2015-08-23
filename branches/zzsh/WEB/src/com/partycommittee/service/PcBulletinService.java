package com.partycommittee.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.demo.richTextEditorToHtml;
import com.partycommittee.persistence.daoimpl.PcBulletinDaoImpl;
import com.partycommittee.persistence.po.PcAgency;
import com.partycommittee.persistence.po.PcAgencyRelation;
import com.partycommittee.persistence.po.PcBulletin;
import com.partycommittee.persistence.po.PcRemindLock;
import com.partycommittee.persistence.po.PcWorkPlan;
import com.partycommittee.remote.vo.PcAgencyVo;
import com.partycommittee.remote.vo.PcBulletinVo;
import com.partycommittee.remote.vo.PcRemindLockVo;
import com.partycommittee.remote.vo.PcWorkPlanContentVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

import freemarker.template.Configuration;
import freemarker.template.Template;


@Transactional
@Service("PcBulletinService")
public class PcBulletinService {

	@Resource(name="PcBulletinDaoImpl")
	private PcBulletinDaoImpl pcBulletinDaoImpl;
	public void setPcBulletinDaoImpl(PcBulletinDaoImpl pcBulletinDaoImpl) {
		this.pcBulletinDaoImpl = pcBulletinDaoImpl;
	}

	public PageResultVo<PcBulletinVo> getBulletins(PageHelperVo page) {
		
		PageResultVo<PcBulletinVo> result = new PageResultVo<PcBulletinVo>();
		List<PcBulletinVo> list = new ArrayList<PcBulletinVo>();
		PageResultVo<PcBulletin> pageResult =  pcBulletinDaoImpl.getBulletins(page);
		if (pageResult == null) {
			return null;
		}
		result.setPageHelper(pageResult.getPageHelper());
		if (pageResult.getList() != null && pageResult.getList().size() > 0) {
			for (PcBulletin item : pageResult.getList()) {
				list.add(PcBulletinVo.fromPcBulletin(item));
			}
		}
		result.setList(list);
		return result;
	}
	
	public PcBulletinVo getBulletin(int bId) {

		PcBulletin pevo = pcBulletinDaoImpl.getBulletin(bId);
		PcBulletinVo vo = PcBulletinVo.fromPcBulletin(pevo);
		return vo;
	}	
	

	public void createBulletin(PcBulletinVo pevo) {
		if (pevo.getIsIndex() == 1) {
			setIsIndex();
		}
		pcBulletinDaoImpl.createBulletin(pevo.toPcBulletin(pevo));
		
		if (pevo.getIsIndex() == 1) {
			savetoNotice(pevo);
		}
		
	}
	
	public void updateBulletin(PcBulletinVo pevo) {
		if (pevo.getIsIndex() == 1) {
			setIsIndex();
		}		
		PcBulletin vo = PcBulletinVo.toPcBulletin(pevo);
		pcBulletinDaoImpl.upateBulletin(vo);
		if (pevo.getIsIndex() == 1) {
			savetoNotice(pevo);
		}		
	}
	
	public void setIsIndex() {
		pcBulletinDaoImpl.setIsIndex();
	}
	
	public void deleteBulletin(Integer bId) {
		
		pcBulletinDaoImpl.deleteBulletinById(bId);
	}	
	
   private Configuration configuration = null;  
   public PcBulletinService() {  
      configuration = new Configuration();  
      configuration.setDefaultEncoding("utf-8");  
   }  
  
   
   public String savetoNotice(PcBulletinVo pevo) {  
      // 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，   
      // 这里我们的模板是放在/com/ybhy/word包下面   
      configuration.setClassForTemplateLoading(this.getClass(),  
            "/com/partycommittee/service/templates");  
      configuration.setEncoding(Locale.CHINA, "UTF-8");
      Template t = null;  
      Map dataMap = new HashMap();
      try {  
         // test.ftl为要装载的模板   
    	
		   
			String title = pevo.getTitle();
			String str = pevo.getContent();
			String content = richTextEditorToHtml.doRichTextEditorToHtml(str);	   
		   
		   
		   dataMap.put("title", title);
		   dataMap.put("content", content);
    	  
    	  
    	 t = configuration.getTemplate("notice.ftl");
         t.setEncoding("UTF-8");  
      } catch (IOException e) {  
         e.printStackTrace();  
      }  
      // 输出文档路径及名称   
      String path =System.getProperty("zzsh.root") + "/login/";
      String filename = "notice.htm";
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
