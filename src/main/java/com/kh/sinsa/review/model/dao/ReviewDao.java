package com.kh.sinsa.review.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.sinsa.review.model.dto.Review;
import com.kh.sinsa.review.model.exception.ReviewException;

public class ReviewDao {
	private Properties prop = new Properties();
	
	public ReviewDao() {
		String filename = ReviewDao.class.getResource("/sql/review/review-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Review> findByReview(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Review> rList = new ArrayList<>();
		String sql = prop.getProperty("findByReview");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setObject(1, param.get("proNo"));
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				rList.add(handleReviewResultSet(rset));
			}
		} catch (SQLException e) {
			throw new ReviewException("리뷰 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return rList;
	}

	private Review handleReviewResultSet(ResultSet rset) throws SQLException {
		String reviewNo = rset.getString("review_no");
		String proNo = rset.getString("pro_no");
		int orderNo = rset.getInt("order_no");
		String reviewWriter = rset.getString("review_writer");
		String reviewContent = rset.getString("review_content");
		String reviewOriginalFilename = rset.getString("review_original_filename");
		String reviewRenamedFilename = rset.getString("review_renamed_filename");
		Timestamp reviewDate = rset.getTimestamp("review_date");
		int reviewRecommend = rset.getInt("review_recommend");
		return new Review(reviewNo, proNo, orderNo, reviewWriter, reviewContent, reviewOriginalFilename, reviewRenamedFilename, reviewDate, reviewRecommend);
	}

	public int getTotalReview(Connection conn, String proNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalReview = 0;
		String sql = prop.getProperty("getTotalReview");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, proNo);
			rset = pstmt.executeQuery();
			while(rset.next())
				totalReview = rset.getInt(1);
		} catch (SQLException e) {
			throw new ReviewException("리뷰갯수 조회 오류!", e);
			
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalReview;
	}
	
}
