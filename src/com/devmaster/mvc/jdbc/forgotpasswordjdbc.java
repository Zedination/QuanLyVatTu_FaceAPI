package com.devmaster.mvc.jdbc;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.User;
import com.devmaster.mvc.util.DBUtil;

public class forgotpasswordjdbc {
	public String[] check(User user) {
		String arrResult[] = new String[2];
		if(!DBUtil.IsConnected()) {
			DBUtil.initDB();
		}
		try {
			String sql = "Select username from tblUser where email = '"+user.getEmail()+"'";
			SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(sql);
			int count = 0;
			while(rs.next()) {
				count = 1;
				arrResult[1] = rs.getString(1);
			}
			if (count == 0) {
				arrResult[0] = "Không tìm thấy Email này trong hệ thống.";
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
