package com.devmaster.mvc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.User;
import com.devmaster.mvc.jdbc.DoimatkhauJdbc;

@Controller
public class DoimatkhauController extends AbstractController {

	@RequestMapping("doimatkhau")
	public String viewDoiPass() {
		return "common/doimatkhau";
	}
	
	@RequestMapping("alert")
	public String alert() {
		return "common/alert";
	}
	
	@RequestMapping(value = "/doimatkhau", method = RequestMethod.POST)
	public String updatePass(Model model, HttpServletRequest request) {
		String pathReturn;
		User u = new User();
		u = (User)request.getSession().getAttribute("user");
		DoimatkhauJdbc passJdbc = new DoimatkhauJdbc();
		AjaxResponseBody response = new AjaxResponseBody();
		response.setCode("");
		String arr[] = passJdbc.check(u.getUsername(), request.getParameter("oldPass"));
		if("Thành công".equals(arr[0])) {
			String code = passJdbc.resetPass(arr[1], request.getParameter("newPass"));
			if("000".equals(code)) {
				pathReturn = "common/doiPassThanhCong";
			}else {
				response.setMsg("Có lỗi xảy ra trong quá trình đổi mật khẩu, vui lòng thử lại hoặc liên hệ với quản trị viên.");
				pathReturn = "common/doimatkhau";
			}
		}else {
			response.setMsg(arr[0]);
			pathReturn = "common/doimatkhau";
		}
		model.addAttribute("response", response);
		return pathReturn;
	}
}
