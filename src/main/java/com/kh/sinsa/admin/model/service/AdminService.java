package com.kh.sinsa.admin.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.admin.model.dao.AdminDao;
import com.kh.sinsa.user.model.dto.User;

public class AdminService {

	private AdminDao adminDao = new AdminDao();
	
	// ##########jaekyung UserService begin#############

	public List<User> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<User> list = adminDao.findAll(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = adminDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public List<User> findUserLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<User> list = adminDao.findUserLike(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContentLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalContent = adminDao.getTotalContentLike(conn, param);
		close(conn);
		return totalContent;
	}
	// ##########jaekyung UserService end#############
}
