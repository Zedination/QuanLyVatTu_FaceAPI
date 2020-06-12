package com.devmaster.mvc.jdbc;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.devmaster.mvc.entity.User;
import com.devmaster.mvc.util.DBUtil;

public class LoginJdbc {
	public String[] doLogin(User user) {
		String[] arrResult = new String[2];
		if(!DBUtil.IsConnected()) {
			DBUtil.initDB();
		}
		try {
			//String sql = "Select FullName, email from tblUser where username ='" + user.getUsername() +"' and password = '" + user.getPassword() + "'";
			String sql = "Select FullName from tblUser where username =? and password = ?";
			SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(sql, new String[] {user.getUsername(),user.getPassword()});
			int count = 0;
			while(rs.next()) {
				count = 1;
				arrResult[1] = rs.getString(1);
//				arrResult[2] = rs.getString("email");
//				System.out.println(arrResult[2]);
			}
			if (count == 0) {
				arrResult[0] = "Tên đăng nhập hoặc mật khẩu sai";
			} else {
				arrResult[0] = "Thành công";
			}
		} catch (Exception e) {
			arrResult[0]= e.toString();
		}
		return arrResult;
	}
	public String getEmail(String username) {
		String Email = "";
		if(!DBUtil.IsConnected()) {
			DBUtil.initDB();
		}
		try {
			String sql = "Select Email from tblUser where username =?";
			SqlRowSet rs = DBUtil.jdbcTemplate.queryForRowSet(sql,username);
			while(rs.next()) {
				Email = rs.getString(1);
			}
		}catch (Exception e) {
			Email = e.toString();
		}
		return Email;
	}
	public void khoiTao() {
		if(!DBUtil.IsConnected()) {
			DBUtil.initDB();
		}
	}
}
