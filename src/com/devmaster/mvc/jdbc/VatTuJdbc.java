package com.devmaster.mvc.jdbc;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.VatTuDTO;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class VatTuJdbc {
	public JQGridDTO<VatTuDTO> listVatTu(VatTuDTO searchDTO) {
		int total = -1;
		String strComm = "Select count(*) total from VATTU where (mavtu = ? or '"+ searchDTO.getMaVtu() +"' ='') and (tenvtu = ? or '"+ searchDTO.getTenVtu() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getMaVtu(), searchDTO.getTenVtu()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY mavtu) AS RowNum , * from VATTU where (mavtu = ? or '"+ searchDTO.getMaVtu() +"' ='') and (tenvtu like '%"+ searchDTO.getTenVtu()+"%' or '"+ searchDTO.getTenVtu() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex() + "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getMaVtu()});
		List<VatTuDTO> listBranch = new LinkedList<VatTuDTO>();
		while(rs.next()) {
			VatTuDTO dto = new VatTuDTO();
			dto.setMaVtu(rs.getString("mavtu"));
			dto.setTenVtu(rs.getString("tenvtu"));
			dto.setDvTinh(rs.getString("dvtinh"));
			dto.setPhanTram(rs.getString("phantram"));
			listBranch.add(dto);
		}
		
		JQGridDTO<VatTuDTO> jqGridData = new JQGridDTO<VatTuDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listBranch);
		return jqGridData;
	}
	public AjaxResponseBody createBranch(VatTuDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "INSERT INTO VATTU values (?, ?, ?,?)";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getMaVtu(), postDTO.getTenVtu(), postDTO.getDvTinh(),postDTO.getPhanTram()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
		
//Đoạn code bên dưới sử dụng thủ tục SQL
//		try {
//			SimpleJdbcCall jdbcCall = new SimpleJdbcCall(DBUtil.jdbcTemplate)
//				.withProcedureName("SP_VATTU_Update");
//
//			SqlParameterSource inParams = new MapSqlParameterSource()
//				.addValue("type", "1")
//				.addValue("Mavtu", postDTO.getMaVtu())
//				.addValue("Tenvtu", postDTO.getTenVtu())
//				.addValue("Dvtinh", postDTO.getDvTinh())
//				.addValue("Phantram", postDTO.getPhanTram());
//			Map<String, Object> map = jdbcCall.execute(inParams);
//			String errorCode = map.get("RESULT").toString(); //entry_hold
//			String errorDesc = map.get("ERROR").toString(); // message
//			obj.setCode(errorCode);
//			obj.setMsg(errorDesc);
//		} catch (Exception ex) {
//			obj.setCode("999");
//			obj.setMsg(ex.getMessage());
//		}
//		return obj;
	}
	public AjaxResponseBody updateVatTu(VatTuDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE VATTU SET  tenvtu = ?,dvtinh =?, phantram = ? where mavtu= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getTenVtu(), postDTO.getDvTinh(), postDTO.getPhanTram(),postDTO.getMaVtu() });
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	public AjaxResponseBody deleteBranch(VatTuDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "DELETE FROM VATTU  where MaVTu= ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getMaVtu()});
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
}

