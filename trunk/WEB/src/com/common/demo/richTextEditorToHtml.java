package com.common.demo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.xml.sax.SAXException;



import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.*;

public  class richTextEditorToHtml {
	
	public static String doRichTextEditorToHtml(String str) {
		try {
//			str = new String(str.getBytes("GBK"), "UTF-8");
			str = str.replaceAll("<TEXTFORMAT LEADING=\"2\">", "");
			str = str.replaceAll("</TEXTFORMAT>", "");
			str = "<root>" + str + "</root>";
            SAXReader saxReader = new SAXReader();
            saxReader.setEncoding("UTF-8");
            ByteArrayInputStream input = new ByteArrayInputStream(str.getBytes("UTF-8"));
           
            InputStreamReader strInStream = new InputStreamReader(input, "UTF-8");
            Document document = saxReader.read(input);   
            Element root = document.getRootElement();
           
            String getXMLEncoding   =   document.getXMLEncoding();
            String rootname   =   root.getName();
//             System.out.println("getXMLEncoding>>>"   +   getXMLEncoding   +   ",rootname>>>"   +   rootname);               
            
             for ( Iterator iter = root.elementIterator(); iter.hasNext(); ) {
                 Element element = (Element) iter.next();
                 
                 // 获取person节点的Algin属性的值
                 Attribute alignAttr=element.attribute("ALIGN");
                 if(alignAttr != null){
                	 String align = alignAttr.getValue();
                	 if (align != null&&!align.equals("")) {
                		 element.addAttribute(" STYLE", "text-align: " + alignAttr.getValue());
                		 element.remove(alignAttr);
                	 } 
                 }
                 
                 for ( Iterator iterInner = element.elementIterator(); iterInner.hasNext(); ) {
                     Element elementInner = (Element) iterInner.next();
                 
                 
	                 Attribute faceAttr=elementInner.attribute("FACE");
	                 if(faceAttr != null){
	                	 String align = faceAttr.getValue();
	                	 if (faceAttr != null&&!faceAttr.equals("")) {
	                		 elementInner.remove(faceAttr);
	                	 } 
	                 }
	                 
	                 Attribute sizeAttr=elementInner.attribute("SIZE");
	                 if(sizeAttr != null){
	                	 String align = sizeAttr.getValue();
	                	 if (sizeAttr != null&&!sizeAttr.equals("")) {
	                		 elementInner.remove(sizeAttr);
	                	 } 
	                 }	    
	                 
	                 Attribute colorAttr=elementInner.attribute("COLOR");
	                 if(colorAttr != null){
	                	 String align = colorAttr.getValue();
	                	 if (colorAttr != null&&!colorAttr.equals("")) {
//	                		 elementInner.addAttribute(" STYLE", "color:  " + colorAttr.getValue());
	                		 elementInner.remove(colorAttr);
	                	 } 
	                 }	
	                 
	                 Attribute letterAttr=elementInner.attribute("LETTERSPACING");
	                 if(letterAttr != null){
	                	 String align = letterAttr.getValue();
	                	 if (letterAttr != null&&!letterAttr.equals("")) {
//	                		 elementInner.addAttribute(" STYLE", "letter-spacing: " + letterAttr.getValue()+ "px; ");
	                		 elementInner.remove(letterAttr);
	                	 } 
	                 }	
	                 
	                 Attribute kerAttr=elementInner.attribute("KERNING");
	                 if(kerAttr != null){
	                	 String align = kerAttr.getValue();
	                	 if (kerAttr != null&&!kerAttr.equals("")) {

	                		 
	                		 elementInner.remove(kerAttr);
	                	 } 
	                 }	         
	                 
	                 
	                 elementInner.addAttribute(" STYLE", "font-family: " + faceAttr.getValue() +  "; color:  " + colorAttr.getValue()
	                		 				   + "; letter-spacing: " + letterAttr.getValue()+ "px; ");
	                 
	                 
	                 for ( Iterator iterSInner = elementInner.elementIterator(); iterSInner.hasNext(); ) {
	                     Element elementSInner = (Element) iterSInner.next();
	                     
	                     Attribute SsizeAttr=elementSInner.attribute("SIZE");
	                     if(SsizeAttr != null){
		                	 String align = SsizeAttr.getValue();
		                	 if (SsizeAttr != null&&!SsizeAttr.equals("")) {
		                		 elementSInner.remove(SsizeAttr);
		                	 } 
		                 }
	                     
	                 }
	                 
                 }
             }
            
            
            String content = document.getRootElement().asXML().toString();
            content = content.replaceAll("<root>", "");
            content = content.replaceAll("</root>", "");
            content = stripFontHtml(content);
            return content;
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return new String();
	}
	
	public static String stripHtml(String content) { 
		// <p>段落替换为换行 
		content = content.replaceAll("<P .*?>", "\r\n"); 
		// <br><br/>替换为换行 
		content = content.replaceAll("<br\\s*/?>", "<BR/>"); 
		// 去掉其它的<>之间的东西 
		content = content.replaceAll("\\<.*?>", ""); 
		// 还原HTML 
		// content = HTMLDecoder.decode(content); 
		return content; 
	} 	
	
	public static String stripFontHtml(String content) { 
		// <p>段落替换为换行 
		content = content.replaceAll("<FONT .*?>", "&nbsp;&nbsp;"); 

		

		return content; 
	} 		
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String str = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">  根据市局党委和办公室党委关于加强党建工作的各项部署要求，紧紧围绕党的十八大安保中心工作，以“忠诚、为民、公正、廉政”的人民警察核心价值观、“理性、平和、文明、规范”的执法理念和“爱国、创新、包容、厚德”的北京精神为引领，结合秘书处队伍和业务工作实际，特制定以下工作计划：</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        1.制定年度和季度工作计划。根据市局党委和办公室党委的总体部署，结合秘书处党员队伍和业务工作实际，认真做好年度工作计划和每季度工作计划，确保本年度支部各项工作有条不紊开展。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        2.强化党组织活动。坚持以党建带队建促工作，认真落实好党支部组织生活制度，开展好主题党日活动，加强办公室第一党支部第二党小组组织活动，始终保持全体党员民警坚定的党性观念。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        3.加强日常政策理论学习。结合公安工作实际，及时组织学习党和国家的理论方针政策，及时学习中央和市委、市政府、公安部等上级单位的决策部署，及时学习市局党委和办公室党委的部署要求，始终保持全体党员民警在政策理论上的先进性。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        4.做好战时思想政治动员。围绕春节、五一、十一等重大节日以及六四等重要敏感日，特别是全国“两会”、党的十八大等重大活动安保工作，启动战时思想政治动员机制，确保全体党员民警在思想上、行动上始终与市局党委、办公室党委保持高度一致。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        5.加强党支部文化建设。以“忠诚、为民、公正、廉洁”人民警察核心价值观、“理性、平和、文明、规范”执法理念和“爱国、创新、包容、厚德”北京精神为引领，组织开展符合秘书处特点的警营文化建设和爱警系统工程，做好青年文明岗和优秀青年警队争创工作，激发队伍活力，保持队伍状态。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        6.认真开展党风廉政建设。围绕市局党委关于党风廉政建设的部署要求，认真做好廉政风险防范管理各项工作和纪律作风教育整顿工作，始终保持队伍风清气正。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        7.扎实做好保密工作。严格执行市委、市政府、公安部和市局有关保密规定，定期开展内部保密教育和保密检查，始终做到警钟长鸣，坚决防止发生失泄密问题。</FONT></P></TEXTFORMAT><TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"ArialBlack\" SIZE=\"12\" COLOR=\"#000000\" LETTERSPACING=\"0\" KERNING=\"1\">        8.做好总结和表彰等各项工作。根据市局党委和办公室党委的部署要求，认真做好支部建设工作总结、宣传表彰等各项工作，始终保持队伍良好的精神面貌。</FONT></P></TEXTFORMAT>";
		richTextEditorToHtml c = new richTextEditorToHtml();
		
		String cc = c.doRichTextEditorToHtml(str);
		System.out.println(cc);
	}

}
