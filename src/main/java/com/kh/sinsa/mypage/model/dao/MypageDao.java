package com.kh.sinsa.mypage.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.close;

import java.io.FileReader;
import java.sql.Array;
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

import com.kh.sinsa.community.model.dto.Community;
import com.kh.sinsa.inquire.model.dto.Inquire;
import com.kh.sinsa.inquire.model.dto.InquireExt;
import com.kh.sinsa.mypage.model.exception.MypageException;
import com.kh.sinsa.review.model.dto.Review;
import com.kh.sinsa.user.model.dao.UserDao;

public class MypageDao {

	private Properties prop = new Properties();
	
	public MypageDao(){
		String filename = UserDao.class.getResource("/sql/mypage/mypage-query.properties").getPath();
		
		try {
			prop.load(new FileReader(filename));
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//##########janghoon MypageDao begin#############
	//내 1:1 문의글 조회
	public List<Inquire> inquireListFindById(Connection conn, String userId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Inquire> list = new ArrayList<>();
		String sql = prop.getProperty("inquireListFindById");
		//inquireListFindById = select * from ( select row_number() over(order by inquire_date desc) rnum, i.* from inquire i ) i where rnum between ? and ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				InquireExt inquireExt = handleInquireResultSet(rset);
				inquireExt.setAnswerStatus(rset.getInt("answer_status"));
				list.add(inquireExt);
			}
		} catch (SQLException e) {
			throw new MypageException("내 문의글 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
		
	private InquireExt handleInquireResultSet(ResultSet rset) throws SQLException {
		String inquireNo = rset.getString("inquire_no");
		String userId = rset.getString("user_id");
		String inquireAnswerRef = rset.getString("inquire_answer_ref");
		String inquireTitle = rset.getString("inquire_title");
		String inquireContent = rset.getString("inquire_content");
		Date inquireDate = rset.getDate("inquire_date");
		String inquireCategory = rset.getString("inquire_category");
		
		return new InquireExt(inquireNo, userId, inquireAnswerRef, inquireTitle, inquireContent, inquireDate, inquireCategory);
	}

	// 내 1:1문의글 수 조회
	public int getTotalMyInquireContent(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalMyInquireContent = 0;
		String sql = prop.getProperty("totalMyInquireContent");
		// getTotalMyInquireContent = select count(*) from inquire where user_id = ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				totalMyInquireContent = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new MypageException("내 문의글 수 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalMyInquireContent;
	}
	
	//내 1:1문의글 삭제
	public int myInquireDelete(Connection conn, String[] inquireList) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("myInquireDelete");
		// myInquireDelete = delete from inquire where inquire_no = ?  => in 절대 쓰지 말것(악의 축, 악인전, 악의 근원, 악마, 사탄, 지옥)
		try {
			for(String inquireNo : inquireList) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setObject(1, inquireNo);

				result = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			throw new MypageException("내 문의글 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	//내 커뮤니티글 조회
	public List<Community> communityListFindById(Connection conn, String userId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Community> list = new ArrayList<>();
		String sql = prop.getProperty("communityListFindById");
		//communityListFindById = select * from (select row_number() over(order by comm_date desc) rnum, c.*
		// 							from community c where user_id = ?) c where rnum between ? and ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				list.add(handleCommunityResultSet(rset));
			}
		} catch (SQLException e) {
			throw new MypageException("내 커뮤니티글 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	private Community handleCommunityResultSet(ResultSet rset) throws SQLException {
		String commNo = rset.getString("comm_no");
		String userId = rset.getString("user_id");
		String commTitle = rset.getString("comm_title");
		String commContent = rset.getString("comm_content");
		Date commDate = rset.getDate("comm_date");
		int commRecommend = rset.getInt("comm_recommend");
		int commReadcount = rset.getInt("comm_readcount");
		
		return new Community(commNo, userId, commTitle, commContent, commDate, commRecommend, commReadcount);
	}

	//내 커뮤니티글 수 조회
	public int getTotalMyCommunityContent(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalMyCommunityContent = 0;
		String sql = prop.getProperty("totalMyCommunityContent");
		//totalMyCommunityContent = select count(*) from community where user_id = ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalMyCommunityContent = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new MypageException("내 커뮤니티글 수 조회 오류", e);
		}
		return totalMyCommunityContent;
	}

	//내 커뮤니티글 삭제
	public int myCommunityDelete(Connection conn, String[] communityList) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("myCommunityDelete");
		// myCommunityDelete = delete from community where comm_no = ?
		try {
			for(String commNo : communityList) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setObject(1, commNo);

				result = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			throw new MypageException("내 커뮤니티글 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	//내 리뷰글 조회
	public List<Review> reviewListFindById(Connection conn, String userId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Review> list = new ArrayList<>();
		String sql = prop.getProperty("reviewListFindById");
		//reviewListFindById = select * from (select row_number() over(order by review_date desc) rnum, r.*
		// 						from review r where user_id = ?) r where rnum between ? and ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				list.add(handleReviewResultSet(rset));
			}
		
		} catch (SQLException e) {
			throw new MypageException("내 리뷰글 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
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
	
	//내 리뷰글 수 조회
	public int getTotalMyReviewContent(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalMyReviewContent = 0;
		String sql = prop.getProperty("totalMyReviewContent");
		//totalMyReviewContent = select count(*) from review where review_writer = ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalMyReviewContent = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new MypageException("내 리뷰글 수 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalMyReviewContent;
	}

	//내 리뷰글 삭제
	public int myReviewDelete(Connection conn, String[] reviewList) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("myReviewDelete");
		// myReviewDelete = delete from review where review_no = ?
		try {
			for(String reviewNo : reviewList) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setObject(1, reviewNo);

				result = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			throw new MypageException("내 리뷰글 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}


	
	//##########janghoon MypageDao end#############
}
