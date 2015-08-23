package com.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

public class OperatorRTF {
	/**
	 * 字符串转换为rtf编码 2009-7-5 wde 增加中文支持
	 * 
	 * @param content
	 * @return
	 */
	int inext = 0;// 用来判断中文 编码出现 第一次出现为0 第二次出现为1 add by wde

	public String strToRtf(String content) {
		

		try {
			content = new String(content.getBytes(), "GB2312");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}		
		
		char[] digital = "0123456789ABCDEF".toCharArray();
		StringBuffer sb = new StringBuffer("");
		byte[] bs = content.getBytes();
		int bit;
		for (int i = 0; i < bs.length; i++) {
			bit = (bs[i] & 0x0f0) >> 4;
			/*
			 * 2009-7-5 add by wde 增加中文支持思路：通过getBytes获取的中文的assii小于0，根据rtf中文的的编码
			 * 所以只需要在中文的2个编码 第一个编码前加 第二个编码后加 加了一个变量inext 用来判断中文的assii 前一个和后一个。
			 * 这样在rtf中文的乱码就可以解决了。
			 */
			if (bs[i] > 0) {
				sb.append("\\'");
			} else {
				if (inext == 0) {
					// 通过写字板创建的rtf模板 add by wde
					// sb.append("\\lang2052\\f1");
					// 通过WPS2009创建的rtf模板 add by wde
					// sb.append("\\lang1033 \\langnp1033 \\langfe2052 \\langfenp2052 \\cf1");
					// 通过MS word创建的rtf模板 add by wde
					sb.append("\\loch\\af2\\hich\\af2\\dbch\\f31505");
					sb.append("\\'");
					inext = 1;
				} else {
					sb.append("\\'");
				}
			}
			sb.append(digital[bit]);
			bit = bs[i] & 0x0f;
			sb.append(digital[bit]);
			if (bs[i] < 0 && inext == 1) {
				// 通过写字板创建的rtf模板 add by wde
				// sb.append("\\lang1033\\f0");
				// 通过WPS2009创建的rtf模板 add by wde
				// sb.append(" \\lang1033\\langnp1033 \\langfe2052\\langfenp2052 \\cf1");
				// 通过MS word创建的rtf模板 add by wde
				sb.append("\\hich\\af2\\dbch\\af31505\\loch\\f2");
				inext = 0;
			}
		}

		return sb.toString();
	}

	/**
	 * 替换文档的可变部分 add by wde 2009-7-6
	 * 
	 * @param content
	 *            原来的文本
	 * @param markersign
	 *            标记符号
	 * @param replacecontent
	 *            替换的内容 用replacecontent替换markersign
	 * @return
	 */
	public String replaceRTF(String content, String markersign,
			String replacecontent) {
		String rc = strToRtf(replacecontent);
		System.out.println(rc);
		String target = "";
		markersign = "$" + markersign + "$";
		target = content.replace(markersign, rc);
		return target;
	}

	/*
	 * 替换模板 add by wde 2009-7-6
	 * 
	 * @param inputPath
	 * 
	 * @param outPath
	 * 
	 * @param data
	 * 
	 * @return
	 */
	public void rgModel(String inputPath, String outPath, HashMap data) {
		// TODO Auto-generated method stub
		/* 字节形式读取模板文件内容,将结果转为字符串 */
		String sourname = inputPath + "\\" + "workplan.rtf";

		String sourcecontent = "";
		InputStream ins = null;
		try {
			ins = new FileInputStream(sourname);

			// byte[] b = new byte[1024];//对应在while中使用bytesRead = ins.read(b, 0,
			// 1024);
			// byte[] b = new byte[16384]; //对应在while中使用bytesRead = ins.read(b);
			byte[] b = new byte[1638400];// 提高对于RTF文件的读取速度，特别是对于1M以上的文件
			if (ins == null) {
				System.out.println("源模板文件不存在");
			}
			int bytesRead = 0;
			while (true) {
				// bytesRead = ins.read(b, 0, 1024); // return final read bytes
				// counts
				bytesRead = ins.read(b, 0, 1638400);
				if (bytesRead == -1) {// end of InputStream
					System.out.println("读取模板文件结束");
					break;
				}
				sourcecontent += new String(b, 0, bytesRead); // convert to
																// string using
																// bytes
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		/* 修改变化部分 */
		String targetcontent = "";
		String oldText = "";
		Object newValue;
		/* 结果输出保存到文件 */
		try {
			Iterator keys = data.keySet().iterator();
			
			int keysfirst = 0;
			while (keys.hasNext()) {
				oldText = (String) keys.next();
				
				System.out.println("oldText ===" + oldText);				
				
				newValue = data.get(oldText);
				
				System.out.println("newValue ===" + newValue);		
				
				String newText = (String) newValue;
				inext = 0;// add by wde 改为初始状态
				if (keysfirst == 0) {
					targetcontent = replaceRTF(sourcecontent, oldText, newText);
					keysfirst = 1;
				} else {
					targetcontent = replaceRTF(targetcontent, oldText, newText);
					keysfirst = 1;
				}
			}

			FileWriter fw = new FileWriter(outPath, true);
			PrintWriter out = new PrintWriter(fw);
			if (targetcontent.equals("") || targetcontent == "") {
				out.println(sourcecontent);
			} else {
				out.println(targetcontent);
			}
			out.close();
			fw.close();
			System.out.println(outPath + " 生成文件成功");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		Date current = new Date();
		String targetname = sdf.format(current).substring(0, 4) + "年";
		targetname += sdf.format(current).substring(5, 7) + "月";
		targetname += sdf.format(current).substring(8, 10) + "日";
		targetname += sdf.format(current).substring(11, 13) + "时";
		targetname += sdf.format(current).substring(14, 16) + "分";
		targetname += sdf.format(current).substring(17, 19) + "秒";
		targetname += ".rtf";
		OperatorRTF oRTF = new OperatorRTF();

		// *****************************************
		// 利用HashMap读取数据库中的数据
		HashMap map = new HashMap();
		map.put("$wp_title_year$", "2012");
		map.put("wp_content", "xxxxxx");
		map.put("wp_reported", "man1");
		map.put("wp_reported_date", "2012年1月20日");
		map.put("wp_ py_content", "评语评语");
		map.put("wp_py_obj", "政治部党委");
		map.put("wp_py_date", "2012年1月21日");
		map.put("wp_pj_content", "好");
		map.put("wp_pj_obj", "政治部党委");
		map.put("wp pj_date", "2012年1月22日");
		// ******************************************
		oRTF.rgModel("C:\\YQ", "c:\\YQ\\" + targetname, map);

	}
}