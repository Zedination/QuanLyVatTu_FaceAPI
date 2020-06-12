package com.devmaster.mvc.controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
@Controller
public class GameController {
	@RequestMapping(value = "/floppybird")
	public String floppybird() {
		return "game/floppybird";
	}
	@RequestMapping(value = "/2048")
	public String G2048() {
		return "game/2048";
	}
	@RequestMapping(value = "/munder")
	public String Munder() {
		return "game/munder";
	}
	@RequestMapping(value = "/trap-adventure-2")
	public String Trap() {
		return "game/trap";
	}
}
