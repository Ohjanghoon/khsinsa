package com.kh.sinsa.user.model.service;

import java.sql.Connection;

import com.kh.sinsa.user.model.dao.UserDao;
import com.kh.sinsa.user.model.dto.User;
import static com.kh.sinsa.common.JdbcTemplate.*;

public class UserService {
	private UserDao userDao = new UserDao();
	
	//##########minseo UserService begin#############
	/**
	 * DQL요청 - service
	 * 1. Connection객체 생성
	 * 2. Dao 요청 & Connection 전달
	 * 3. Connection 반환(close)
	 * 
	 * @param memberId
	 * @return
	 */

	public User findById(String userId) {
		Connection conn = getConnection();
		User user =userDao.findById(conn, userId);
		close(conn);
		
		return user;
	}
	//##########minseo UserService end#############
	
	
	//##########janghoon UserService begin#############
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
		//##########janghoon UserService end#############
}
