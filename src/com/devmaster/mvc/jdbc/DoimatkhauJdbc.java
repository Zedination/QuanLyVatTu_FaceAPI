package com.devmaster.mvc.jdbc;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.util.DBUtil;

public class DoimatkhauJdbc {
	public String[] check(String username,String pass) {
		String arrResult[] = new String[2];
		try {
			String sql = "Select username from tblUser where username = '"+username+"' and password = '"+pass+"'";
			SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(sql);
			int count = 0;
			while(rs.next()) {
				count = 1;
				arrResult[1] = rs.getString(1);
			}
			if (count == 0) {
				arrResult[0] = "Mật khẩu cũ sai";
			} else {
				arrResult[0] = "Thành công";
			}
		} catch (Exception e) {
			arrResult[0]= e.toString();
		}
		return arrResult;		
	}
	public String resetPass(String username,String newpass) {
		String code;
		try {
			String sql = "update tblUser set password = '"+newpass+"' where username = '"+username+"'";
			DBUtil.jdbcTemplate.update(sql);
			code = "000";
		}catch (Exception e) {
			code = "999";
		}
		return code;
	}
}
