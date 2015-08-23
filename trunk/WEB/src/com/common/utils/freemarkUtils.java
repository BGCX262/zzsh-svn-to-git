package com.common.utils;

import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import org.docx4j.Docx4jProperties;

import com.common.demo.freemarkDemo;
import com.common.demo.richTextEditorToHtml;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class freemarkUtils {
	
	private Configuration configuration = null;  	
	
   public freemarkUtils() {
	      configuration = new Configuration();  
	      configuration.setDefaultEncoding("utf-8");  
   }
   
   public byte[] createDoc(String template, Map dataMap) {  
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

	      Writer out = null;
	      ByteArrayOutputStream ostream = null;
	      OutputStreamWriter otstream = null;	      
	      try {  
	 
	    	 ostream = new ByteArrayOutputStream();
	    	 otstream = new OutputStreamWriter(ostream, "UTF-8");
	    	 out = new BufferedWriter(otstream);
	    	 
	         t.process(dataMap, out);
	         
//	         otstream.close();
//	         ostream.close();
//	         out.close(); 
	         return ostream.toByteArray();
	      } catch (Exception e1) {  
	         e1.printStackTrace();  
	      }  finally {
	            if (ostream != null) {
	                try {
	                	ostream.close();
	                } catch (IOException e1) {
	                    e1.printStackTrace();
	                }
	            }
	            
	            if (otstream != null) {
	                try {
	                	otstream.close();
	                } catch (IOException e1) {
	                    e1.printStackTrace();
	                }	            	
	            }
	            
	            if (out != null) {
	                try {
	                	out.close();
	                } catch (IOException e1) {
	                    e1.printStackTrace();
	                }	            	
	            }	            
	            
	            
	      }
	      
	      return null;
	   } 	


	public static void saveToFile(String fileName, byte[] content) {
		
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(fileName, true);
			
	        fos.write(content);  
	        fos.close();  
						
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
	}      
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

		// TODO Auto-generated method stub
		freemarkUtils f = new freemarkUtils();
		
		String filename = "C:\\YQ\\out.docx";
		String outName = "C:\\YQ\\out.docx";		
		
		Properties properties = Docx4jProperties.getProperties();
		properties.setProperty("docx4j.PageOrientationLandscape", "false");
		//封面============================================================================
		Map<String, String> map_index = new HashMap<String, String>();
		map_index.put("g_year", "2012");
		map_index.put("dw_name", "北京市公安局");
		map_index.put("zb_name", "北京市公安局政治部");
		byte[] out_index = f.createDoc("index.htm", map_index);
		f.saveToFile(filename, out_index);
		
		//基本情况========================================================================
		Map<String, String> map_base = new HashMap<String, String>();
		map_base.put("zb_name", "北京市公安局政治部");
		map_base.put("gx_date", "2012-11-21");
		map_base.put("dxz_num", "5");
		map_base.put("zb_num", "10");
		map_base.put("zbsj", "支部书记");
		map_base.put("zbfsj", "支部副书记");
		map_base.put("zzwy", "组织委员");
		map_base.put("jjwy", "纪检委员");
		map_base.put("xcwy", "宣传委员");
		map_base.put("qnwy", "青年委员");
		map_base.put("ghwy", "工会委员");
		map_base.put("fnwy", "妇女委员");
		map_base.put("bmwy", "保密委员");
		
		byte[] out_base = f.createDoc("zb-base.htm", map_base);
		f.saveToFile(filename, out_base);
		

		//党支部委员花名册========================================================================	
		Map<String,Object> data_map_members_wy=new HashMap<String,Object>();    

		List<Map<String,Object>> list_members_wy = new ArrayList<Map<String,Object>>();    
		Map<String,Object> map_members_wy = new HashMap<String,Object>();   
		
		map_members_wy.put("duty_name",  "书记");									//党内职务
		map_members_wy.put("name",  "李广岐");   									//姓名
		map_members_wy.put("sex_name",  "男性");										//性别
		map_members_wy.put("nation_name",  "汉族");									//民族
		map_members_wy.put("birthday", "1963年06月22日");							//出生年月
		map_members_wy.put("age", "49");											//年龄
		map_members_wy.put("work_day", "1983年06月02日");							//参加工作时间
		map_members_wy.put("join_day", "1987年06月22日");							//入党时间
		map_members_wy.put("edu_name",  "中央党校研究生");							//文化程度
		map_members_wy.put("postday",  "1989年07月22日");							//任党内职务时间
		list_members_wy.add(map_members_wy);
		data_map_members_wy.put("members", list_members_wy);	

      byte[] out_members_wy = f.createDoc("members-wy.htm", data_map_members_wy);
      f.saveToFile(filename, out_members_wy);
		
		
        //年度计划==============================================================================
        Map<String, String> map_yp = new HashMap<String, String>();
		String str = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P></TEXTFORMAT>";

		str = richTextEditorToHtml.doRichTextEditorToHtml(str);
		map_yp.put("wp_title", 	  "2012");
		map_yp.put("wp_content",  str);
		map_yp.put("wp_reported", "man1");
		map_yp.put("wp_date", 	  "2012年1月20日");
		map_yp.put("py_content",  "评语评语");
		map_yp.put("py_obj", 	  "政治部党委");
		map_yp.put("py_date", 	  "2012年1月21日");
		map_yp.put("pj_content",  "好");
		map_yp.put("pj_obj", 	  "政治部党委");
		map_yp.put("pj_date", 	  "2012年1月22日");	
		
        byte[] out_wp = f.createDoc("workplan.htm", map_yp);
        f.saveToFile(filename, out_wp);
        
        //会议类==============================================================================
        Map<String, String> map_mt = new HashMap<String, String>();
		
		map_mt.put("mt_title", 	  "2012");
		map_mt.put("mt_time",  "2012-01-10");
		map_mt.put("mt_mod", "test");
		map_mt.put("mt_theme", 	  "党徽党徽党徽当回荡阿斯顿发生大幅");
		map_mt.put("mt_attend",  "10");
		map_mt.put("mt_asence",  "2");
		map_mt.put("mt_asencems",  "张三，李四");
		map_mt.put("mt_content",  str);
		map_mt.put("mt_reported", "man1");
		map_mt.put("mt_date", 	  "2012年1月20日");
		map_mt.put("py_content",  "评语评语");
		map_mt.put("py_obj", 	  "政治部党委");
		map_mt.put("py_date", 	  "2012年1月21日");
		map_mt.put("pj_content",  "好");
		map_mt.put("pj_obj", 	  "政治部党委");
		map_mt.put("pj_date", 	  "2012年1月22日");	
		
        byte[] out_mt = f.createDoc("meeting.htm", map_mt);
        f.saveToFile(filename, out_mt);    
        
        //其他会议类==============================================================================
        Map<String, String> map_ot = new HashMap<String, String>();
		
        map_ot.put("mt_title", 	  "党徽党徽党徽当回荡阿斯顿发生大幅党徽党徽党徽当回荡阿斯顿发生大幅");
        map_ot.put("mt_time",  "2012-01-10");
        map_ot.put("mt_mod", "test");
        map_ot.put("mt_theme", 	  "党徽党徽党徽当回荡阿斯顿发生大幅");
        map_ot.put("mt_attend",  "10");
        map_ot.put("mt_asence",  "2");
        map_ot.put("mt_asencems",  "张三，李四");
		map_ot.put("mt_content",  str);
		map_ot.put("mt_reported", "man1");
		map_ot.put("mt_date", 	  "2012年1月20日");
		map_ot.put("py_content",  "评语评语");
		map_ot.put("py_obj", 	  "政治部党委");
		map_ot.put("py_date", 	  "2012年1月21日");
		map_ot.put("pj_content",  "好");
		map_ot.put("pj_obj", 	  "政治部党委");
		map_ot.put("pj_date", 	  "2012年1月22日");	
		
        byte[] out_ot = f.createDoc("meeting-other.htm", map_ot);
        f.saveToFile(filename, out_ot);
        

		//最后在进行htmltoDoc转换
		byte[] content = ReadFromFile.getBytes(filename);
		HtmlToDoc.doHtmlToDoc(content, outName);	
                
        properties.setProperty("docx4j.PageOrientationLandscape", "true");
        
		filename = "C:\\YQ\\out-table.docx";
		outName = "C:\\YQ\\out-table.docx";	        
        
		//党员花名册========================================================================	
		Map<String,Object> data_map_members=new HashMap<String,Object>();    

		List<Map<String,Object>> list_members = new ArrayList<Map<String,Object>>();    
		Map<String,Object> map_members = new HashMap<String,Object>();   
		
		map_members.put("no", 1);                               				//序号
		map_members.put("name",  "李广岐");   									//姓名
		map_members.put("sex_name",  "男性");									//性别
		map_members.put("nation_name",  "汉族");									//民族
		map_members.put("birthday", "1963年06月22日");							//出生年月
		map_members.put("age", "49");											//年龄
		map_members.put("birth_place", "北京市西城区");							//籍贯
		map_members.put("work_day", "1983年06月02日");							//参加工作时间
		map_members.put("join_day", "1987年06月22日");							//入党时间
		map_members.put("edu_name",  "中央党校研究生");							//文化程度
		map_members.put("duty_name",  "书记");									//党内职务		        
		map_members.put("admin_duty",  "北京市公安局办公室副主任兼秘书处处长");	//行政职务
		list_members.add(map_members);
		data_map_members.put("members", list_members);	
        
        byte[] out_members = f.createDoc("members.htm", data_map_members);
        f.saveToFile(filename, out_members);        
		

//        properties.setProperty("docx4j.PageOrientationLandscape", "false");
		//最后在进行htmltoDoc转换
		byte[] content_table = ReadFromFile.getBytes(filename);
		HtmlToDoc.doHtmlToDoc(content_table, outName);	
		
	}

}
