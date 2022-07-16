package com.kh.sinsa.user.model.dao;

import java.io.FileReader;
import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import static com.kh.sinsa.common.JdbcTemplate.*;

import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.exception.UserException;

public class UserDao {
	private Properties prop = new Properties();
	
	public UserDao(){
		String filename = UserDao.class.getResource("/sql/user/user-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filename));
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	

	/**
	 * DQL요청 - dao
	 * 1. PreparedStatement객체 생성 (sql전달) & 값대입
	 * 2. 쿼리실행 executeQuery - ResultSet 반환
	 * 3. ResultSet처리 - dto객체 변환
	 * 4. ResulstSet, PreparedStatement객체 반환 
	 * 
	 * @param conn
	 * @param memberId
	 * @return
	 */

	public User findById(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		User user = null;
		String sql = prop.getProperty("findById");
		// select * from member where member_id = ?
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,userId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				user = handleUserResultSet(rset);			
			}
		} catch (Exception e) {
			throw new UserException("회원 아이디 조회 오류",e);
			
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return user;
	}


	private User handleUserResultSet(ResultSet rset) {
		// TODO Auto-generated method stub
		return null;
	}
	

		
		
	}

	

