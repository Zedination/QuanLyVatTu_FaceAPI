package com.devmaster.mvc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.UserDTO;
import com.devmaster.mvc.jdbc.SignupJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class SignupController extends AbstractController{
public String a;
	@RequestMapping(value = "/Signup", method = RequestMethod.GET)
	public String viewBranch(HttpServletRequest request) {
		
		if(request.getParameter("message") == null) {
			return "common/Signup";
		}else {
			return "common/Signup?message=error";
		}
		
	}
	
	

	@RequestMapping(value = "/Signup", method = RequestMethod.POST)
	public String createUser(HttpServletRequest request, HttpServletResponse response) {
		UserDTO postDTO = new UserDTO();
		System.out.println(request.getParameter("username"));
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new SignupJdbc().createUser(postDTO);
		a = reponse.getCode();
		System.out.println(a);
		if(a == Constant.CODE_SUCCESS) {
			return "common/SignupSuccess";
			
		}
		else {
			request.setAttribute("valid", a);		
			return "common/Signup";
		}
	}
	
	public void initPostDTO(UserDTO postDTO, HttpServletRequest request) {
		postDTO.setUsername(request.getParameter("username"));
		postDTO.setPassword(request.getParameter("password"));
		postDTO.setFullname(request.getParameter("fullname"));
		postDTO.setEmail(request.getParameter("email"));
	}
}
