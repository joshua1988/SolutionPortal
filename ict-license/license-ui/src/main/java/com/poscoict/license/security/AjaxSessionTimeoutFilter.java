package com.poscoict.license.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

public class AjaxSessionTimeoutFilter implements Filter{
	private String ajaxHeader="AJAX";
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	        HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse res = (HttpServletResponse) response;
	        if (isAjaxRequest(req)) {
	                try {
	                	String user = (String) req.getSession().getAttribute("USER_NO");
	                	if(user==null){
	                		throw new AccessDeniedException("세션 만료");
	                	}else{
	                		chain.doFilter(req, res);
	                	}
	                } catch (AccessDeniedException e) {
	                	System.out.println(e.getMessage());
	                       res.sendError(HttpServletResponse.SC_FORBIDDEN);
	                } catch (AuthenticationException e) {
	                       res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
	                }
	        } else {
	                chain.doFilter(req, res);
	        }
	}
	 
	private boolean isAjaxRequest(HttpServletRequest req) {
	        return req.getHeader(ajaxHeader) != null&& req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
	}

	public void setAjaxHeader(String ajaxHeader) {
		this.ajaxHeader = ajaxHeader;
	}

	@Override
	public void destroy() {}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {}
}
