package com.partycommittee.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.partycommittee.constants.SessionConstant;
import com.partycommittee.remote.vo.PcUserVo;

public class LoginVerifyFilter implements Filter {
	private static String skips[] = null;


	public void init(FilterConfig filterConfig) throws ServletException {
		String value = filterConfig.getInitParameter("skip");
		if (value != null) {
			skips = value.split(";");
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest r = (HttpServletRequest)request;
		HttpServletResponse p = (HttpServletResponse)response;
		if (this.skipUserLoginCheck(r)) {
			chain.doFilter(request,response);
			return;
		}
		if (r.getSession() != null && r.getSession().getAttribute(SessionConstant.SESSON_USER) != null) {
			if (r.getSession().getAttribute(SessionConstant.SESSON_USER) instanceof PcUserVo) {
				chain.doFilter(request,response);
			}
		} else {
			String script = "<script language='javascript'>top.location.href='" + r.getContextPath() + "/login/Login.jsp'</script>";
			script = new String(script.getBytes("utf-8"), "ISO8859-1");
			p.getOutputStream().print(script);
		}
	}

	private boolean skipUserLoginCheck(HttpServletRequest r) {
		boolean result = false;
		String uri = r.getRequestURI();
        if (uri.equals(r.getContextPath()) || uri.equals(r.getContextPath() + "/")) {
        	return true;
        }
		for (String s : skips) {
			if (uri.indexOf(s) > 0) {
				result = true;
				break;
			}
		}
		return result;
	}

	public void destroy() {
	}
}