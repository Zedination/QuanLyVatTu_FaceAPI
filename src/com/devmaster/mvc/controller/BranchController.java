package com.devmaster.mvc.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.BaseDTO;
import com.devmaster.mvc.entity.Demo;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.BranchDTO;
import com.devmaster.mvc.jdbc.BranchJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class BranchController extends AbstractController{
	private static final Logger logger = Logger.getLogger(DemoController.class);

	@RequestMapping(value = "/branch", method = RequestMethod.GET)
	public String viewBranch(Model model) {
		/*
		 * logger.info("name is " + name); Demo demo = new Demo();
		 * demo.setTitle("Spring MVC Demo"); demo.setName(name);
		 * 
		 * model.addAttribute(demo);
		 */
		return "demo/dmbanhsc";
	}

	@RequestMapping("/listBranch")
	public void listBranch(HttpServletRequest request, HttpServletResponse response) {
		BranchDTO searchDTO = new BranchDTO();
		initGetDTO(searchDTO, request);
		JQGridDTO<BranchDTO> gridData = new BranchJdbc().listBranch(searchDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/createBranch", method = RequestMethod.POST)
	public void createBranch(HttpServletRequest request, HttpServletResponse response) {
		BranchDTO postDTO = new BranchDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new BranchJdbc().createBranch(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/updateBranch", method = RequestMethod.POST)
	public void updateBranch(HttpServletRequest request, HttpServletResponse response) {
		BranchDTO postDTO = new BranchDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new BranchJdbc().updateBranch(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deleteBranch", method = RequestMethod.POST)
	public void deleteBranch(HttpServletRequest request, HttpServletResponse response) {
		BranchDTO postDTO = new BranchDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new BranchJdbc().deleteBranch(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void initGetDTO(BranchDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setBranchCode(request.getParameter("branchcode"));
		searchDTO.setBranchName(request.getParameter("branchname"));
	}
	
	public void initPostDTO(BranchDTO postDTO, HttpServletRequest request) {
		postDTO.setBranchCode(request.getParameter("branchcode"));
		postDTO.setBranchName(request.getParameter("branchname"));
		postDTO.setLocation(request.getParameter("location"));
	}
}
