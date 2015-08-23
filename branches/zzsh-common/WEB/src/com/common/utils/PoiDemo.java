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
	
	
	public static void main(String[] args){
		PoiDemo rawDoc = new PoiDemo();
		Map<String, String> map=new HashMap<String, String>();
		
		map.put("$wp_title_year$", "2012");
		map.put("$wp_content$", "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		map.put("$wp_reported$", "man1");
		map.put("$wp_reported_date$", "2012年1月20日");
		map.put("$wp_py_content$", "评语评语");
		map.put("$wp_py_obj$", "政治部党委");
		map.put("$wp_py_date$", "2012年1月21日");
		map.put("$wp_pj_content$", "好");
		map.put("$wp_pj_obj$", "政治部党委");
		map.put("$wp_pj_date$", "2012年1月22日");		
		
		rawDoc.writeDoc(map);
	}

}
