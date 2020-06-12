package com.devmaster.mvc.controller;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class OtherController {
	@Autowired
	private ServletContext context;
	@RequestMapping(value = "/profile")
	public String viewProfile() {
		return "common/profile";
	}
	@RequestMapping(value = "/chat")
	public String viewChatBox() {
		return "common/chat";
	}
	@RequestMapping(value = "/download-guide", method = RequestMethod.GET)
	public void download1(HttpServletResponse response) throws IOException {
		try {
			File file = new File(context.getRealPath("/files/demo.txt"));
			byte[] data = FileUtils.readFileToByteArray(file);
			// Thiết lập thông tin trả về
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment; filename=" + file.getName());
			response.setContentLength(data.length);
			InputStream inputStream = new BufferedInputStream(new ByteArrayInputStream(data));
			FileCopyUtils.copy(inputStream, response.getOutputStream());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	@RequestMapping(value = "/download-slide", method = RequestMethod.GET)
	public void download2(HttpServletResponse response) throws IOException {
		try {
			File file = new File(context.getRealPath("/files/slide.pptx"));
			byte[] data = FileUtils.readFileToByteArray(file);
			// Thiết lập thông tin trả về
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment; filename=" + file.getName());
			response.setContentLength(data.length);
			InputStream inputStream = new BufferedInputStream(new ByteArrayInputStream(data));
			FileCopyUtils.copy(inputStream, response.getOutputStream());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
