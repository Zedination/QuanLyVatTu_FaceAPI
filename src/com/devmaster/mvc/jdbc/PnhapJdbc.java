package com.devmaster.mvc.jdbc;

import java.util.LinkedList;
import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.CTPNhapDTO;
import com.devmaster.mvc.entity.PnhapDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;
import com.devmaster.mvc.util.JsonUtil;

public class PnhapJdbc {
	public JQGridDTO<PnhapDTO> listPhieuNhap(PnhapDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from PNHAP where (SoPn = ? or '"+ searchDTO.getSoPn() +"' ='') and (SoDH = ? or '"+ searchDTO.getSoDH() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPn(), searchDTO.getSoDH()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY SoPn) AS RowNum, "
				+ "soPn, convert(varchar,NgayNhap,103) NgayNhap, SoDH from PNHAP where (SoPn = ? or '"+ searchDTO.getSoPn() +"' ='') "
						+ "and (SoDH = ? or '"+ searchDTO.getSoDH() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex() + "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPn(), searchDTO.getSoDH()});
		List<PnhapDTO> listPhieuNhap = new LinkedList<PnhapDTO>();
		while(rs.next()) {
			PnhapDTO dto = new PnhapDTO();
			dto.setSoPn(rs.getString("SoPn"));
			dto.setNgayNhap(rs.getString("NgayNhap"));
			dto.setSoDH(rs.getString("SoDH"));
			listPhieuNhap.add(dto);
		}
		
		JQGridDTO<PnhapDTO> jqGridData = new JQGridDTO<PnhapDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listPhieuNhap);
		return jqGridData;
	}
	
	public JQGridDTO<CTPNhapDTO> listCTPN(CTPNhapDTO searchDTO) {
		int total = -1;

		String strComm = "Select count(*) total from CTPNHAP where SoPn = ?";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPN()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY SoPn) AS RowNum, * from CTPNHAP where SoPn = ?"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getSoPN()});
		List<CTPNhapDTO> listPhieuNhap = new LinkedList<CTPNhapDTO>();
		while(rs.next()) {
			CTPNhapDTO dto = new CTPNhapDTO();
			dto.setSoPN(rs.getString("SoPn"));
			dto.setMaVTu(rs.getString("Mavtu"));
			dto.setsLNhap(rs.getString("SLNhap"));
			dto.setdGNhap(rs.getString("DGNhap"));
			listPhieuNhap.add(dto);
		}
		
		JQGridDTO<CTPNhapDTO> jqGridData = new JQGridDTO<CTPNhapDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listPhieuNhap);
		return jqGridData;
	}
	
	
	public AjaxResponseBody createPnhap(PnhapDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO PNHAP values (?, convert(date,?, 103), ?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPn(),postDTO.getNgayNhap(), postDTO.getSoDH()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody createCTPN(CTPNhapDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO CTPNHAP values (?, ?, ?,?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPN(),postDTO.getMaVTu(), postDTO.getsLNhap(),postDTO.getdGNhap()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updatePnhap(PnhapDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE PNHAP SET NgayNhap=convert(date, ?,103), SoDH=? where SoPn= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getNgayNhap(), postDTO.getSoDH(), postDTO.getSoPn()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody updateCTPN(CTPNhapDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE CTPNHAP SET SLNhap=?, DGNhap = ? where SoPn= ? and Mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{ postDTO.getsLNhap(), postDTO.getdGNhap(), postDTO.getSoPN(), postDTO.getMaVTu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody deletePnhap(PnhapDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String delChiTiet = "DELETE FROM CTPNHAP where SoPn= ?";
		try {
			DBUtil.jdbcTemplate.update(delChiTiet, new String[]{postDTO.getSoPn()});
			String strComm = "DELETE FROM PNHAP where SoPn= ?";
			try {
				DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPn()});
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
	
	public AjaxResponseBody deleteCTPN(CTPNhapDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE FROM CTPNHAP where SoPn= ? and Mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSoPN(), postDTO.getMaVTu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}
