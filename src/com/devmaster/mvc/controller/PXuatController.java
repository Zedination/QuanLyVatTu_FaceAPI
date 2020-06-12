package com.devmaster.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.CTPXuatDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.PXuatDTO;
import com.devmaster.mvc.jdbc.PXuatJdbc;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.JsonUtil;

@Controller
public class PXuatController extends AbstractController {
	@RequestMapping(value = "/qlphieuxuat", method = RequestMethod.GET)
	public String viewPhieuXuat(Model model) {
		return "qlvt/qlphieuxuat";
	}
	
	@RequestMapping("/listPhieuXuat")
	public void listPhieuXuat(HttpServletRequest request, HttpServletResponse response) {
		PXuatDTO pxuatDTO = new PXuatDTO();
		initGetDTO(pxuatDTO, request);
		JQGridDTO<PXuatDTO> gridData = new PXuatJdbc().listPhieuXuat(pxuatDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			System.out.println(JsonUtil.toJsonObj(gridData));
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/listCTPX")
	public void listCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPXuatDTO ctpxuatDTO = new CTPXuatDTO();
		initGetCTDTO(ctpxuatDTO, request);
		JQGridDTO<CTPXuatDTO> gridData = new PXuatJdbc().listCTPX(ctpxuatDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(gridData));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void initGetDTO(PXuatDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setSoPX(request.getParameter("soPX"));
		searchDTO.setTenKH(request.getParameter("tenKH"));
	}
	public void initPostDTO(PXuatDTO postDTO, HttpServletRequest request) {
		postDTO.setSoPX(request.getParameter("soPX"));
		postDTO.setNgayXuat(request.getParameter("ngayXuat"));
		postDTO.setTenKH(request.getParameter("tenKH"));
	}
	
	public void initPostCTDTO(CTPXuatDTO postDTO, HttpServletRequest request) {
		postDTO.setSoPX(request.getParameter("soPX"));
		postDTO.setMaVTu(request.getParameter("maVTu"));
		postDTO.setsLXuat(request.getParameter("sLXuat"));
		postDTO.setdGXuat(request.getParameter("dGXuat"));
	}
	public void initGetCTDTO(CTPXuatDTO searchDTO, HttpServletRequest request) {
		super.initGetDTO(searchDTO, request);
		searchDTO.setSoPX(request.getParameter("soPX"));
	}
	
	@RequestMapping(value = "/createPXuat", method = RequestMethod.POST)
	public void createPXuat(HttpServletRequest request, HttpServletResponse response) {
		PXuatDTO postDTO = new PXuatDTO ();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new PXuatJdbc().createPXuat(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/createCTPX", method = RequestMethod.POST)
	public void createCTPX(HttpServletRequest request, HttpServletResponse response) {
		CTPXuatDTO postDTO = new CTPXuatDTO ();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new PXuatJdbc().createCTPX(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping(value = "/updatePXuat", method = RequestMethod.POST)
	public void updatePNhap(HttpServletRequest request, HttpServletResponse response) {
		PXuatDTO postDTO = new PXuatDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new PXuatJdbc().updatePXuat(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/updateCTPX", method = RequestMethod.POST)
	public void updateCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPXuatDTO postDTO = new CTPXuatDTO();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new PXuatJdbc().updateCTPX(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deletePXuat", method = RequestMethod.POST)
	public void deletePNhap(HttpServletRequest request, HttpServletResponse response) {
		PXuatDTO postDTO = new PXuatDTO();
		initPostDTO(postDTO, request);
		AjaxResponseBody reponse = new PXuatJdbc().deletePX(postDTO);
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/deleteCTPX", method = RequestMethod.POST)
	public void deleteCTPN(HttpServletRequest request, HttpServletResponse response) {
		CTPXuatDTO postDTO = new CTPXuatDTO();
		initPostCTDTO(postDTO, request);
		AjaxResponseBody reponse = new PXuatJdbc().deleteCTPX(postDTO);
		
		try {
			response.setContentType(Constant.CONTENT_TYPE_JSON);
			response.getWriter().write(JsonUtil.toJsonObj(reponse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
