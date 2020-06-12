package com.devmaster.mvc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.VatTuDTO;
import com.devmaster.mvc.jdbc.VatTuJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JasperUtil;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class DMVTUController extends AbstractController{
	String a;
	String b;
	@RequestMapping(value = "/dmvattu", method = RequestMethod.GET)
	public String viewBranch(Model model) {
		return "qlvt/dmvattu";
	}
	
	
	@RequestMapping("/listVatTu")
	public void listBranch(HttpServletRequest request, HttpServletResponse response) {
		VatTuDTO vatTuDTO = new VatTuDTO();
		initGetDTO(vatTuDTO, request);
		a = vatTuDTO.getMaVtu();
		b = vatTuDTO.getTenVtu();
		JQGridDTO<VatTuDTO> gridData = new VatTuJdbc().listVatTu(vatTuDTO);
		
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/createVatTu", method = RequestMethod.POST)
	public void createBranch(HttpServletRequest request, HttpServletResponse response) {
		VatTuDTO postDTO = new VatTuDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new VatTuJdbc().createBranch(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/updateVatTu", method = RequestMethod.POST)
	public void updateBranch(HttpServletRequest request, HttpServletResponse response) {
		VatTuDTO postDTO = new VatTuDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new VatTuJdbc().updateVatTu(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void initPostDTO(VatTuDTO postDTO, HttpServletRequest request) {
		postDTO.setMaVtu(request.getParameter("mavtu"));
		postDTO.setTenVtu(request.getParameter("tenvtu"));
		postDTO.setDvTinh(request.getParameter("dvtinh"));
		postDTO.setPhanTram(request.getParameter("phantram"));
	}
	
	
	public void initGetDTO(VatTuDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setMaVtu(request.getParameter("mavtu"));
		searchDTO.setTenVtu(request.getParameter("tenvtu"));
	}
	@RequestMapping(value = "/deleteVatTu", method = RequestMethod.POST)
	public void deleteBranch(HttpServletRequest request, HttpServletResponse response) {
		VatTuDTO postDTO = new VatTuDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new VatTuJdbc().deleteBranch(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/rptVattu")
	public void rptVatTu(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			System.out.println(request.getParameter("mavtu"));
			param.put("v_Mavtu", request.getParameter("mavtu"));
			param.put("v_TenVTu", request.getParameter("tenvtu"));
			JasperUtil.createReport("rpvt", param, Constant.FORMAT_PDF, request, response);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	/*
	 * @RequestMapping(value = "/viewrptVattu", method = RequestMethod.GET) public
	 * void viewrptVatTu(HttpServletRequest request, HttpServletResponse response) {
	 * try { Map<String, Object> param = new HashMap<String, Object>();
	 * JasperUtil.createReport("rptVatTu", param, Constant.FORMAT_PDF, request,
	 * response);
	 * 
	 * }catch (Exception e) { e.printStackTrace(); } }
	 */
}
