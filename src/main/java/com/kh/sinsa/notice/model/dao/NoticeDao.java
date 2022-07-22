package com.kh.sinsa.notice.model.dao;

import static com.kh.sinsa.common.JdbcTemplate.*;

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

import com.kh.sinsa.notice.model.dao.NoticeDao;
import com.kh.sinsa.notice.model.exception.NoticeException;
import com.kh.sinsa.notice.model.dto.Notice;

public class NoticeDao {
	
	private Properties prop = new Properties();

	public NoticeDao() {
		String filename = NoticeDao.class.getResource("/sql/notice/notice-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 공지사항 글 작성
	public int insertNotice(Connection conn, Notice notice) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertNotice");
//		insertNotice = insert into notice (notice_no, notice_title, notice_content, notice_writer) values (seq_notice_notice_no.nextval, ?, ?, ?)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setString(3, notice.getNoticeWriter());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new NoticeException("게시글 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

		// 게시글 목록 조회
	public List<Notice> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Notice> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Notice notice = handlerNoticeResultSet(rset);
				list.add(notice);

			}
		} catch (SQLException e) {
			throw new NoticeException("게시글 목록 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	// 게시글 목록 조회
	private Notice handlerNoticeResultSet(ResultSet rset) throws SQLException {
		int noticeNo = rset.getInt("notice_no");
		String noticeTitle = rset.getString("notice_title");
		String noticeContent = rset.getString("notice_content");
		String noticeWriter = rset.getString("notice_writer");
		Date noticeDate = rset.getDate("notice_date");
		int noticeReadCount = rset.getInt("notice_read_count");
		
		return new Notice(noticeNo, noticeTitle, noticeContent, noticeWriter, noticeDate, noticeReadCount);
	}

	// 게시글 목록 조회 페이지바
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
			throw new NoticeException("총 게시물수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}

		return totalContent;
	}

	public Notice findByNo(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Notice notice = null;
		String sql = prop.getProperty("findByNo");
//		findByNo = select * from notice where notice_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rset = pstmt.executeQuery();
			while (rset.next())
				notice = handlerNoticeResultSet(rset);

		} catch (SQLException e) {
			throw new NoticeException("게시글 1건 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return notice;
	}
	
	public int updateReadCount(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateReadCount");
//		updateReadCount = update notice set notice_read_count = notice_read_count + 1 where notice_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new NoticeException("조회수 증가 오류!", e);
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int deleteNotice(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteNotice");
		// deleteNotice = delete from notice where notice_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new NoticeException("게시글 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int editNotice(Connection conn, Notice notice) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("editnotice");
		// updatenotice = update notice set notice_title = ?, notice_content = ? where notice_no = ?
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getNoticeContent());
			pstmt.setInt(3, notice.getNoticeNo());
			result = pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			throw new NoticeException("게시글 수정 오류!", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}

}
