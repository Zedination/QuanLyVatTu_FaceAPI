package com.devmaster.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.BranchDTO;
import com.devmaster.mvc.entity.NhaCCDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.VatTuDTO;
import com.devmaster.mvc.jdbc.BranchJdbc;
import com.devmaster.mvc.jdbc.NhaccJdbc;
import com.devmaster.mvc.jdbc.VatTuJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class DMVNHACCController extends AbstractController{
	
	@RequestMapping(value = "/dmnhacc", method = RequestMethod.GET)
	public String viewBranch(Model model) {
		return "qlvt/dmnhacc";
	}
	
	
	@RequestMapping("/listNhacc")
	public void listBranch(HttpServletRequest request, HttpServletResponse response) {
		NhaCCDTO nccDTO = new NhaCCDTO();
		initGetDTO(nccDTO, request);
		JQGridDTO<NhaCCDTO> gridData = new NhaccJdbc().listNhacc(nccDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/createNHACC", method = RequestMethod.POST)
	public void createBranch(HttpServletRequest request, HttpServletResponse response) {
		NhaCCDTO postDTO = new NhaCCDTO ();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new NhaccJdbc().createNCC(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/updateNHACC", method = RequestMethod.POST)
	public void updateBranch(HttpServletRequest request, HttpServletResponse response) {
		NhaCCDTO postDTO = new NhaCCDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new NhaccJdbc().updateNCC(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void initPostDTO(NhaCCDTO postDTO, HttpServletRequest request) {
		postDTO.setMaNCC(request.getParameter("maNCC"));
		postDTO.setTenNCC(request.getParameter("tenNCC"));
		postDTO.setDiaChi(request.getParameter("diaChi"));
		postDTO.setDienThoai(request.getParameter("dienThoai"));
	}
	
	
	public void initGetDTO(NhaCCDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setMaNCC(request.getParameter("maNCC"));
		searchDTO.setTenNCC(request.getParameter("tenNCC"));
	}
	@RequestMapping(value = "/deleteNHACC", method = RequestMethod.POST)
	public void deleteBranch(HttpServletRequest request, HttpServletResponse response) {
		NhaCCDTO postDTO = new NhaCCDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new NhaccJdbc().deleteNCC(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
