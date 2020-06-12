package com.devmaster.mvc.controller;

import javax.servlet.http.HttpServletRequest;

import com.devmaster.mvc.entity.BaseDTO;
import com.sun.deploy.uitoolkit.impl.fx.Utils;

public class AbstractController {

	protected void initGetDTO(BaseDTO baseDTO, HttpServletRequest request) {
		int page = Integer.valueOf(request.getParameter("currentPage")).intValue();
		int pageSize = Integer.valueOf(request.getParameter("rowPerPage")).intValue();
		int startIndex = page == 1 ? 0 : (pageSize * (page - 1));
		int endIndex = page == 1 ? pageSize : pageSize * page;
		baseDTO.setPage(page);
		baseDTO.setPageSize(pageSize);
		baseDTO.setStartIndex(startIndex);
		baseDTO.setEndIndex(endIndex);
		baseDTO.setSidx(request.getParameter("sidx"));
		baseDTO.setSord(request.getParameter("sord")==null? "ASC": request.getParameter("sord"));
	}

}