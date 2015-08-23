package com.common.utils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.model.FieldsDocumentPart;
import org.apache.poi.hwpf.usermodel.Field;
import org.apache.poi.hwpf.usermodel.Fields;
import org.apache.poi.hwpf.usermodel.Range;

public class PoiDemo {

	public void writeDoc(Map<String, String> map) {
		try {
			//读取word模板

			FileInputStream in = new FileInputStream(new File("c:\\YQ\\workplan.doc"));
			HWPFDocument hdt = new HWPFDocument(in);
			Fields fields = hdt.getFields();
			Iterator<Field> it = fields.getFields(FieldsDocumentPart.MAIN).iterator();
//			while(it.hasNext()){
//				System.out.println(it.next().getType());
//			}
			
			//读取word文本内容
			Range range = hdt.getRange();
			System.out.println(range.text());
			//替换文本内容
			for (Map.Entry<String,String> entry:map.entrySet()) {
				range.replaceText(entry.getKey(),entry.getValue());
				
			}    
			ByteArrayOutputStream ostream = new ByteArrayOutputStream();
			String fileName = ""+System.currentTimeMillis();
			fileName += ".doc";
			FileOutputStream out = new FileOutputStream("c:\\YQ\\"+fileName,true);
			hdt.write(ostream);
            //输出字节流
			out.write(ostream.toByteArray());
			out.close();
			ostream.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String stripHtml(String content) { 
		// <p>段落替换为换行 
		content = content.replaceAll("<P .*?>", "\r\n"); 
		// <br><br/>替换为换行 
		content = content.replaceAll("<br\\s*/?>", "\r\n"); 
		// 去掉其它的<>之间的东西 
		content = content.replaceAll("\\<.*?>", ""); 
		// 还原HTML 
		// content = HTMLDecoder.decode(content); 
		return content; 
	}   
	
	
	public static void main(String[] args){
		PoiDemo rawDoc = new PoiDemo();
		Map<String, String> map=new HashMap<String, String>();
		
		
		String str = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P></TEXTFORMAT>";
		System.out.println(str);
		str = stripHtml(str);
		System.out.println(str);
		map.put("${wp_title}", 	  "2012");
		map.put("${wp_content}",  str);
		map.put("${wp_reported}", "man1");
		map.put("${wp_date}", 	  "2012年1月20日");
		map.put("${py_content}",  "评语评语");
		map.put("${py_obj}", 	  "政治部党委");
		map.put("${py_date}", 	  "2012年1月21日");
		map.put("${pj_content}",  "好");
		map.put("${pj_obj}", 	  "政治部党委");
		map.put("${pj_date}", 	  "2012年1月22日");		
		
		rawDoc.writeDoc(map);
	}

}
