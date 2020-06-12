package com.devmaster.mvc.jdbc;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import com.devmaster.mvc.entity.AjaxResponseBody;
import com.devmaster.mvc.entity.UserDTO;
import com.devmaster.mvc.util.Constant;
import com.devmaster.mvc.util.DBUtil;

public class SignupJdbc {
	public AjaxResponseBody createUser(UserDTO postDTO) {
		if(!DBUtil.IsConnected()) {
			DBUtil.initDB();
		}
		AjaxResponseBody obj = new AjaxResponseBody();
		System.out.println(postDTO.getFullname());
		String strComm = "INSERT INTO tblUser (username,password,FullName,Email) values ('"+postDTO.getUsername()+"','"+postDTO.getPassword()+"',N'"+ postDTO.getFullname()+"','"+postDTO.getEmail()+"')";
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
}
