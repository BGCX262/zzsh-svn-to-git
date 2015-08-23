package com.install;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InstallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String dbHost = request.getParameter("dbHost");
		String dbPort = request.getParameter("dbPort");
		String dbName = request.getParameter("dbName");
		String dbUser = request.getParameter("dbUser");
		String dbPassword = request.getParameter("dbPassword");
		
		String adminUser = request.getParameter("adminUser");
		String adminPassword = request.getParameter("adminPassword");
		String str = request.getParameter("adminName");
		String adminName=new String(str.getBytes("ISO-8859-1"),"UTF-8");

		String isSampleData = request.getParameter("isSampleData");
		String dbFileName = request.getParameter("dbFileName");
		String dbProcFileName = request.getParameter("dbProcFileName");
		String sampleFileName = request.getParameter("sampleFileName");
		
		String webXmlFromDefault = "/install/config/ApplicationContext_default.xml";
		String webXmlFrom = "/install/config/ApplicationContext.xml";
		String webXmlTo = "/WEB-INF/classes/config/spring/ApplicationContext.xml";
		
		try {
			// 创建数据库 及初始化数据
			Install.createDb(dbHost, dbPort, dbName, dbUser, dbPassword);
			String sqlPath = getServletContext().getRealPath(dbFileName);
			List<String> sqlList = Install.readSql(sqlPath);
			Install.createTable(dbHost, dbPort, dbName, dbUser, dbPassword,
					sqlList);
			
			// 是否安装演示数据
			if ("true".equals(isSampleData)) {
				String initPath = getServletContext().getRealPath(sampleFileName);
				List<String> initList = Install.readSql(initPath);
				Install.createTable(dbHost, dbPort, dbName, dbUser, dbPassword,
						initList);
				Install.updateSampleDataYear(dbHost, dbPort, dbName, dbUser, dbPassword);	
			}
			
			//更新admin用户名和密码:
			Install.updateAdminConfig(dbHost, dbPort, dbName, dbUser, dbPassword,
			adminUser, adminPassword, adminName);	
			
			//执行存储过程
			String procPath = getServletContext().getRealPath(dbProcFileName);
			Install.createProc(dbHost, dbPort, dbName, dbUser, dbPassword,
					procPath);	
					
			
			// 处理数据库配置文件
			String webXmlFromDefaultPath = getServletContext().getRealPath(webXmlFromDefault);
			String webXmlFromPath = getServletContext().getRealPath(webXmlFrom);
			Install.webXml(webXmlFromDefaultPath, webXmlFromPath);
			
			Install.dbXml(webXmlFromPath, dbHost, dbPort, dbName, dbUser,
							dbPassword);
			// 处理ApplicationContext.xml
			
			String webXmlToPath = getServletContext().getRealPath(webXmlTo);
			Install.webXml(webXmlFromPath, webXmlToPath);	
			
		} catch (Exception e) {
			throw new ServletException("install failed!", e);
		}
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/install/install_setup.jsp");
		dispatcher.forward(request, response);
	}
}
