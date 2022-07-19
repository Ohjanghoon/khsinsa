package com.kh.sinsa.inquire.model.dao;


import static com.kh.sinsa.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.inquire.model.exception.InquireException;

public class InquireDao {

	private static Properties prop = new Properties();

	public InquireDao() {
		String filename = InquireDao.class.getResource("/sql/inquire/inquire-query.properties").getPath();

		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	

	public List<Inquire> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Inquire> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
//			pstmt.setString(1, (String) param.get("inquireNo"));
//			pstmt.setString(2, (String) param.get("inquireTitle"));
//			pstmt.setString(3, (String) param.get("userId"));
//			pstmt.setDate(4, (Date) param.get("inquireDate"));
//			pstmt.setString(5, (String) param.get("inquireAnswerRe"));

			rset = pstmt.executeQuery();
			while (rset.next()) {
				list.add(handleinquireResultSet(rset));
			}

		} catch (SQLException e) {
			throw new InquireException("조회목오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	private Inquire handleinquireResultSet(ResultSet rset) throws SQLException {
		String inquireNo = rset.getString("inquire_no");
		String userId = rset.getString("user_id");
		String inquireAnswerRef = rset.getString("inquire_answer_ref");
		String inquireTitle = rset.getString("inquire_title");
		String inquireContent = rset.getString("inquire_content");
		Date inquireDate = rset.getDate("inquire_date");
		String inquireCategory = rset.getString("inquire_category");
		return new Inquire(inquireNo, userId, inquireAnswerRef, inquireTitle, inquireContent, inquireDate,
				inquireCategory);
	}




	public int getTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContent");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new InquireException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}

}
