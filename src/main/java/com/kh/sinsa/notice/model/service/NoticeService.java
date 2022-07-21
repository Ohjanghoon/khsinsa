package com.kh.sinsa.notice.model.service;

import static com.kh.sinsa.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.sinsa.notice.model.dao.NoticeDao;
import com.kh.sinsa.notice.model.dto.Notice;

public class NoticeService {
	private NoticeDao noticeDao = new NoticeDao();

	// 공지사항 글 작성
	public int insertNotice(Notice notice) {
		Connection conn = getConnection();
		int result = 0;

		try {
			result = noticeDao.insertNotice(conn, notice);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	// 공지사항 목록 조회
	public List<Notice> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Notice> result = noticeDao.findAll(conn, param);
		close(conn);
		return result;
	}

	// 공지사항 목록 조회(페이지바 총 갯수)
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = noticeDao.getTotalContent(conn);
		close(conn);
		return totalContent;

	}

	// 공지사항 게시물 상세보기
	public Notice findByNo(int no) {

		return findByNo(no, true);
	}

	public Notice findByNo(int no, boolean hasRead) {
		Connection conn = getConnection();
		Notice notice= null;
		
		try {
			if(!hasRead) {
				int result = noticeDao.updateReadCount(conn, no);
			}
			
			// community 테이블에서 조회
			notice = noticeDao.findByNo(conn, no);
			
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		
		}finally {
			close(conn);
		}
		return notice;

	}
	// 공지사항 게시물 삭제
	public int deleteNotice(int no) {
		Connection conn = getConnection();
		int result = 0;

		try {
			result = noticeDao.deleteNotice(conn, no);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	// 공지사항 게시글 수정
	public int editNotice(Notice notice) {
		Connection conn = getConnection();
		int result = 0;

		try {
			result = noticeDao.editNotice(conn, notice);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}

