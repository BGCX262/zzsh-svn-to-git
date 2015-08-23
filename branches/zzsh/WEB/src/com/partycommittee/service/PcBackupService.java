package com.partycommittee.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataSource;
import javax.annotation.Resource;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.ApplicationListener;
import com.common.demo.richTextEditorToHtml;
import com.common.utils.ApplicationContextHelper;
import com.partycommittee.persistence.daoimpl.PcBackupDaoImpl;
import com.partycommittee.persistence.po.PcBackup;

import com.partycommittee.remote.vo.PcBackupVo;
import com.partycommittee.remote.vo.helper.PageHelperVo;
import com.partycommittee.remote.vo.helper.PageResultVo;

import freemarker.template.Configuration;
import freemarker.template.Template;


@Transactional
@Service("PcBackupService")
public class PcBackupService {

	@Resource(name="PcBackupDaoImpl")
	private PcBackupDaoImpl pcBackupDaoImpl;
	public void setPcBackupDaoImpl(PcBackupDaoImpl pcBackupDaoImpl) {
		this.pcBackupDaoImpl = pcBackupDaoImpl;
	}

	public PageResultVo<PcBackupVo> getBackups(PageHelperVo page) {
		
		PageResultVo<PcBackupVo> result = new PageResultVo<PcBackupVo>();
		List<PcBackupVo> list = new ArrayList<PcBackupVo>();
		PageResultVo<PcBackup> pageResult =  pcBackupDaoImpl.getBackups(page);
		if (pageResult == null) {
			return null;
		}
		result.setPageHelper(pageResult.getPageHelper());
		if (pageResult.getList() != null && pageResult.getList().size() > 0) {
			for (PcBackup item : pageResult.getList()) {
				list.add(PcBackupVo.fromPcBackup(item));
			}
		}
		result.setList(list);
		return result;
	}
	
	public void createBackup() {
		
		
		
	
		
		java.util.Date dt = new java.util.Date();
		 SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd-HHmmss");
		 String filename = fmt.format(dt);		
		 if (backup(filename) == true) {
			 PcBackupVo pevo = new PcBackupVo();
			 pevo.setFilename(filename);
			 pcBackupDaoImpl.createBackup(pevo.toPcBackup(pevo));
		 }
	}
	
	public void deleteBackup(Integer bId) {
		pcBackupDaoImpl.deleteBackupById(bId);
	}	
	
	
	public Boolean backup(String filename) {

		Properties pros = getJdbcProperties("jdbc.properties");
		// 这里是读取的属性文件，也可以直接使用
		String username = pros.getProperty("jdbc.username");
		String password = pros.getProperty("jdbc.password");
		
		String mysqldir = pros.getProperty("jdbc.mysqldir");
		String databaseName = pros.getProperty("jdbc.dbname");
		String address = pros.getProperty("jdbc.host");
		String sqlpath = pros.getProperty("jdbc.backupdir");
		File backupath = new File(sqlpath);
		if (!backupath.exists()) {
			backupath.mkdir();
		}

		StringBuffer sb = new StringBuffer();

		sb.append(mysqldir);
		sb.append("mysqldump ");
		sb.append("--opt ");
		sb.append("-h ");
		sb.append(address);
		sb.append(" ");
		sb.append("--user=");
		sb.append(username);
		sb.append(" ");
		sb.append("--password=");
		sb.append(password);
		sb.append(" ");
		sb.append("--lock-all-tables=true ");
		sb.append("--result-file=");
		sb.append(sqlpath);
		sb.append(filename);
		sb.append(" ");
		sb.append("--default-character-set=utf8 ");
		sb.append(databaseName);
		Runtime cmd = Runtime.getRuntime();
		try {
			Process p = cmd.exec(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;

	}
	
	public static Properties getJdbcProperties(String properName) {
		
		InputStream inputStream = PcBackupService.class.getClassLoader().getResourceAsStream(properName);
		Properties p = new Properties();
		try {
			p.load(inputStream);
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return p;

	}
	
	
	

}
