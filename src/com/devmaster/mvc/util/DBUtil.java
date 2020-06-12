package com.devmaster.mvc.util;

import java.sql.CallableStatement;
import java.sql.Connection;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

public class DBUtil {
	public static String db_url;
	public static String db_username;
	public static String db_password;

	public static JdbcTemplate jdbcTemplate;

	private static boolean isConnected;
	private static final String driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

	public static void configure(String url, String userName, String password) {
		db_url = url;
		db_username = userName;
		db_password = password;
	}
	
	private static DriverManagerDataSource getDMDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(db_url);
		dataSource.setUsername(db_username);
		dataSource.setPassword(db_password);

		return dataSource;
	}

	public static boolean IsConnected() {
		return isConnected;
	}

	public static void initDB(){
		try {
			jdbcTemplate  = new JdbcTemplate(getDMDataSource());
			String sqlCall = " select 1 ";
			Connection conn = jdbcTemplate.getDataSource().getConnection();
			CallableStatement cs = conn.prepareCall(sqlCall);
			cs.execute();
			
			isConnected = true;
		} catch (Exception ex) {
			System.err.println("Cannot connect to DataBase: " + ex.toString());
			isConnected = false;
		}
	}

}
