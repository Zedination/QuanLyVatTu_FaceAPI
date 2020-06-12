package com.devmaster.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.CTDonHangDTO;
import com.devmaster.mvc.entity.DonHangDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.jdbc.DonHangJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class DonHangController extends AbstractController{
	
	@RequestMapping(value = "/qldonhang", method = RequestMethod.GET)
	public String viewDonHang(Model model) {
		return "qlvt/qldonhang";
	}
	
	
	@RequestMapping("/listDonHang")
	public void listDonHang(HttpServletRequest request, HttpServletResponse response) {
		DonHangDTO donHangDTO = new DonHangDTO();
		initGetDTO(donHangDTO, request);
		JQGridDTO<DonHangDTO> gridData = new DonHangJdbc().listDonHang(donHangDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			System.out.println(JsonUtil.toJsonObj(gridData));
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/listCTDH")
	public void listCTDH(HttpServletRequest request, HttpServletResponse response) {
		CTDonHangDTO donHangDTO = new CTDonHangDTO();
		initGetCTDTO(donHangDTO, request);
		JQGridDTO<CTDonHangDTO> gridData = new DonHangJdbc().listCTDH(donHangDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getListMaNCC")
	public void getListMaNCC(HttpServletRequest request, HttpServletResponse response) {
		String xml = new DonHangJdbc().getListMaNCC();
		try {
			response.setContentType(Constant.CONTENT_TYPE_XML);
			response.getOutputStream().write(xml.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/getListMavtu")
	public void getListMavtu(HttpServletRequest request, HttpServletResponse response) {
		String xml = new DonHangJdbc().getListMavtu();
		try {
			response.setContentType(Constant.CONTENT_TYPE_XML);
			response.getOutputStream().write(xml.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void initGetDTO(DonHangDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setSodh(request.getParameter("soDH"));
		searchDTO.setMancc(request.getParameter("mancc"));
	}
	public void initPostDTO(DonHangDTO postDTO, HttpServletRequest request) {
		postDTO.setSodh(request.getParameter("soDH"));
		postDTO.setNgaydh(request.getParameter("ngaydh"));
		postDTO.setMancc(request.getParameter("mancc"));
	}
	
	public void initPostCTDTO(CTDonHangDTO postDTO, HttpServletRequest request) {
		postDTO.setSodh(request.getParameter("soDH"));
		postDTO.setMavtu(request.getParameter("mavtu"));
		postDTO.setSldat(request.getParameter("sldat"));
	}
	public void initGetCTDTO(CTDonHangDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setSodh(request.getParameter("soDH"));
	}
	
	@RequestMapping(value = "/createDONDH", method = RequestMethod.POST)
	public void createBranch(HttpServletRequest request, HttpServletResponse response) {
		DonHangDTO postDTO = new DonHangDTO ();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new DonHangJdbc().createSODH(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/createCTDONDH", method = RequestMethod.POST)
	public void createCTDH(HttpServletRequest request, HttpServletResponse response) {
		CTDonHangDTO postDTO = new CTDonHangDTO ();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new DonHangJdbc().createCTDH(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/updateDONDH", method = RequestMethod.POST)
	public void updateDONDH(HttpServletRequest request, HttpServletResponse response) {
		DonHangDTO postDTO = new DonHangDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new DonHangJdbc().updateDONDH(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/updateCTDONDH", method = RequestMethod.POST)
	public void updateCTDONDH(HttpServletRequest request, HttpServletResponse response) {
		CTDonHangDTO postDTO = new CTDonHangDTO();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new DonHangJdbc().updateCTDH(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deleteDONDH", method = RequestMethod.POST)
	public void deleteDONDH(HttpServletRequest request, HttpServletResponse response) {
		DonHangDTO postDTO = new DonHangDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new DonHangJdbc().deleteDONDH(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deleteCTDONDH", method = RequestMethod.POST)
	public void deleteCTDONDH(HttpServletRequest request, HttpServletResponse response) {
		CTDonHangDTO postDTO = new CTDonHangDTO();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new DonHangJdbc().deleteCTDH(postDTO);
		
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
