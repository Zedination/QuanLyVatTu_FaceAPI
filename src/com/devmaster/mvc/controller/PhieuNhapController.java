package com.devmaster.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.CTPNhapDTO;
import com.devmaster.mvc.entity.PnhapDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.jdbc.PnhapJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JsonUtil;
@Controller
public class PhieuNhapController extends AbstractController {
	@RequestMapping(value = "/qlphieunhap", method = RequestMethod.GET)
	public String viewPhieuNhap(Model model) {
		return "qlvt/qlphieunhap";
	}
	
	@RequestMapping("/listPhieuNhap")
	public void listPhieuNhap(HttpServletRequest request, HttpServletResponse response) {
		PnhapDTO pnhapDTO = new PnhapDTO();
		initGetDTO(pnhapDTO, request);
		JQGridDTO<PnhapDTO> gridData = new PnhapJdbc().listPhieuNhap(pnhapDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			System.out.println(JsonUtil.toJsonObj(gridData));
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/listCTPN")
	public void listCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPNhapDTO ctpnhapDTO = new CTPNhapDTO();
		initGetCTDTO(ctpnhapDTO, request);
		JQGridDTO<CTPNhapDTO> gridData = new PnhapJdbc().listCTPN(ctpnhapDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void initGetDTO(PnhapDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setSoPn(request.getParameter("soPN"));
		searchDTO.setSoDH(request.getParameter("soDH"));
	}
	public void initPostDTO(PnhapDTO postDTO, HttpServletRequest request) {
		postDTO.setSoPn(request.getParameter("soPN"));
		postDTO.setNgayNhap(request.getParameter("ngayNhap"));
		postDTO.setSoDH(request.getParameter("soDH"));
	}
	
	public void initPostCTDTO(CTPNhapDTO postDTO, HttpServletRequest request) {
		postDTO.setSoPN(request.getParameter("soPN"));
		postDTO.setMaVTu(request.getParameter("maVTu"));
		postDTO.setsLNhap(request.getParameter("sLNhap"));
		postDTO.setdGNhap(request.getParameter("dGNhap"));
	}
	public void initGetCTDTO(CTPNhapDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setSoPN(request.getParameter("soPN"));
	}
	
	@RequestMapping(value = "/createPNhap", method = RequestMethod.POST)
	public void createPNhap(HttpServletRequest request, HttpServletResponse response) {
		PnhapDTO postDTO = new PnhapDTO ();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new PnhapJdbc().createPnhap(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/createCTPN", method = RequestMethod.POST)
	public void createCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPNhapDTO postDTO = new CTPNhapDTO ();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new PnhapJdbc().createCTPN(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/updatePNhap", method = RequestMethod.POST)
	public void updatePNhap(HttpServletRequest request, HttpServletResponse response) {
		PnhapDTO postDTO = new PnhapDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new PnhapJdbc().updatePnhap(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/updateCTPN", method = RequestMethod.POST)
	public void updateCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPNhapDTO postDTO = new CTPNhapDTO();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new PnhapJdbc().updateCTPN(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deletePNhap", method = RequestMethod.POST)
	public void deletePNhap(HttpServletRequest request, HttpServletResponse response) {
		PnhapDTO postDTO = new PnhapDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new PnhapJdbc().deletePnhap(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deleteCTPN", method = RequestMethod.POST)
	public void deleteCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPNhapDTO postDTO = new CTPNhapDTO();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new PnhapJdbc().deleteCTPN(postDTO);
		
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
