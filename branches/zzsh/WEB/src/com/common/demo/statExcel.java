package com.common.demo;

import java.io.File; 
import java.util.*; 
import jxl.*;
import jxl.write.*; 
/**
* <p>Title: 操作EXCEL文件</p>
* <p>Description: 本实例演示使用jxl包实现对excel文件的操作</p>
* <p>Copyright: Copyright (c) 2003</p>
* <p>Filename: myExcel.java</p>
* @version 1.0
*/
public class statExcel{
	Workbook workbook;
	Sheet sheet;
	/**
	*<br>方法说明：写入文件操作
	*<br>输入参数：
	*<br>返回类型：
	*/
	public void write(){
	    try{
	        //创建一个可写入的excel文件对象
	        WritableWorkbook workbook = Workbook.createWorkbook(new File("E:/myfile.xls")); 
	        
	        WritableSheet sheet = workbook.createSheet("支委委员", 0); 
	        //表头                      列，行，内容
	        
	        List<Object> hl = new ArrayList();
	        //String[] column_attr_width = new String[]{ 30, "党内职务", "性别", "民族", "出生年月", "籍贯", "参加工作时间", "文化程度", "行政职务", "入党时间", "参加工作时间", "任党内职务时间", "现在家庭住址"};
	        String[] columns = new String[]{ "姓名", "党内职务", "性别", "民族", "出生年月", "籍贯", "参加工作时间", "文化程度", "行政职务", "入党时间", "参加工作时间", "任党内职务时间", "现在家庭住址"}; 
	        for(int   i=0;i <columns.length;i++){ 	        	  
	        	 Label head_label = new Label(i, 0, columns[i]); 
	        	 sheet.addCell(head_label); 
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
	}
	/**
	*<br>方法说明：读取excel文件一行数据
	*<br>输入参数：int row指定的行数
	*<br>返回类型：String〔〕结果数组
	*/ 
	public String[] readLine(int row){
	    try{
	      //获取数据表列数
	      int colnum = sheet.getColumns();
	      String[] rest = new String[colnum];
	      for(int i = 0; i < colnum; i++){
	        String sTemp = read(i,row);
	        if(sTemp!=null)
	         rest[i] = sTemp;
	      }
	      return rest;
	    }catch(Exception e){
	      System.out.println("readLine err:"+e);
	      workbook.close();
	      return null;
	    }
	}
	/**
	*<br>方法说明：读取excel的指定单元数据
	*<br>输入参数：
	*<br>返回类型：
	*/
	public String read(int col, int row){
	    try{
	      //获得单元数据
	      Cell a2 = sheet.getCell(col,row); 
	      String rest = a2.getContents();
	      return rest;
	    }catch(Exception e){
	      System.out.println("read err:"+e);
	      workbook.close();
	      return null;
	    }
	}
	/**
	*<br>方法说明：主方法，演示程序用
	*<br>输入参数：
	*<br>返回类型：
	*/
	public static void main(String[] arges){
	    try{
		     
			String realpath = "D:\\workspace\\java_work\\zzsh\\WEB\\WebRoot\\templates\\pt-workplan-stat.xls"; 
			
			Workbook wb = Workbook.getWorkbook(new File(realpath)); 
			
			File targetFile = new File("e:\\test1.xls"); 
			
			WritableWorkbook wwb = Workbook.createWorkbook(targetFile, wb); 
			
			WritableSheet wws = wwb.getSheet(0); 
			Label A1 = (Label)wws.getWritableCell(0,0);
			A1.setString("第三季度工作计划表");
   	
    	
		   wwb.write(); 
		   wwb.close(); 
		   wb.close(); 	    	
	    }catch(Exception e){
	      System.out.println(e);
	    }
	}
	   
}