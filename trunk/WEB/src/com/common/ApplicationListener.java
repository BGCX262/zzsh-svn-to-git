package com.common;

import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

public class ApplicationListener extends ContextLoaderListener {  
	  
    public void contextDestroyed(ServletContextEvent sce) {  
        // TODO Auto-generated method stub  
  
    }  
  
    public void contextInitialized(ServletContextEvent sce) {  
        // TODO Auto-generated method stub  
        String webAppRootKey = sce.getServletContext().getRealPath("/");  
        System.setProperty("zzsh.root" , webAppRootKey);  
//        String path =System.getProperty("zzsh.root");  
    }  
  
} 