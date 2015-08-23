package com.partycommittee.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.commons.lang.ObjectUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.partycommittee.remote.vo.PcLicenseVo;
import com.partycommittee.remote.vo.PcRemindVo;
import com.common.Des;


@Transactional
@Service("PcLicenseService")
public class PcLicenseService {

	public PcLicenseVo getLicense() throws UnsupportedEncodingException {
		
		SAXReader saxReader = new SAXReader(); 
		Document document = null; 
		File file = new File(PcLicenseService.class.getClassLoader().getResource("/").getPath() + "license.xml");
		String license_proc;
		String license_tips;
		try { 
			document = saxReader.read(file);
			Element root = document.getRootElement();
		    
		    Element license_element = root.element("license");
		    
		    license_proc = license_element.getText();
		    
		    Element tips_element = root.element("tips");
		    
		    license_tips = tips_element.getText();		    
		    
		} catch (DocumentException e) { 
		    e.printStackTrace();
		    return null;
		}
		
		
		Des des = new Des();

		String xml = des.DecryPwdStr(license_proc, "hrpweb30");// 把String 类型的密文解密
		
		if (xml.indexOf("root") <= 0) {
			xml = "<root>" + xml + "</root>";
		}

		PcLicenseVo licensevo = setLicenseVo(xml, license_tips);
		
		return licensevo;
	}
	
	private PcLicenseVo setLicenseVo(String xml, String tips) {

		if (xml == null || xml.equals("")) return null;
		
		PcLicenseVo licensevo = new PcLicenseVo();
		
		SAXReader saxReader = new SAXReader(); 
		Document document = null; 
		try { 
			document = saxReader.read(new ByteArrayInputStream(xml.getBytes())); 
		    
		    Element root = document.getRootElement();
		    
		    Element productno_element = root.element("productno");

		    licensevo.setProductno(productno_element.getText());

		    
		    Element locknodw_element = root.element("locknodw");

		    licensevo.setLocknodw(Integer.parseInt(locknodw_element.getText()));
		    
		    Element locknozb_element = root.element("locknozb");

		    licensevo.setLocknozb(Integer.parseInt(locknozb_element.getText()));		    
		    
		    Element firstdate_element = root.element("firstdate");

		    licensevo.setFirstdate(firstdate_element.getText());
		    
		    Element leftdays_element = root.element("leftdays");
	
		    licensevo.setLeftdays(Integer.parseInt(leftdays_element.getText()));
		    
		    licensevo.setTips(tips);
		} catch (DocumentException e) { 
		    e.printStackTrace();
		    return null;
		}
		
		return licensevo;		
		
	}
	
	public PcLicenseVo setLicenseInfo(String enstr, String tips) {
		if (enstr == null || enstr.equals("")) return null;
		if (tips == null || tips.equals("")) return null;
		PcLicenseVo licensevo = new PcLicenseVo();
		Des des = new Des();
		try 
		{
			
			String xml = des.DecryPwdStr(enstr, "hrpweb30");// 把String 类型的密文解密
			System.out.println("xml ==============" + xml);
			if (xml == "" || xml.equals("")) { 
				return null;
			}
			
			if (xml.indexOf("locknodw") <=0) {
				return null;
			}
			
			if (xml.indexOf("locknozb") <=0) {
				return null;
			}			
			
			if (xml.indexOf("root") <= 0) {
				xml = "<root>" + xml + "</root>";
			}
			System.out.println("xml +++++++++++++++++" + xml);
			licensevo = setLicenseVo(xml, tips);
			
			SAXReader saxReader = new SAXReader(); 
			Document document = null; 
			File file = new File(PcLicenseService.class.getClassLoader().getResource("/").getPath() + "license.xml");			
			
			document = saxReader.read(file);
			Element root = document.getRootElement();
		    
		    Element license_element = root.element("license");
		    
		    license_element.setText(enstr);
		    
		    Element tips_element = root.element("tips");
		    
		    tips_element.setText(tips);
		    
		    
		    String path = PcLicenseService.class.getClassLoader().getResource("/").getPath();
		    OutputFormat format = OutputFormat.createPrettyPrint();  
	        // 利用格式化类对编码进行设置  
	        format.setEncoding("UTF8");  
	        FileOutputStream output = new FileOutputStream(new File(path + "license.xml"));  
	        XMLWriter writer = new XMLWriter(output, format);  
	        writer.write(document);  
	        writer.flush();  
	        writer.close();  		    
			
			
		} catch (Exception e) {
			//e.printStackTrace();
			return null;
		}

		return licensevo;
	}	
	
}
