package com.kh.sinsa.community.model.dao;

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

import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.community.model.exception.CommunityException;


public class CommunityDao {
	
	private Properties prop = new Properties();
	
	public CommunityDao() {
		String filename = CommunityDao.class.getResource("/sql/community/community-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private Community handlerCommunityResultSet(ResultSet rset) throws SQLException {
		String commNo = rset.getString("comm_no");
		String userId = rset.getString("user_id");
		String commTitle = rset.getString("comm_title");
		String commContent = rset.getString("comm_content");
		Date commDate = rset.getDate("comm_date");
		int commRecommend = rset.getInt("comm_recommend");
		int commReadCount = rset.getInt("comm_readCount");
		
		return new Community(commNo, userId, commTitle, commContent, commDate, commRecommend, commReadCount);
	}

	public List<Community> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Community> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Community communtiy = handlerCommunityResultSet(rset);
				list.add(communtiy);
				
			}
		} catch (SQLException e) {
			throw new CommunityException("게시글 목록 오류", e);
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
			if(rset.next())
				totalContent = rset.getInt(1);
		} catch (SQLException e) {
			throw new CommunityException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}

}
