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
import com.devmaster.mvc.entity.TonKhoDTO;
import com.devmaster.mvc.jdbc.DonHangJdbc;
import com.devmaster.mvc.jdbc.TonKhoJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JasperUtil;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class TonKhoController extends AbstractController{
	String a;
	String b;
	@RequestMapping(value = "/tonkho", method = RequestMethod.GET)
	public String viewTonKho(Model model) {
		return "qlvt/tonkho";
	}
	
	
	@RequestMapping("/listTonKho")
	public void listTonKho(HttpServletRequest request, HttpServletResponse response) {
		TonKhoDTO tonKhoDTO = new TonKhoDTO();
		initGetDTO(tonKhoDTO, request);
		JQGridDTO<TonKhoDTO> gridData = new TonKhoJdbc().listTonKho(tonKhoDTO);
		
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/createTonKho", method = RequestMethod.POST)
	public void createTonKho(HttpServletRequest request, HttpServletResponse response) {
		TonKhoDTO postDTO = new TonKhoDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new TonKhoJdbc().createTonKho(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/updateTonKho", method = RequestMethod.POST)
	public void updateTonKho(HttpServletRequest request, HttpServletResponse response) {
		TonKhoDTO postDTO = new TonKhoDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new TonKhoJdbc().updateTonKho(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void initPostDTO(TonKhoDTO postDTO, HttpServletRequest request) {
		postDTO.setNamThang(request.getParameter("NamThang"));
		postDTO.setMavtu(request.getParameter("Mavtu"));
		postDTO.setSLDau(request.getParameter("SLDau"));
		postDTO.setTongSLN(request.getParameter("TongSLN"));
		postDTO.setTongSLX(request.getParameter("TongSLX"));
		postDTO.setSLCuoi(request.getParameter("SLCuoi"));
	}
	
	
	public void initGetDTO(TonKhoDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setNamThang(request.getParameter("NamThang"));
		searchDTO.setMavtu(request.getParameter("Mavtu"));
	}
	@RequestMapping(value = "/deleteTonKho", method = RequestMethod.POST)
	public void deleteTonKho(HttpServletRequest request, HttpServletResponse response) {
		TonKhoDTO postDTO = new TonKhoDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new TonKhoJdbc().deleteTonKho(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
//	@RequestMapping("/rptTonKho")
//	public void rptTonKho(HttpServletRequest request, HttpServletResponse response) {
//		
//		try {
//			Map<String, Object> param = new HashMap<String, Object>();
//			System.out.println(request.getParameter("mavtu"));
//			param.put("v_Mavtu", request.getParameter("mavtu"));
//			param.put("v_TenVTu", request.getParameter("tenvtu"));
//			JasperUtil.createReport("rpvt", param, Constant.FORMAT_PDF, request, response);
//			
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
