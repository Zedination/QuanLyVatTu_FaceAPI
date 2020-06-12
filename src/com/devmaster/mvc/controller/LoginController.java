package com.devmaster.mvc.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.User;
import com.devmaster.mvc.jdbc.LoginJdbc;
import com.devmaster.mvc.model.UserValidator;
import com.devmaster.mvc.util.Constant;

@Controller
public class LoginController {
	private User user = new User();
	@GetMapping("/")
	public String viewFirst(HttpServletRequest request,Map<String, Object> model) {
		model.put("userForm", user);
		if(request.getSession().getAttribute("user")==null) {
			return "common/login";
		}else {
			return "redirect:/main";
		}
	}
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String viewLogin(Map<String, Object> model) {
		model.put("userForm", user);
		return "common/login";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String viewMain(Map<String, Object> model) {
		model.put("userForm", user);
		return "common/main";
	}
	
	@RequestMapping("/login-facebook")
	public String loginFacebook(HttpServletRequest request) {
		LoginJdbc initConnect = new LoginJdbc();
		initConnect.khoiTao();
		String code = request.getParameter("code");
		System.out.println(code);
		
		System.out.println(code);
		if (code == null || code.isEmpty()) {
			return "redirect:/login?message=facebook_error";
		}else {
			User userfb = new User();
			userfb.setFullName("Guest-facebook");
			request.getSession().setAttribute("user", userfb);
			return "redirect:/main";
		}
	}
	
	@RequestMapping("/login-google")
	public String loginGoogle(HttpServletRequest request) {
		LoginJdbc initConnect = new LoginJdbc();
		initConnect.khoiTao();
		String code = request.getParameter("code");
		System.out.println(code);
		if (code == null || code.isEmpty()) {
			return "redirect:/login?message=google_error";
		}else {
			User usergg = new User();
			usergg.setFullName("Guest-Google");
			request.getSession().setAttribute("user", usergg);
			return "redirect:/main";
		}
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String doLogin(@Valid @ModelAttribute("userForm") User userForm, BindingResult result,
			Map<String, Object> model, HttpServletRequest request) {

		UserValidator userValidator = new UserValidator();
		userValidator.validate(userForm, result);

		AjaxResponseBody response = new AjaxResponseBody();
		String pathReturn = "";
		if (result.hasErrors()) {
			response.setCode("ERR01");
			response.setMsg("Lỗi validate dữ liệu!");

			pathReturn = "common/login";
		} else {
			LoginJdbc loginjdbc = new LoginJdbc();
			String[] arrResult = loginjdbc.doLogin(userForm);
			response.setCode("");
			if ("Thành công".equals(arrResult[0])) {
				userForm.setFullName(arrResult[1]);
				userForm.setEmail(loginjdbc.getEmail(userForm.getUsername()));
				request.getSession().setAttribute("user", userForm);
				pathReturn = "redirect:/main";
			} else {
				response.setMsg(arrResult[0]);
				pathReturn = "common/login";
			}
		}
		model.put("response", response);
		return pathReturn;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, Map<String, Object> model) {
		model.put("userForm", user);
		try {
			Enumeration<?> names = request.getSession().getAttributeNames();
			while (names.hasMoreElements()) {
				String attrName = (String) names.nextElement();
				request.getSession().setAttribute(attrName, null);
			}
		} catch (Exception e) {

		}
		return "common/login";
	}
}
