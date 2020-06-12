package com.devmaster.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChartController extends AbstractController{
		@RequestMapping("/chart")
		public String viewChart() {
			return "common/chart";
		}
		@RequestMapping("/404")
		public String view404() {
			return "common/404";
		}
		@RequestMapping("/500")
		public String view500() {
			return "common/500";
		}
}
