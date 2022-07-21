package com.kh.sinsa.mypage.model.service;

import static com.kh.sinsa.common.JdbcTemplate.close;
import static com.kh.sinsa.common.JdbcTemplate.commit;
import static com.kh.sinsa.common.JdbcTemplate.getConnection;
import static com.kh.sinsa.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.mypage.model.dao.MypageDao;
import com.kh.sinsa.order.model.dto.Order;
import com.kh.sinsa.review.model.dto.Review;

public class MypageService {
	
	private MypageDao mypageDao = new MypageDao();
	
	//##########janghoon MypageService begin#############
	//내 1:1 문의글 조회
	public List<Inquire> inquireListFindById(String userId, Map<String, Object> param) {
		Connection conn = null;
		List<Inquire> list = null;
		try {
			conn = getConnection();
			list = mypageDao.inquireListFindById(conn, userId, param);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return list;
	}
	
	// 내 1:1문의글 수 조회
	public int getTotalMyInquireContent(String userId) {
		Connection conn = null;
		int totalMyInquireContent = 0;
		try {
			conn = getConnection();
			totalMyInquireContent = mypageDao.getTotalMyInquireContent(conn, userId);
		} catch (Exception e) {
			throw e;
		} finally {
			close(conn);
		}
		return totalMyInquireContent;
	}

	//내 1:1문의글 삭제
	public int myInquireDelete(String[] inquireList) {
		Connection conn = null;
		int result = 0;
		try {
			conn = getConnection();
			result = mypageDao.myInquireDelete(conn, inquireList);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	//내 커뮤니티글 조회
	public List<Community> communityListFindById(String userId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Community> list = mypageDao.communityListFindById(conn, userId, param);
		close(conn);
		return list;
	}

	//내 커뮤니티글 수 조회
	public int getTotalMyCommunityContent(String userId) {
		Connection conn = getConnection();
		int totalMyCommunityContent = mypageDao.getTotalMyCommunityContent(conn, userId);
		close(conn);
		return totalMyCommunityContent;
	}
	
	//내 커뮤니티글 삭제
	public int myCommunityDelete(String[] communityList) {
		Connection conn = null;
		int result = 0;
		try {
			conn = getConnection();
			result = mypageDao.myCommunityDelete(conn, communityList);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	//내 리뷰글 조회
	public List<Review> reviewListFindById(String userId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Review> list = mypageDao.reviewListFindById(conn, userId, param);
		close(conn);
		return list;
	}
	//내 리뷰글 수 조회
	public int getTotalMyReviewContent(String userId) {
		Connection conn = getConnection();
		int totalMyReviewContent = mypageDao.getTotalMyReviewContent(conn, userId);
		close(conn);
		return totalMyReviewContent;
	}
	//내 리뷰글 삭제
	public int myReviewDelete(String[] reviewList) {
		Connection conn = null;
		int result = 0;
		try {
			conn = getConnection();
			result = mypageDao.myReviewDelete(conn, reviewList);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	//내 주문내역 조회
	public List<Order> orderListFindById(String userId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Order> list = mypageDao.orderListFindById(conn, userId, param);
		close(conn);
		return list;
	}
	
	//내 주문내역 수 조회
	public int getTotalMyOrderListContent(String userId) {
		Connection conn = getConnection();
		int totalMyOrderListContent = mypageDao.getTotalMyOrderListContent(conn, userId);
		close(conn);
		return totalMyOrderListContent;
	}



	//##########janghoon MypageService end#############
}
