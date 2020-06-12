package com.devmaster.mvc.jdbc;

import java.util.LinkedList;
import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.JQGridDTO;
import com.devmaster.mvc.entity.IdolsDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class IdolsJdbc {
	public JQGridDTO<IdolsDTO> listIdol(IdolsDTO searchDTO) {
		int total = -1;
		String strComm = "Select count(*) total from listIdol1 where (personId = ? or '"+ searchDTO.getPersonId() +"' ='') and (name = ? or '"+ searchDTO.getName() +"' ='')";
		SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getPersonId(), searchDTO.getName()});
		while(rs.next()) {
			total = rs.getInt("total");
		}
		
		
		strComm = "select * from (Select ROW_NUMBER() OVER (ORDER BY personId) AS RowNum , * from listIdol1 where (personId = ? or '"+ searchDTO.getPersonId() +"' ='') and (name like N'%"+ searchDTO.getName()+"%' or name like '%"+ searchDTO.getName()+"%' or '"+ searchDTO.getName() +"' ='')"
				+ ") t where RowNum between " + searchDTO.getStartIndex() + " and " + searchDTO.getEndIndex() + "order by "+ searchDTO.getSidx() + " " +searchDTO.getSord();
		rs = DBUtil.jdbcTemplate.queryForRowSet(strComm, new String[]{searchDTO.getPersonId()});
		List<IdolsDTO> listBranch = new LinkedList<IdolsDTO>();
		while(rs.next()) {
			IdolsDTO dto = new IdolsDTO();
			dto.setPersonId(rs.getString("personId"));
			dto.setName(rs.getString("name"));
			dto.setUserData(rs.getString("userData"));
			dto.setDiemDanh(rs.getString("diemDanh"));
			listBranch.add(dto);
		}
		
		JQGridDTO<IdolsDTO> jqGridData = new JQGridDTO<IdolsDTO>();
		jqGridData.setPage(searchDTO.getPage());
		jqGridData.setTotal(Math.round(total / searchDTO.getPageSize() + 1));
		jqGridData.setRecords(String.valueOf(total));
		jqGridData.setRows(listBranch);
		return jqGridData;
	}
//	public AjaxResponseBody createBranch(IdolsDTO postDTO) {
//		AjaxResponseBody obj = new AjaxResponseBody();
//		String strComm = "INSERT INTO listIdol1 values (?, ?, ?,?)";
//		try {
//			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getPersonId(), postDTO.getName(), postDTO.getDvTinh(),postDTO.getPhanTram()});
//			obj.setCode(Constant.CODE_SUCCESS);
//			obj.setMsg(Constant.MSG_SUCCESS);
//		} catch(Exception ex) {
//			obj.setCode("999");
//			obj.setMsg(ex.toString());
//		}
//		return obj;
		
//Đoạn code bên dưới sử dụng thủ tục SQL
//		try {
//			SimpleJdbcCall jdbcCall = new SimpleJdbcCall(DBUtil.jdbcTemplate)
//				.withProcedureName("SP_listIdol1_Update");
//
//			SqlParameterSource inParams = new MapSqlParameterSource()
//				.addValue("type", "1")
//				.addValue("Mavtu", postDTO.getPersionId())
//				.addValue("Tenvtu", postDTO.getName())
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
//	}
	public AjaxResponseBody updateIdols(IdolsDTO postDTO) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE listIdol1 SET  diemDanh = ? where personId = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getDiemDanh(),postDTO.getPersonId() });
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}

	
	public AjaxResponseBody updateIdols_API(String personId) {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE listIdol1 SET  diemDanh = N'Đã điểm danh' where personId = ?";
		try {
			DBUtil.jdbcTemplate.update(strComm, personId);
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
	
	public AjaxResponseBody resetDiemDanh() {
		AjaxResponseBody obj = new AjaxResponseBody();
		String strComm = "UPDATE listIdol1 SET  diemDanh = N'Chưa điểm danh'";
		try {
			DBUtil.jdbcTemplate.update(strComm);
			obj.setCode(Constant.CODE_SUCCESS);
			obj.setMsg(Constant.MSG_SUCCESS);
		} catch(Exception ex) {
			obj.setCode("999");
			obj.setMsg(ex.toString());
		}
		return obj;
	}
//	public AjaxResponseBody deleteBranch(IdolsDTO postDTO) {
//		AjaxResponseBody obj = new AjaxResponseBody();
//		String strComm = "DELETE FROM listIdol1  where MaVTu= ?";
//		try {
//			DBUtil.jdbcTemplate.update(strComm, new String[]{postDTO.getPersonId()});
//			obj.setCode(Constant.CODE_SUCCESS);
//			obj.setMsg(Constant.MSG_SUCCESS);
//		} catch(Exception ex) {
//			obj.setCode("999");
//			obj.setMsg(ex.toString());
//		}
//		return obj;
//	}
}
