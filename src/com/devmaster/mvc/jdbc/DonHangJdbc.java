package com.devmaster.mvc.jdbc;


import java.util.LinkedList;
import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.CTDonHangDTO;
import com.devmaster.mvc.entity.DonHangDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;
import com.devmaster.mvc.util.JsonUtil;

public class DonHangJdbc {

	public JQGridDTO<DonHangDTO> listDonHang(DonHangDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from DONDH where (SoDH = ? or '"+ searchDTO.getSodh() +"' ='') and (MaNCC = ? or '"+ searchDTO.getMancc() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSodh(), searchDTO.getMancc()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY SoDH) AS RowNum, "
				+ "sodh, convert(varchar,ngaydh,103) ngaydh, mancc from DONDH where (SoDH = ? or '"+ searchDTO.getSodh() +"' ='') "
						+ "and (MaNCC = ? or '"+ searchDTO.getMancc() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex() + "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSodh(), searchDTO.getMancc()});
		List<DonHangDTO> listDonHang = new LinkedList<DonHangDTO>();
		while(rs.next()) {
			DonHangDTO dto = new DonHangDTO();
			dto.setSodh(rs.getString("sodh"));
			dto.setNgaydh(rs.getString("ngaydh"));
			dto.setMancc(rs.getString("mancc"));
			listDonHang.add(dto);
		}
		
		JQGridDTO<DonHangDTO> jqGridData = new JQGridDTO<DonHangDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listDonHang);
		return jqGridData;
	}
	
	public JQGridDTO<CTDonHangDTO> listCTDH(CTDonHangDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from CTDONDH where SoDH = ?";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSodh()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY SoDH) AS RowNum, * from CTDONDH where SoDH = ?"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSodh()});
		List<CTDonHangDTO> listDonHang = new LinkedList<CTDonHangDTO>();
		while(rs.next()) {
			CTDonHangDTO dto = new CTDonHangDTO();
			dto.setSodh(rs.getString("sodh"));
			dto.setMavtu(rs.getString("mavtu"));
			dto.setSldat(rs.getString("sldat"));
			listDonHang.add(dto);
		}
		
		JQGridDTO<CTDonHangDTO> jqGridData = new JQGridDTO<CTDonHangDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listDonHang);
		return jqGridData;
	}
	
	public String getListMaNCC() {
		StringBuilder xml = new StringBuilder("<xml>");
		String strComm = "Select * from NHACC";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm);
		while(rs.next()) {
			String mancc =rs.getString(1);
			String tenncc = JsonUtil.toHTML(rs.getString(2));
			xml.append("<option><value>" + mancc + "</value><text>" + mancc +"-"+tenncc + "</text></option>");
		}
		xml.append("</xml>");
		return xml.toString();
	}
	public String getListMavtu() {
		StringBuilder xml = new StringBuilder("<xml>");
		String strComm = "Select * from VATTU";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm);
		while(rs.next()) {
			String mavtu =rs.getString(1);
			String tenvtu = JsonUtil.toHTML(rs.getString(2));
			xml.append("<option><value>" + mavtu + "</value><text>" + mavtu +"-"+tenvtu + "</text></option>");
		}
		xml.append("</xml>");
		return xml.toString();
	}
	
	public AjaxResponseBody createSODH(DonHangDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO DONDH values (?, convert(date,?, 103), ?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSodh(),postDTO.getNgaydh(), postDTO.getMancc()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody createCTDH(CTDonHangDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO CTDONDH values (?, ?, ?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSodh(),postDTO.getMavtu(), postDTO.getSldat()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updateDONDH(DonHangDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE DONDH SET ngaydh=convert(date, ?,103), mancc=? where sodh= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getNgaydh(), postDTO.getMancc(), postDTO.getSodh()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updateCTDH(CTDonHangDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE CTDONDH SET SlDat=? where Sodh= ? and Mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{ postDTO.getSldat(), postDTO.getSodh(), postDTO.getMavtu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody deleteDONDH(DonHangDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String delChiTiet = "DELETE FROM CTDONDH where sodh= ?";
		try {
			DBUtil.jdbcTemplate.update(delChiTiet, new String[]{postDTO.getSodh()});
			String strComm = "DELETE FROM DONDH where sodh= ?";
			try {
				DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSodh()});
				obj.setCode(Constant.CODE_SUCCESS);
				obj.setMsg(Constant.MSG_SUCCESS);
			} catch(Exception ex) {
				obj.setCode("999");
				obj.setMsg(ex.toString());
			}
			
		} catch(Exception e) {
			obj.setCode("999");
			obj.setMsg(e.toString());
		}
		
		return obj;
	}
	
	public AjaxResponseBody deleteCTDH(CTDonHangDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE FROM CTDONDH where sodh= ? and mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSodh(), postDTO.getMavtu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}
