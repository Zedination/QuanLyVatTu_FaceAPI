/*package com.devmaster.mvc.util;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.devmaster.mvc.entity.User;

public class SessionInterceptor implements HandlerInterceptor{
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("preHandle Log time Interceptor: " + request.getServletPath() + new Date());
		return true;
	}

	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object arg2, ModelAndView arg3)
			throws Exception {
		String path = request.getServletPath();
		
		User user =  (User)request.getSession().getAttribute("user");
		if((user == null) & (!path.equalsIgnoreCase("/login"))) {
			try {
				response.sendRedirect("/devmaster_springmvc/login");
			} catch (IOException e) {
			}	
		}
		
	}
}
*/