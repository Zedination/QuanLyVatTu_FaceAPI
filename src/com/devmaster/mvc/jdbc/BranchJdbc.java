package com.devmaster.mvc.jdbc;


import java.util.LinkedList;
import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.BaseDTO;
import com.devmaster.mvc.entity.BranchDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class BranchJdbc {

	public JQGridDTO<BranchDTO> listBranch(BranchDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from tblBranch where (branchcode = ? or '"+ searchDTO.getBranchCode() +"' ='') and (branchname = ? or '"+ searchDTO.getBranchName() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getBranchCode(), searchDTO.getBranchName()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY branchcode) AS RowNum, * from tblBranch where (branchcode = ? or '"+ searchDTO.getBranchCode() +"' ='') and (branchname = ? or '"+ searchDTO.getBranchName() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getBranchCode(), searchDTO.getBranchName()});
		List<BranchDTO> listBranch = new LinkedList<BranchDTO>();
		while(rs.next()) {
			BranchDTO dto = new BranchDTO();
			dto.setBranchCode(rs.getString("BranchCode"));
			dto.setBranchName(rs.getString("BranchName"));
			dto.setLocation(rs.getString("Location"));
			listBranch.add(dto);
		}
		
		JQGridDTO<BranchDTO> jqGridData = new JQGridDTO<BranchDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listBranch);
		return jqGridData;
	}
	
	public AjaxResponseBody createBranch(BranchDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO tblBranch values (?, ?, ?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getBranchCode(), postDTO.getBranchName(), postDTO.getLocation()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updateBranch(BranchDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE tblBranch SET branchname= ?, location = ? where branchcode= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getBranchName(), postDTO.getLocation(), postDTO.getBranchCode()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody deleteBranch(BranchDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE FROM tblBranch where branchcode= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getBranchCode()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}
