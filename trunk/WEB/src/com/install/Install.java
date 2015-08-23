package com.install;

import static com.common.web.Constants.UTF8;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.io.Reader;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import com.common.db.ScriptRunner;
/**
 * 安装类
 * 
 * @author liufang
 * 
 */
public class Install {
	public static void dbXml(String fileName, String dbHost, String dbPort,
			String dbName, String dbUser, String dbPassword) throws Exception {
		String s = FileUtils.readFileToString(new File(fileName));
		s = StringUtils.replace(s, "DB_HOST", dbHost);
		s = StringUtils.replace(s, "DB_PORT", dbPort);
		s = StringUtils.replace(s, "DB_NAME", dbName);
		s = StringUtils.replace(s, "DB_USER", dbUser);
		s = StringUtils.replace(s, "DB_PASSWORD", dbPassword);
		FileUtils.writeStringToFile(new File(fileName), s);
	}
	
	public static Connection getConn(String dbHost, String dbPort,
			String dbName, String dbUser, String dbPassword) throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String connStr = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
				+ "?user=" + dbUser + "&password=" + dbPassword
				+ "&characterEncoding=utf8";
		Connection conn = DriverManager.getConnection(connStr);
		return conn;
	}

	public static void webXml(String fromFile, String toFile) throws Exception {
		FileUtils.copyFile(new File(fromFile), new File(toFile));
	}

	/**
	 * 创建数据库
	 * 
	 * @param dbHost
	 * @param dbName
	 * @param dbPort
	 * @param dbUser
	 * @param dbPassword
	 * @throws Exception
	 */
	public static void createDb(String dbHost, String dbPort, String dbName,
			String dbUser, String dbPassword) throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String connStr = "jdbc:mysql://" + dbHost + ":" + dbPort + "?user="
				+ dbUser + "&password=" + dbPassword
				+ "&characterEncoding=UTF8";
		Connection conn = DriverManager.getConnection(connStr);
		Statement stat = conn.createStatement();
		String sql = "drop database if exists " + dbName;
		stat.execute(sql);
		sql = "create database " + dbName + " CHARACTER SET UTF8";
		stat.execute(sql);
		stat.close();
		conn.close();
	}

	public static void changeDbCharset(String dbHost, String dbPort,
			String dbName, String dbUser, String dbPassword) throws Exception {
		Connection conn = getConn(dbHost, dbPort, dbName, dbUser, dbPassword);
		Statement stat = conn.createStatement();
		String sql = "ALTER DATABASE " + dbName + " CHARACTER SET UTF8";
		stat.execute(sql);
		stat.close();
		conn.close();
	}

	/**
	 * 创建表
	 * 
	 * @param dbHost
	 * @param dbName
	 * @param dbPort
	 * @param dbUser
	 * @param dbPassword
	 * @param sqlList
	 * @throws Exception
	 */
	public static void createTable(String dbHost, String dbPort, String dbName,
			String dbUser, String dbPassword, List<String> sqlList)
			throws Exception {
		Connection conn = getConn(dbHost, dbPort, dbName, dbUser, dbPassword);
		Statement stat = conn.createStatement();
		for (String dllsql : sqlList) {
			System.out.println(dllsql);
			stat.execute(dllsql);
		}
		stat.close();
		conn.close();
	}
	
	/**
	 * 创建存储过程
	 * 
	 * @param dbHost
	 * @param dbName
	 * @param dbPort
	 * @param dbUser
	 * @param dbPassword
	 * @param sqlList
	 * @throws Exception
	 */
	public static void createProc(String dbHost, String dbPort, String dbName,
			String dbUser, String dbPassword, String dbProcFileName)
			throws Exception {
		Connection conn = getConn(dbHost, dbPort, dbName, dbUser, dbPassword);
		
		ScriptRunner sr = new ScriptRunner(conn, false, true);
		Reader reader = new FileReader(dbProcFileName);
		sr.setDelimiter("//", false);
		sr.runScript(reader);
		conn.close();
	}	
	

	/**
	 * 更新演示数据年份
	 * 
	 * @param dbHost
	 * @param dbName
	 * @param dbPort
	 * @param dbUser
	 * @param dbPassword
	 * @param domain
	 * @param cxtPath
	 * @param port
	 * @throws Exception
	 */
	public static void updateSampleDataYear(String dbHost, String dbPort,
			String dbName, String dbUser, String dbPassword) throws Exception {
		
		 Calendar ca = Calendar.getInstance(); 
	     ca.setTime(new java.util.Date()); 
	     Integer year = ca.get(Calendar.YEAR); 
		
		Connection conn = getConn(dbHost, dbPort, dbName, dbUser, dbPassword);
		
		Statement stat = conn.createStatement();
		String sql = "update pc_meeting set year=" + year;
		stat.executeUpdate(sql);
		sql = "update pc_workplan set year=" + year;
		stat.executeUpdate(sql);
		stat.close();
		conn.close();
	}	
	
	/**
	 * 更新admin用户名
	 * 
	 * @param dbHost
	 * @param dbName
	 * @param dbPort
	 * @param dbUser
	 * @param dbPassword
	 * @param domain
	 * @param cxtPath
	 * @param port
	 * @throws Exception
	 */
	public static void updateAdminConfig(String dbHost, String dbPort,
			String dbName, String dbUser, String dbPassword, String adminUser,
			String adminPassword, String adminName) throws Exception {
		Connection conn = getConn(dbHost, dbPort, dbName, dbUser, dbPassword);
		Statement stat = conn.createStatement();
		String sql = "update pc_agency set name='" + adminName + "' WHERE id = 1";
		stat.executeUpdate(sql);
		sql = "update pc_user set username='" + adminUser + "', password='" + adminPassword + "' WHERE id = 1";
		stat.executeUpdate(sql);
		stat.close();
		conn.close();
	}	

	/**
	 * 读取sql语句。“/*”开头为注释，“;”为sql结束。
	 * 
	 * @param fileName
	 *            sql文件地址
	 * @return list of sql
	 * @throws Exception
	 */
	public static List<String> readSql(String fileName) throws Exception {
		BufferedReader br = new BufferedReader(new InputStreamReader(
				new FileInputStream(fileName), UTF8));
		List<String> sqlList = new ArrayList<String>();
		StringBuilder sqlSb = new StringBuilder();
		String s = null;
		while ((s = br.readLine()) != null) {
			if (s.startsWith("/*") || s.startsWith("#") || s.startsWith("--")
					|| StringUtils.isBlank(s)) {
				continue;
			}
			if (s.endsWith(";")) {
				sqlSb.append(s);
				sqlSb.setLength(sqlSb.length() - 1);
				sqlList.add(sqlSb.toString());
				sqlSb.setLength(0);
			} else {
				sqlSb.append(s);
			}
		}
		br.close();
		return sqlList;
	}
}
