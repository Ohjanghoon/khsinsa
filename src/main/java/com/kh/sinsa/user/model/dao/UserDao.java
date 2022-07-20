package com.kh.sinsa.user.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import static com.kh.sinsa.common.JdbcTemplate.*;

import com.kh.sinsa.user.model.dto.Del;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.dto.UserRole;
import com.kh.sinsa.user.model.exception.UserException;

public class UserDao {
	private Properties prop = new Properties();

	public UserDao() {
		String filename = UserDao.class.getResource("/sql/user/user-query.properties").getPath();

		try {
			prop.load(new FileReader(filename));

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// ##########minseo UserDao begin#############
	/**
	 * DQL요청 - dao 1. PreparedStatement객체 생성 (sql전달) & 값대입 2. 쿼리실행 executeQuery -
	 * ResultSet 반환 3. ResultSet처리 - dto객체 변환 4. ResulstSet, PreparedStatement객체 반환
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

//		findById = select * from kh_user where user_id = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				user = handleUserResultSet(rset);
			}
		} catch (Exception e) {
			throw new UserException("회원 아이디 조회 오류", e);

		} finally {
			close(rset);
			close(pstmt);
		}

		return user;
	}

	private User handleUserResultSet(ResultSet rset) throws SQLException {
		String userId = rset.getString("user_id"); // 왼쪽은 자바 오른쪽은 sql
		Timestamp enrollDate = rset.getTimestamp("enroll_date");
		String userName = rset.getString("user_name");
		String userPwd = rset.getString("user_pwd");
		String userPhone = rset.getString("user_phone");
		Date userBirthday = rset.getDate("user_birthday");
		String userEmail = rset.getString("user_email");
		String userAddress = rset.getString("user_address");
		Del userDel = Del.valueOf(rset.getString("user_del"));
		UserRole userRole = UserRole.valueOf(rset.getString("user_role"));
		return new User(userId, userPwd, userName, userRole, userBirthday, userDel, userEmail, userPhone, userAddress,
				enrollDate);

	}

	public int editUser(Connection conn, User user) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("editUser");
//		editUser = update user set  user_name = ?, birthday = ?,  phone = ?, email = ?, address = ? where user_id = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserName());
			pstmt.setDate(2, user.getUserBirthday());
			pstmt.setString(3, user.getUserPhone());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserAddress());
			pstmt.setString(6, user.getUserId());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// service 예외 던짐(unchecked, 비지니스를 설명가능한 구체적 커스텀예외 전환)
			throw new UserException("회원정보수정 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	// ##########minseo UserDao end#############

	// ##########janghoon UserDao begin#############
	// ----------------------회원가입----------------------
	public int insertUser(Connection conn, User user) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertUser");
		// insertUser = insert into kh_user values (?, default, ?, ?, ?, ?, ?, ?,
		// default, default)
		// (1)user_id, enroll_date, (2)user_name, (3)user_pwd, (4)user_phone,
		// (5)user_birthday, (6)user_email, (7)user_address, user_del, user_role)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserName());
			pstmt.setString(3, user.getUserPwd());
			pstmt.setString(4, user.getUserPhone());
			pstmt.setDate(5, user.getUserBirthday());
			pstmt.setString(6, user.getUserEmail());
			pstmt.setString(7, user.getUserAddress());

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new UserException("회원가입 오류", e);
		} finally {
			close(pstmt);
		}

		return result;
	}
	// ##########janghoon UserDao end#############

}
