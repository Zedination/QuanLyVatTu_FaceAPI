package com.devmaster.mvc.jdbc;


import java.util.LinkedList;
import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.BaseDTO;
import com.devmaster.mvc.entity.NhaCCDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class NhaccJdbc {

	public JQGridDTO<NhaCCDTO> listNhacc(NhaCCDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from NHACC where (MaNCC = ? or '"+ searchDTO.getMaNCC() +"' ='') and (TenNCC = ? or '"+ searchDTO.getTenNCC() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getMaNCC(), searchDTO.getTenNCC()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY MaNCC) AS RowNum, * from NHACC where (MaNCC = ? or '"+ searchDTO.getMaNCC() +"' ='') and (TenNCC like '%"+searchDTO.getTenNCC()+"%' or '"+ searchDTO.getTenNCC() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex()+ "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getMaNCC()});
		List<NhaCCDTO> listNhacc = new LinkedList<NhaCCDTO>();
		while(rs.next()) {
			NhaCCDTO dto = new NhaCCDTO();
			dto.setMaNCC(rs.getString("MaNCC"));
			dto.setTenNCC(rs.getString("TenNCC"));
			dto.setDiaChi(rs.getString("Diachi"));
			dto.setDienThoai(rs.getString("Dienthoai"));
			listNhacc.add(dto);
		}
		
		JQGridDTO<NhaCCDTO> jqGridData = new JQGridDTO<NhaCCDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listNhacc);
		return jqGridData;
	}
	
	public AjaxResponseBody createNCC(NhaCCDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO NHACC values (?, ?, ?,?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getMaNCC(), postDTO.getTenNCC(), postDTO.getDiaChi(),postDTO.getDienThoai()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updateNCC(NhaCCDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE NHACC SET TenNCC= ?, Diachi = ?,Dienthoai=? where MaNCC= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getTenNCC(), postDTO.getDiaChi(), postDTO.getDienThoai(),postDTO.getMaNCC()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody deleteNCC(NhaCCDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE FROM NHACC where MaNCC= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getMaNCC()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}
