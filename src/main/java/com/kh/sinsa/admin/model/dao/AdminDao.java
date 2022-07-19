package com.kh.sinsa.admin.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.close;

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

import com.kh.sinsa.user.model.dao.UserDao;
import com.kh.sinsa.user.model.dto.Del;
import com.kh.sinsa.user.model.dto.User;
import com.kh.sinsa.user.model.dto.UserRole;
import com.kh.sinsa.user.model.exception.UserException;

public class AdminDao {

	private Properties prop = new Properties();

	public AdminDao() {
		String filename = UserDao.class.getResource("/sql/user/admin-query.properties").getPath();

		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	
	// ##########jaekyung UserDao begin#############

	public List<User> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<User> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();

			while (rset.next()) {
				User user = handleUserResultSet(rset);
				list.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContent");

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if (rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new UserException("전체회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContent;
	}

	public List<User> findUserLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<User> list = new ArrayList<>();
		String sql = prop.getProperty("findUserLike");
		// select * from ( select row_number () over (order by enroll_date desc) rnum,
		// u.* from kh_user u where # like ?) u where rnum between ? and ?
		String col = (String) param.get("searchType");
		String val = (String) param.get("searchKeyword");
		int start = (int) param.get("start");
		int end = (int) param.get("end");

		sql = sql.replace("#", col);
		System.out.println(sql);

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + val + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rset = pstmt.executeQuery();
			while (rset.next())
				list.add(handleUserResultSet(rset));

		} catch (SQLException e) {
			throw new UserException("관리자 회원검색 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getTotalContentLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContentLike");
		String col = (String) param.get("searchType");
		String val = (String) param.get("searchKeyword");
		sql = sql.replace("#", col);

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + val + "%");
			rset = pstmt.executeQuery();
			if (rset.next())
				totalContent = rset.getInt(1);

		} catch (SQLException e) {
			throw new UserException("관리자 검색된 회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContent;
	}
	// ##########jaekyung UserDao end#############
}
