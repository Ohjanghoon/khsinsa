package com.kh.sinsa.user.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.commit;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;
import static com.kh.sinsa.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.user.model.dao.UserDao;
import com.kh.sinsa.user.model.dto.User;

import static com.kh.sinsa.common.JdbcTemplate.*;

public class UserService {
	private UserDao userDao = new UserDao();

	// ##########minseo UserService begin#############
	/**
	 * DQL요청 - service 1. Connection객체 생성 2. Dao 요청 & Connection 전달 3. Connection
	 * 반환(close)
	 * 
	 * @param memberId
	 * @return
	 */

	public User findById(String userId) {
		Connection conn = getConnection();
		User user = userDao.findById(conn, userId);
		close(conn);

		return user;
	}

	public int editUser(User user) {
		Connection conn = getConnection();
		int result = 0;
		try {
//			result = userDao.editSUser(conn, user);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; // controller에 예외 던짐.
		} finally {
			close(conn);
		}
		return result;
	}

	// ##########minseo UserService end#############

	// ##########janghoon UserService begin#############

	public int insertUser(User user) {
		Connection conn = getConnection();
		int result = 0;

		try {
			result = userDao.insertUser(conn, user);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	// ##########janghoon UserService end#############

	
}


