package com.devmaster.mvc.jdbc;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.TonKhoDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class TonKhoJdbc {
	public JQGridDTO<TonKhoDTO> listTonKho(TonKhoDTO searchDTO) {
		int total = -1;
		String strComm = "Select count(*) total from TONKHO where (mavtu = ? or '"+ searchDTO.getMavtu() +"' ='') and (NamThang = ? or '"+ searchDTO.getNamThang() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getMavtu(), searchDTO.getNamThang()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY mavtu) AS RowNum , * from TONKHO where (mavtu like '%"+ searchDTO.getMavtu() +"' or '"+ searchDTO.getMavtu() +"' ='') and (NamThang like '%"+ searchDTO.getNamThang()+"%' or '"+ searchDTO.getNamThang() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex() + "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm);
		List<TonKhoDTO> listBranch = new LinkedList<TonKhoDTO>();
		while(rs.next()) {
			TonKhoDTO dto = new TonKhoDTO();
			dto.setNamThang(rs.getString("NamThang"));
			dto.setMavtu(rs.getString("Mavtu"));
			dto.setSLDau(rs.getString("SLDau"));
			dto.setTongSLN(rs.getString("TongSLN"));
			dto.setTongSLX(rs.getString("TongSLX"));
			dto.setSLCuoi(rs.getString("SLCuoi"));
			listBranch.add(dto);
		}
		
		JQGridDTO<TonKhoDTO> jqGridData = new JQGridDTO<TonKhoDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listBranch);
		return jqGridData;
	}
	public AjaxResponseBody createTonKho(TonKhoDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO TONKHO values (?, ?, ?, ?, ?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getNamThang(),postDTO.getMavtu(), postDTO.getSLDau(), postDTO.getTongSLN(),postDTO.getTongSLX()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
		
	}
	public AjaxResponseBody updateTonKho(TonKhoDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE TONKHO SET  SLDau = ?,TongSLN =?, TongSLX = ? where mavtu= ? and NamThang = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getSLDau(), postDTO.getTongSLN(), postDTO.getTongSLX(),postDTO.getMavtu(),postDTO.getNamThang() });
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	public AjaxResponseBody deleteTonKho(TonKhoDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE TONKHO  where NamThang= ? and Mavtu = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getNamThang(), postDTO.getMavtu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}

