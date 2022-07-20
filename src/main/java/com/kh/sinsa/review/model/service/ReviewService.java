package com.kh.sinsa.review.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.review.model.dao.ReviewDao;
import com.kh.sinsa.review.model.dto.Review;

public class ReviewService {
	
	private ReviewDao reviewDao = new ReviewDao();
	
	public List<Review> findByReview(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Review> rList = reviewDao.findByReview(conn,param);
		close(conn);
		return rList;
	}

	public int getTotalReview(String proNo) {
		Connection conn = getConnection();
		int totalReview = reviewDao.getTotalReview(conn, proNo);
		close(conn);
		return totalReview;
	}

}
