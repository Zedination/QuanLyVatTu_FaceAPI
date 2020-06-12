package com.devmaster.mvc.jdbc;

import java.util.LinkedList;
import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.CTPXuatDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.PXuatDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class PXuatJdbc {
	public JQGridDTO<PXuatDTO> listPhieuXuat(PXuatDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from PXUAT where (SoPx = ? or '"+ searchDTO.getSoPX() +"' ='') and (TenKH = ? or '"+ searchDTO.getTenKH() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPX(), searchDTO.getTenKH()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY SoPx) AS RowNum, "
				+ "soPx, convert(varchar,NgayXuat,103) Ngayxuat, TenKH from PXUAT where (SoPx = ? or '"+ searchDTO.getSoPX() +"' ='') "
						+ "and (TenKH = ? or '"+ searchDTO.getTenKH() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex() + "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPX(), searchDTO.getTenKH()});
		List<PXuatDTO> listPhieuNhap = new LinkedList<PXuatDTO>();
		while(rs.next()) {
			PXuatDTO dto = new PXuatDTO();
			dto.setSoPX(rs.getString("SoPx"));
			dto.setNgayXuat(rs.getString("NgayXuat"));
			dto.setTenKH(rs.getString("TenKH"));
			listPhieuNhap.add(dto);
		}
		
		JQGridDTO<PXuatDTO> jqGridData = new JQGridDTO<PXuatDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listPhieuNhap);
		return jqGridData;
	}
	
	public JQGridDTO<CTPXuatDTO> listCTPX(CTPXuatDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from CTPXUAT where SoPx = ?";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPX()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY SoPx) AS RowNum, * from CTPXUAT where SoPx = ?"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPX()});
		List<CTPXuatDTO> listPhieuXuat = new LinkedList<CTPXuatDTO>();
		while(rs.next()) {
			CTPXuatDTO dto = new CTPXuatDTO();
			dto.setSoPX(rs.getString("SoPx"));
			dto.setMaVTu(rs.getString("Mavtu"));
			dto.setsLXuat(rs.getString("SLXuat"));
			dto.setdGXuat(rs.getString("DGXuat"));
			listPhieuXuat.add(dto);
		}
		
		JQGridDTO<CTPXuatDTO> jqGridData = new JQGridDTO<CTPXuatDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listPhieuXuat);
		return jqGridData;
	}
	
	
	public AjaxResponseBody createPXuat(PXuatDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO PXUAT values (?, convert(date,?, 103), ?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPX(),postDTO.getNgayXuat(), postDTO.getTenKH()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody createCTPX(CTPXuatDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO CTPXUAT values (?, ?, ?,?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPX(),postDTO.getMaVTu(), postDTO.getsLXuat(),postDTO.getdGXuat()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updatePXuat(PXuatDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE PXUAT SET NgayXuat=convert(date, ?,103), TenKH=? where SoPx= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getNgayXuat(), postDTO.getTenKH(), postDTO.getSoPX()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updateCTPX(CTPXuatDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE CTPXUAT SET SLXuat=?, DGXuat = ? where SoPx= ? and Mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{ postDTO.getsLXuat(), postDTO.getdGXuat(), postDTO.getSoPX(), postDTO.getMaVTu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody deletePX(PXuatDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String delChiTiet = "DELETE FROM CTPXUAT where SoPx= ?";
		try {
			DBUtil.jdbcTemplate.update(delChiTiet, new String[]{postDTO.getSoPX()});
			String strComm = "DELETE FROM PXUAT where SoPx= ?";
			try {
				DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPX()});
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
	
	public AjaxResponseBody deleteCTPX(CTPXuatDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE FROM CTPXUAT where SoPx= ? and Mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPX(), postDTO.getMaVTu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}
